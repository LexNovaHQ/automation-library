$ErrorActionPreference = "Stop"

$RepoRoot = (Get-Location).Path
$ClassificationPath = Join-Path $RepoRoot "audit\config\component-classification.csv"
$InventoryPath = Join-Path $RepoRoot "audit\reports\component-inventory.csv"
$CsvReport = Join-Path $RepoRoot "audit\reports\primary-category-80-20-audit.csv"
$MdReport = Join-Path $RepoRoot "audit\reports\primary-category-80-20-audit.md"

if (!(Test-Path $ClassificationPath)) { throw "Missing classification CSV: $ClassificationPath" }

if (!(Test-Path $InventoryPath)) {
  if (Test-Path (Join-Path $RepoRoot "audit\scripts\run-repo-audit.ps1")) {
    & (Join-Path $RepoRoot "audit\scripts\run-repo-audit.ps1") | Out-Null
  }
}

$Rows = Import-Csv $ClassificationPath
$Inventory = @()
if (Test-Path $InventoryPath) { $Inventory = Import-Csv $InventoryPath }
$Now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

function Get-PrimaryCategory {
  param([string]$ComponentId, [string]$LayerType)

  if ($ComponentId -match "^C1-") { return "Category 1 - Outreach / Sequencing" }
  if ($ComponentId -match "^C2-") { return "Category 2 - Automation Workflows" }
  if ($ComponentId -match "^C3-") { return "Category 3 - Client Onboarding / Delivery" }
  if ($ComponentId -match "^C4-") { return "Category 4 - AI Workflow Systems" }
  if ($ComponentId -match "^C5-") { return "Category 5 - Dashboards / Status / Review" }
  if ($ComponentId -match "^C6-") { return "Category 6 - Debugging / Reliability" }
  if ($ComponentId -match "^ADP-") { return "Universal Adapter Layer" }
  if ($ComponentId -match "^TPL-") { return "Template Glue Layer" }
  if ($ComponentId -match "^CFG-") { return "Client Config Layer" }
  return "UNCLASSIFIED"
}

function Test-JsonFile {
  param([string]$FilePath)
  try {
    $null = Get-Content $FilePath -Raw | ConvertFrom-Json
    return $true
  } catch {
    return $false
  }
}

function Get-ArtifactProfile {
  param([string]$FolderPath)

  $absolute = Join-Path $RepoRoot $FolderPath

  $profile = [ordered]@{
    folder_exists = $false
    readme_present = $false
    workflow_json_count = 0
    test_payload_count = 0
    output_sample_count = 0
    valid_workflow_json_count = 0
    invalid_workflow_json_count = 0
    n8n_node_count_total = 0
    code_node_count = 0
    trigger_node_count = 0
    credential_reference_count = 0
  }

  if (!(Test-Path $absolute)) { return $profile }

  $profile.folder_exists = $true
  $profile.readme_present = Test-Path (Join-Path $absolute "README.md")

  $workflowFiles = @()
  $workflowDir = Join-Path $absolute "workflows"
  if (Test-Path $workflowDir) { $workflowFiles = @(Get-ChildItem $workflowDir -Filter "*.json" -File -ErrorAction SilentlyContinue) }

  $payloadDir = Join-Path $absolute "test-payloads"
  if (Test-Path $payloadDir) { $profile.test_payload_count = @(Get-ChildItem $payloadDir -Filter "*.json" -File -ErrorAction SilentlyContinue).Count }

  $sampleDir = Join-Path $absolute "output-samples"
  if (Test-Path $sampleDir) { $profile.output_sample_count = @(Get-ChildItem $sampleDir -Filter "*.json" -File -ErrorAction SilentlyContinue).Count }

  $profile.workflow_json_count = $workflowFiles.Count

  foreach ($wf in $workflowFiles) {
    try {
      $json = Get-Content $wf.FullName -Raw | ConvertFrom-Json
      $profile.valid_workflow_json_count += 1

      if ($json.nodes) {
        $profile.n8n_node_count_total += @($json.nodes).Count
        foreach ($node in @($json.nodes)) {
          $nodeType = "" + $node.type
          $nodeName = "" + $node.name
          if ($nodeType -match "code" -or $nodeName -match "Code") { $profile.code_node_count += 1 }
          if ($nodeType -match "trigger" -or $nodeName -match "Trigger") { $profile.trigger_node_count += 1 }
          if ($node.credentials) { $profile.credential_reference_count += 1 }
        }
      }
    } catch {
      $profile.invalid_workflow_json_count += 1
    }
  }

  return $profile
}

function Get-ProductionStatus {
  param(
    [object]$Row,
    [object]$Profile
  )

  $layer = $Row.layer_type
  $readiness = $Row.readiness
  $id = $Row.component_id
  $notes = "" + $Row.notes

  if ($layer -eq "SCAFFOLD_ONLY") { return "SCAFFOLD_ONLY" }
  if ($readiness -eq "DEFERRED_ADAPTER") { return "DEFERRED" }
  if ($readiness -eq "NOT_BUILT") { return "NOT_BUILT" }

  if ($layer -eq "CLIENT_CONFIG_ASSET") {
    if ($Profile.folder_exists -or (Test-Path (Join-Path $RepoRoot $Row.folder_path))) { return "PASS_CONFIG_ASSET" }
    return "CONFIG_ASSET_MISSING" 
  }

  if ($layer -eq "TEMPLATE_GLUE") {
    if ($readiness -eq "BUILT") {
      if ($Profile.workflow_json_count -ge 1 -and $Profile.test_payload_count -ge 1 -and $Profile.output_sample_count -ge 1) { return "PASS_80_20" }
      return "BROKEN_ARTIFACTS"
    }
    return "NOT_BUILT"
  }

  if ($readiness -eq "BUILT") {
    if (-not $Profile.folder_exists) { return "BUILT_FOLDER_MISSING" }
    if (-not $Profile.readme_present) { return "BROKEN_ARTIFACTS" }
    if ($Profile.workflow_json_count -lt 1) { return "BROKEN_ARTIFACTS" }
    if ($Profile.invalid_workflow_json_count -gt 0) { return "BROKEN_ARTIFACTS" }
    if ($Profile.test_payload_count -lt 1) { return "BROKEN_ARTIFACTS" }
    if ($Profile.output_sample_count -lt 1) { return "BROKEN_ARTIFACTS" }

    if ($layer -eq "HANDOFF_ONLY_CORE") { return "PASS_HANDOFF_ONLY" }

    if ($layer -eq "INDEPENDENT_ADAPTER") {
      if ($id -in @("ADP-REST", "ADP-WEBHOOK-SEND")) { return "PASS_80_20_FOR_DECLARED_SCOPE" }
      return "PASS_80_20"
    }

    return "PASS_80_20"
  }

  return "REVIEW_REQUIRED"
}

