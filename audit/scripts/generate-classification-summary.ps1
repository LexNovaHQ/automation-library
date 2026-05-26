$RepoRoot = (Get-Location).Path
$ClassificationPath = Join-Path $RepoRoot "audit\config\component-classification.csv"
$ReportPath = Join-Path $RepoRoot "audit\reports\classification-summary.md"

if (!(Test-Path $ClassificationPath)) {
  throw "Missing classification CSV at $ClassificationPath"
}

$Rows = Import-Csv $ClassificationPath
$Now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$Lines = New-Object System.Collections.Generic.List[string]

$Lines.Add("# Classification Summary")
$Lines.Add("")
$Lines.Add("Generated: $Now")
$Lines.Add("")
$Lines.Add("## Layer Type Counts")
$Lines.Add("")
$Lines.Add("| Layer Type | Count |")
$Lines.Add("|---|---:|")

$Rows |
  Group-Object layer_type |
  Sort-Object Name |
  ForEach-Object {
    $Lines.Add("| $($_.Name) | $($_.Count) |")
  }

$Lines.Add("")
$Lines.Add("## Readiness Counts")
$Lines.Add("")
$Lines.Add("| Readiness | Count |")
$Lines.Add("|---|---:|")

$Rows |
  Group-Object readiness |
  Sort-Object Name |
  ForEach-Object {
    $Lines.Add("| $($_.Name) | $($_.Count) |")
  }

$Lines.Add("")
$Lines.Add("## Priority Counts")
$Lines.Add("")
$Lines.Add("| Priority | Count |")
$Lines.Add("|---|---:|")

$Rows |
  Group-Object priority |
  Sort-Object Name |
  ForEach-Object {
    $Lines.Add("| $($_.Name) | $($_.Count) |")
  }

$Lines.Add("")
$Lines.Add("## P0 Items")
$Lines.Add("")
$Lines.Add("| ID | Name | Layer Type | Readiness |")
$Lines.Add("|---|---|---|---|")

$Rows |
  Where-Object { $_.priority -eq "P0" } |
  Sort-Object layer_type, component_id |
  ForEach-Object {
    $Lines.Add("| $($_.component_id) | $($_.component_name) | $($_.layer_type) | $($_.readiness) |")
  }

$Lines.Add("")
$Lines.Add("## Built Items")
$Lines.Add("")
$Lines.Add("| ID | Name | Layer Type | Execution Level |")
$Lines.Add("|---|---|---|---|")

$Rows |
  Where-Object { $_.readiness -eq "BUILT" } |
  Sort-Object layer_type, component_id |
  ForEach-Object {
    $Lines.Add("| $($_.component_id) | $($_.component_name) | $($_.layer_type) | $($_.execution_level) |")
  }

$Lines | Set-Content -Encoding UTF8 $ReportPath

Get-Content $ReportPath
