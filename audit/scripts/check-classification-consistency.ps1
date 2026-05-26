$ErrorActionPreference = "Stop"

$RepoRoot = (Get-Location).Path
$ClassificationPath = Join-Path $RepoRoot "audit\config\component-classification.csv"
$InventoryPath = Join-Path $RepoRoot "audit\reports\component-inventory.csv"
$CatalogPath = Join-Path $RepoRoot "docs\component-catalog.md"
$ReportPath = Join-Path $RepoRoot "audit\reports\classification-consistency.md"

if (!(Test-Path $ClassificationPath)) {
  throw "Missing classification CSV at $ClassificationPath"
}

if (!(Test-Path $InventoryPath)) {
  throw "Missing component inventory at $InventoryPath. Run audit/scripts/run-repo-audit.ps1 first."
}

if (!(Test-Path $CatalogPath)) {
  throw "Missing component catalog at $CatalogPath"
}

$Rows = Import-Csv $ClassificationPath
$Inventory = Import-Csv $InventoryPath
$CatalogText = Get-Content $CatalogPath -Raw
$Now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$ValidLayerTypes = @(
  "CORE_COMPONENT",
  "COMPONENT_ADAPTER",
  "INDEPENDENT_ADAPTER",
  "TEMPLATE_GLUE",
  "CLIENT_CONFIG_ASSET",
  "SCAFFOLD_ONLY",
  "DEFERRED_ADAPTER",
  "HANDOFF_ONLY_CORE"
)

$ValidReadiness = @(
  "BUILT",
  "NOT_BUILT",
  "DEFERRED_ADAPTER"
)

$ValidExecutionLevels = @(
  "core_logic",
  "provider_execution",
  "handoff_only",
  "template_glue",
  "config_asset",
  "none"
)

$Issues = New-Object System.Collections.Generic.List[object]

function Add-Issue {
  param(
    [string]$Severity,
    [string]$Code,
    [string]$ComponentId,
    [string]$Message
  )

  $script:Issues.Add([pscustomobject]@{
    severity = $Severity
    code = $Code
    component_id = $ComponentId
    message = $Message
  })
}

# 1. Duplicate component IDs in classification CSV
$Rows |
  Group-Object component_id |
  Where-Object { $_.Count -gt 1 } |
  ForEach-Object {
    Add-Issue -Severity "FAIL" -Code "DUPLICATE_CLASSIFICATION_ID" -ComponentId $_.Name -Message "component_id appears $($_.Count) times in component-classification.csv"
  }

# 2. Validate enums
foreach ($row in $Rows) {
  if ($ValidLayerTypes -notcontains $row.layer_type) {
    Add-Issue -Severity "FAIL" -Code "INVALID_LAYER_TYPE" -ComponentId $row.component_id -Message "Invalid layer_type: $($row.layer_type)"
  }

  if ($ValidReadiness -notcontains $row.readiness) {
    Add-Issue -Severity "FAIL" -Code "INVALID_READINESS" -ComponentId $row.component_id -Message "Invalid readiness: $($row.readiness)"
  }

  if ($ValidExecutionLevels -notcontains $row.execution_level) {
    Add-Issue -Severity "FAIL" -Code "INVALID_EXECUTION_LEVEL" -ComponentId $row.component_id -Message "Invalid execution_level: $($row.execution_level)"
  }
}

# 3. Built component rows must have folder + catalog record
$BuiltComponentRows = @(
  $Rows |
    Where-Object {
      $_.readiness -eq "BUILT" -and
      $_.component_id -match "^C\d+-"
    }
)

foreach ($row in $BuiltComponentRows) {
  $folder = Join-Path $RepoRoot $row.folder_path

  if (!(Test-Path $folder)) {
    Add-Issue -Severity "FAIL" -Code "BUILT_FOLDER_MISSING" -ComponentId $row.component_id -Message "Built row points to missing folder: $($row.folder_path)"
  }

  $catalogPattern = "##\s+$([regex]::Escape($row.component_id))\s+Build Record"
  if ($CatalogText -notmatch $catalogPattern) {
    Add-Issue -Severity "FAIL" -Code "BUILT_CATALOG_RECORD_MISSING" -ComponentId $row.component_id -Message "Built row has no matching build record in component-catalog.md"
  }
}

