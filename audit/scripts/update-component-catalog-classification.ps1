$ErrorActionPreference = "Stop"

$RepoRoot = (Get-Location).Path
$CatalogPath = Join-Path $RepoRoot "docs\component-catalog.md"
$ClassificationPath = Join-Path $RepoRoot "audit\config\component-classification.csv"
$ReportPath = Join-Path $RepoRoot "audit\reports\catalog-classification-update.md"

if (!(Test-Path $CatalogPath)) {
  throw "Missing catalog at $CatalogPath"
}

if (!(Test-Path $ClassificationPath)) {
  throw "Missing classification CSV at $ClassificationPath"
}

function Escape-Regex {
  param([string]$Value)
  return [regex]::Escape($Value)
}

function Build-ClassificationBlock {
  param($Row)

  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("**Architecture Classification:**")
  $lines.Add("- Layer type: ``$($Row.layer_type)``")
  $lines.Add("- Readiness: ``$($Row.readiness)``")
  $lines.Add("- Execution level: ``$($Row.execution_level)``")
  $lines.Add("- Adapter for: ``$($Row.adapter_for)``")
  $lines.Add("- Provider: ``$($Row.provider)``")
  $lines.Add("- Priority: ``$($Row.priority)``")
  $lines.Add("- Template ready: ``$($Row.template_ready)``")
  $lines.Add("")
  return ($lines -join "`r`n")
}

$catalog = Get-Content $CatalogPath -Raw
$rows = Import-Csv $ClassificationPath

# Only patch active built repo components in component-catalog.md.
# Skip future/deferred adapters, template glues, client config assets, and scaffold-only rows.
$activeRows = @(
  $rows |
    Where-Object {
      $_.readiness -eq "BUILT" -and
      $_.component_id -match "^C\d+-"
    } |
    Sort-Object component_id
)

$updated = New-Object System.Collections.Generic.List[string]
$missing = New-Object System.Collections.Generic.List[string]
$skipped = New-Object System.Collections.Generic.List[string]

foreach ($row in $activeRows) {
  $componentId = $row.component_id
  $block = Build-ClassificationBlock -Row $row

  # Match from this component build-record heading until the next build-record heading or EOF.
  $sectionPattern = "(?ms)^##\s+$([regex]::Escape($componentId))\s+Build Record[^\r\n]*\r?\n.*?(?=^##\s+C\d+-[A-Z0-9]+\s+Build Record|\z)"
  $sectionMatch = [regex]::Match($catalog, $sectionPattern)

  if (-not $sectionMatch.Success) {
    $missing.Add($componentId)
    continue
  }

  $section = $sectionMatch.Value

  if ($section -match "\*\*Architecture Classification:\*\*") {
    # Replace existing architecture classification block.
    $sectionUpdated = [regex]::Replace(
      $section,
      "(?ms)\*\*Architecture Classification:\*\*\r?\n- Layer type:.*?(?=\r?\n\*\*|\r?\n##|\z)",
      $block.TrimEnd()
    )
  }
  else {
    # Insert after Last tested line if present; otherwise after Status line.
    if ($section -match "\*\*Last tested:\*\*[^\r\n]*(\r?\n)") {
      $sectionUpdated = [regex]::Replace(
        $section,
        "(\*\*Last tested:\*\*[^\r\n]*\r?\n)",
        "`$1`r`n$block",
        1
      )
    }
    elseif ($section -match "\*\*Status:\*\*[^\r\n]*(\r?\n)") {
      $sectionUpdated = [regex]::Replace(
        $section,
        "(\*\*Status:\*\*[^\r\n]*\r?\n)",
        "`$1`r`n$block",
        1
      )
    }
    else {
      $sectionUpdated = $section + "`r`n" + $block
    }
  }

  $catalog = $catalog.Remove($sectionMatch.Index, $sectionMatch.Length).Insert($sectionMatch.Index, $sectionUpdated)
  $updated.Add($componentId)
}

Set-Content -Encoding UTF8 $CatalogPath $catalog

$now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$report = New-Object System.Collections.Generic.List[string]
$report.Add("# Catalog Classification Update")
$report.Add("")
$report.Add("Generated: $now")
$report.Add("")
$report.Add("## Updated built component records")
$report.Add("")
if ($updated.Count -eq 0) {
  $report.Add("None.")
} else {
  foreach ($id in ($updated | Sort-Object)) {
    $report.Add("- $id")
  }
}

$report.Add("")
$report.Add("## Missing built component records")
$report.Add("")
if ($missing.Count -eq 0) {
  $report.Add("None.")
} else {
  foreach ($id in ($missing | Sort-Object)) {
    $report.Add("- $id")
  }
}

$report.Add("")
$report.Add("## Skipped")
$report.Add("")
$report.Add("Rows not marked as `BUILT` or not using a component ID beginning with `C` were intentionally skipped.")

$report | Set-Content -Encoding UTF8 $ReportPath

Get-Content $ReportPath
