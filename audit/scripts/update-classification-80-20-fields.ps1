$ErrorActionPreference = "Stop"

$RepoRoot = (Get-Location).Path
$ClassificationPath = Join-Path $RepoRoot "audit\config\component-classification.csv"
$AuditCsvPath = Join-Path $RepoRoot "audit\reports\primary-category-80-20-audit.csv"
$ReportPath = Join-Path $RepoRoot "audit\reports\classification-80-20-update.md"

if (!(Test-Path $ClassificationPath)) { throw "Missing classification CSV: $ClassificationPath" }
if (!(Test-Path $AuditCsvPath)) { throw "Missing 80/20 audit CSV. Run audit-primary-category-80-20.ps1 first." }

$Rows = Import-Csv $ClassificationPath
$AuditRows = Import-Csv $AuditCsvPath
$AuditById = @{}
foreach ($a in $AuditRows) { $AuditById[$a.component_id] = $a }

function Get-PrimaryJob {
  param([object]$Row)
  switch ($Row.layer_type) {
    "CORE_COMPONENT" { return "Reusable workflow logic for " + $Row.component_name }
    "HANDOFF_ONLY_CORE" { return "Prepare provider-neutral handoff for " + $Row.component_name }
    "COMPONENT_ADAPTER" { return "Execute provider-specific adapter job for " + $Row.adapter_for }
    "INDEPENDENT_ADAPTER" { return "Reusable external-system connector" }
    "CLIENT_CONFIG_ASSET" { return "Client configuration and implementation asset" }
    "TEMPLATE_GLUE" { return "Client-ready workflow assembly" }
    "SCAFFOLD_ONLY" { return "Future component placeholder" }
    default { return "Review required" }
  }
}

function Get-BorrowedByCategories {
  param([object]$Row)

  if ($Row.layer_type -eq "CORE_COMPONENT" -and $Row.component_id -match "^C4-") { return "Category 2; Category 3; Category 5" }
  if ($Row.layer_type -eq "CORE_COMPONENT" -and $Row.component_id -match "^C5-") { return "Category 2; Category 3; Category 4; Category 6" }
  if ($Row.layer_type -eq "CORE_COMPONENT" -and $Row.component_id -match "^C6-") { return "Category 2; Category 3; Category 4; Category 5" }
  if ($Row.layer_type -eq "COMPONENT_ADAPTER") { return "Templates; parent core components" }
  if ($Row.layer_type -eq "HANDOFF_ONLY_CORE") { return "Template glue workflows; provider adapters" }
  if ($Row.layer_type -eq "INDEPENDENT_ADAPTER") { return "All categories as needed" }
  if ($Row.layer_type -eq "CLIENT_CONFIG_ASSET") { return "All client-facing templates" }
  if ($Row.layer_type -eq "TEMPLATE_GLUE") { return "Commercial template layer" }
  return "N/A"
}

function Get-BuildStandardNotes {
  param([object]$Row, [string]$Status)

  if ($Row.component_id -eq "ADP-REST") {
    return "Built for declared basic/no-auth REST execution scope; auth/OAuth/header-secret variants remain future expansion."
  }

  if ($Row.component_id -eq "ADP-WEBHOOK-SEND") {
    return "Built for declared generic outbound webhook scope; signing/auth/retry-policy variants remain future expansion."
  }

  if ($Status -eq "PASS_HANDOFF_ONLY") {
    return "Passes 80/20 standard as a handoff router; live provider execution belongs to attached adapters."
  }

  if ($Status -eq "PASS_CONFIG_ASSET") {
    return "Passes 80/20 standard as a configuration/documentation asset, not as an executable workflow."
  }

  if ($Status -eq "PASS_80_20") {
    return "Passes artifact and declared-job 80/20 standard."
  }

  if ($Status -eq "SCAFFOLD_ONLY") { return "README-only scaffold; not sold as built." }
  if ($Status -eq "DEFERRED") { return "Deferred adapter; not built yet." }
  if ($Status -eq "NOT_BUILT") { return "Planned item; not built yet." }

  return "Review required."
}

$UpdatedRows = foreach ($row in $Rows) {
  $audit = $AuditById[$row.component_id]

  $primaryCategory = if ($audit) { $audit.primary_category } else { "UNCLASSIFIED" }
  $productionStatus = if ($audit) { $audit.production_80_20_status } else { "REVIEW_REQUIRED" }
  $primaryJob = Get-PrimaryJob -Row $row
  $borrowedBy = Get-BorrowedByCategories -Row $row
  $standardNotes = Get-BuildStandardNotes -Row $row -Status $productionStatus

  [pscustomobject]@{
    component_id = $row.component_id
    component_name = $row.component_name
    folder_path = $row.folder_path
    primary_category = $primaryCategory
    primary_job = $primaryJob
    borrowed_by_categories = $borrowedBy
    layer_type = $row.layer_type
    readiness = $row.readiness
    execution_level = $row.execution_level
    adapter_for = $row.adapter_for
    provider = $row.provider
    priority = $row.priority
    template_ready = $row.template_ready
    production_80_20_status = $productionStatus
    build_standard_notes = $standardNotes
    depends_on = $row.depends_on
    used_by = $row.used_by
    notes = $row.notes
  }
}

$UpdatedRows | Export-Csv -NoTypeInformation -Encoding UTF8 $ClassificationPath

$Now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$Lines = New-Object System.Collections.Generic.List[string]
$Lines.Add("# Classification 80/20 Field Update")
$Lines.Add("")
$Lines.Add("Generated: $Now")
$Lines.Add("")
$Lines.Add("## Production 80/20 Status Counts")
$Lines.Add("")
$Lines.Add("| Status | Count |")
$Lines.Add("|---|---:|")
$UpdatedRows | Group-Object production_80_20_status | Sort-Object Name | ForEach-Object { $Lines.Add("| $($_.Name) | $($_.Count) |") }
$Lines.Add("")
$Lines.Add("## Discussion Scope Items")
$Lines.Add("")
$ScopeItems = @($UpdatedRows | Where-Object { $_.production_80_20_status -eq "PASS_80_20_FOR_DECLARED_SCOPE" })
if ($ScopeItems.Count -eq 0) {
  $Lines.Add("None.")
} else {
  $Lines.Add("| ID | Name | Notes |")
  $Lines.Add("|---|---|---|")
  foreach ($item in $ScopeItems) {
    $safeNotes = ($item.build_standard_notes -replace "\|", "\|")
    $Lines.Add("| $($item.component_id) | $($item.component_name) | $safeNotes |")
  }
}
$Lines | Set-Content -Encoding UTF8 $ReportPath
Get-Content $ReportPath