function Get-DiscussionFlag {
  param([string]$ProductionStatus)

  if ($ProductionStatus -in @("BROKEN_ARTIFACTS","BUILT_FOLDER_MISSING","CONFIG_ASSET_MISSING","REVIEW_REQUIRED")) { return "DISCUSS" }
  if ($ProductionStatus -eq "PASS_80_20_FOR_DECLARED_SCOPE") { return "DISCUSS_SCOPE" }
  return "OK"
}

$Results = foreach ($row in $Rows) {
  $primaryCategory = Get-PrimaryCategory -ComponentId $row.component_id -LayerType $row.layer_type
  $profile = Get-ArtifactProfile -FolderPath $row.folder_path
  $productionStatus = Get-ProductionStatus -Row $row -Profile $profile
  $discussionFlag = Get-DiscussionFlag -ProductionStatus $productionStatus

  [pscustomobject]@{
    component_id = $row.component_id
    component_name = $row.component_name
    primary_category = $primaryCategory
    layer_type = $row.layer_type
    readiness = $row.readiness
    execution_level = $row.execution_level
    provider = $row.provider
    priority = $row.priority
    folder_path = $row.folder_path
    folder_exists = $profile.folder_exists
    readme_present = $profile.readme_present
    workflow_json_count = $profile.workflow_json_count
    valid_workflow_json_count = $profile.valid_workflow_json_count
    invalid_workflow_json_count = $profile.invalid_workflow_json_count
    n8n_node_count_total = $profile.n8n_node_count_total
    code_node_count = $profile.code_node_count
    trigger_node_count = $profile.trigger_node_count
    credential_reference_count = $profile.credential_reference_count
    test_payload_count = $profile.test_payload_count
    output_sample_count = $profile.output_sample_count
    production_80_20_status = $productionStatus
    discussion_flag = $discussionFlag
    notes = $row.notes
  }
}

$Results | Export-Csv -NoTypeInformation -Encoding UTF8 $CsvReport

$Lines = New-Object System.Collections.Generic.List[string]
$Lines.Add("# Primary Category + 80/20 Audit")
$Lines.Add("")
$Lines.Add("Generated: $Now")
$Lines.Add("")
$Lines.Add("## Status Counts")
$Lines.Add("")
$Lines.Add("| 80/20 Status | Count |")
$Lines.Add("|---|---:|")
$Results | Group-Object production_80_20_status | Sort-Object Name | ForEach-Object { $Lines.Add("| $($_.Name) | $($_.Count) |") }
$Lines.Add("")
$Lines.Add("## Discussion Items")
$Lines.Add("")
$DiscussionItems = @($Results | Where-Object { $_.discussion_flag -ne "OK" })
if ($DiscussionItems.Count -eq 0) {
  $Lines.Add("None.")
} else {
  $Lines.Add("| ID | Name | Layer | Status | Reason |")
  $Lines.Add("|---|---|---|---|---|")
  foreach ($item in ($DiscussionItems | Sort-Object discussion_flag, component_id)) {
    $reason = "workflows=$($item.workflow_json_count); payloads=$($item.test_payload_count); samples=$($item.output_sample_count); nodes=$($item.n8n_node_count_total); credentials=$($item.credential_reference_count)"
    $Lines.Add("| $($item.component_id) | $($item.component_name) | $($item.layer_type) | $($item.production_80_20_status) | $reason |")
  }
}
$Lines.Add("")
$Lines.Add("## Primary Category Counts")
$Lines.Add("")
$Lines.Add("| Primary Category | Count |")
$Lines.Add("|---|---:|")
$Results | Group-Object primary_category | Sort-Object Name | ForEach-Object { $Lines.Add("| $($_.Name) | $($_.Count) |") }
$Lines.Add("")
$Lines.Add("## Built Artifact Snapshot")
$Lines.Add("")
$Lines.Add("| ID | Layer | 80/20 | Workflows | Nodes | Payloads | Samples |")
$Lines.Add("|---|---|---|---:|---:|---:|---:|")
$Results | Where-Object { $_.readiness -eq "BUILT" } | Sort-Object component_id | ForEach-Object {
  $Lines.Add("| $($_.component_id) | $($_.layer_type) | $($_.production_80_20_status) | $($_.workflow_json_count) | $($_.n8n_node_count_total) | $($_.test_payload_count) | $($_.output_sample_count) |")
}

$Lines | Set-Content -Encoding UTF8 $MdReport
Get-Content $MdReport

$HardFails = @($Results | Where-Object { $_.production_80_20_status -in @("BROKEN_ARTIFACTS","BUILT_FOLDER_MISSING","CONFIG_ASSET_MISSING") })
if ($HardFails.Count -gt 0) { exit 1 }