# 4. Repo built folders must exist in classification CSV
$BuiltInventoryRows = @(
  $Inventory |
    Where-Object {
      [int]$_.workflow_json_count -ge 1 -and
      [int]$_.test_payload_count -ge 1 -and
      [int]$_.output_sample_count -ge 1
    }
)

foreach ($item in $BuiltInventoryRows) {
  $match = @($Rows | Where-Object { $_.component_id -eq $item.component_id -and $_.readiness -eq "BUILT" })

  if ($match.Count -eq 0) {
    Add-Issue -Severity "FAIL" -Code "BUILT_FOLDER_NOT_CLASSIFIED" -ComponentId $item.component_id -Message "Repo has built folder but classification CSV has no BUILT row for this component_id"
  }
}

# 5. Scaffold-only inventory rows should be either classified as SCAFFOLD_ONLY or intentionally omitted? We require classification now.
$ScaffoldInventoryRows = @(
  $Inventory |
    Where-Object {
      $_.readme_present -eq "True" -and
      [int]$_.workflow_json_count -eq 0 -and
      [int]$_.test_payload_count -eq 0 -and
      [int]$_.output_sample_count -eq 0
    }
)

foreach ($item in $ScaffoldInventoryRows) {
  $match = @($Rows | Where-Object { $_.component_id -eq $item.component_id -and $_.layer_type -eq "SCAFFOLD_ONLY" })

  if ($match.Count -eq 0) {
    Add-Issue -Severity "WARN" -Code "SCAFFOLD_FOLDER_NOT_CLASSIFIED" -ComponentId $item.component_id -Message "Repo has scaffold-only folder but classification CSV has no SCAFFOLD_ONLY row"
  }
}

# 6. Built component rows should not be marked template_ready No unless handoff caveat exists.
foreach ($row in $BuiltComponentRows) {
  if ($row.template_ready -eq "No") {
    Add-Issue -Severity "WARN" -Code "BUILT_NOT_TEMPLATE_READY" -ComponentId $row.component_id -Message "Built component is marked template_ready=No"
  }
}

# Generate report
$FailCount = @($Issues | Where-Object { $_.severity -eq "FAIL" }).Count
$WarnCount = @($Issues | Where-Object { $_.severity -eq "WARN" }).Count

$Lines = New-Object System.Collections.Generic.List[string]
$Lines.Add("# Classification Consistency")
$Lines.Add("")
$Lines.Add("Generated: $Now")
$Lines.Add("")
$Lines.Add("## Summary")
$Lines.Add("")
$Lines.Add("| Metric | Count |")
$Lines.Add("|---|---:|")
$Lines.Add("| Classification rows | $($Rows.Count) |")
$Lines.Add("| Built component rows | $($BuiltComponentRows.Count) |")
$Lines.Add("| Built repo folders | $($BuiltInventoryRows.Count) |")
$Lines.Add("| Scaffold-only repo folders | $($ScaffoldInventoryRows.Count) |")
$Lines.Add("| FAIL issues | $FailCount |")
$Lines.Add("| WARN issues | $WarnCount |")
$Lines.Add("")
$Lines.Add("## Issues")
$Lines.Add("")

if ($Issues.Count -eq 0) {
  $Lines.Add("None.")
} else {
  $Lines.Add("| Severity | Code | Component | Message |")
  $Lines.Add("|---|---|---|---|")

  foreach ($issue in ($Issues | Sort-Object severity, code, component_id)) {
    $safeMessage = ($issue.message -replace "\|", "\|") -replace "`r?`n", " "
    $Lines.Add("| $($issue.severity) | $($issue.code) | $($issue.component_id) | $safeMessage |")
  }
}

$Lines | Set-Content -Encoding UTF8 $ReportPath

Get-Content $ReportPath

if ($FailCount -gt 0) {
  exit 1
}
