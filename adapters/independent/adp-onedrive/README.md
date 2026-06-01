# ADP-ONEDRIVE - OneDrive File Storage Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-FILE - File Storage and File Intake

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Uploads or stores routed workflow files into OneDrive and returns a stable file reference for downstream automation.

## Why This Exists
ADP-ONEDRIVE is the second high-ROI platform adapter in the File Storage family. It covers Microsoft-heavy clients using OneDrive, SharePoint, Outlook, and Teams.

## Relationship to C2-G
C2-G is the universal file upload routing core. C2-G decides whether a file should be routed and which downstream component should receive it. ADP-ONEDRIVE performs the provider-specific OneDrive storage/upload step.

## Provider Rule
Use n8n Microsoft OneDrive node or Microsoft Graph-compatible OneDrive upload flow with manually configured Microsoft credentials. Do not hardcode tenant IDs, client IDs, client secrets, folder IDs, file IDs, or sharing links in workflow JSON.

## Credential Rule
Credentials are added manually by the user inside n8n. No real Microsoft tenant ID, client ID, client secret, OAuth token, folder ID, file ID, or OneDrive link is embedded in workflow JSON.

## n8n Import Note
Microsoft/OneDrive credentials and destination folder must be configured manually in n8n after import. If a Switch node is used, fallback/extra output must be confirmed manually in n8n.

## Supported v1 Operations
- Accept standardized file handoff object from C2-G or another upstream component
- Validate file metadata
- Upload/store file into configured OneDrive folder where binary/file input is available
- Generate small test binary for metadata-only Phase 2 tests
- Preserve source metadata
- Return stable OneDrive file reference
- Return manual-review/error output for missing file metadata or provider failure

## Not Included in v1
- Microsoft app creation automation
- Folder creation
- Recursive folder routing
- Permission/share management
- Public link generation
- OCR/document parsing
- CSV/Excel row parsing
- File versioning
- Large upload session support
- SharePoint document library support beyond OneDrive-compatible folder configuration

## Input Contract

`json
{
  "request_id": "req_onedrive_upload_001",
  "source_component": "C2-G",
  "file": {
    "file_id": "file_pdf_001",
    "filename": "client-brief.pdf",
    "mime_type": "application/pdf",
    "extension": "pdf",
    "size_bytes": 524288,
    "source_url": "https://example.com/uploads/client-brief.pdf",
    "binary_property_name": "data",
    "storage_provider": "temporary_upload"
  },
  "onedrive": {
    "destination_folder_id": "configured_manually_in_n8n",
    "destination_path_label": "Client Uploads",
    "overwrite_existing": false
  },
  "routing_options": {
    "on_success": "log_status",
    "on_failure": "manual_review"
  },
  "metadata": {
    "origin": "client_portal_upload",
    "environment": "n8n-test"
  }
}
`",
",


`json
{
  "adapter_status": "success",
  "component_id": "ADP-ONEDRIVE",
  "component_version": "v1",
  "request_id": "req_onedrive_upload_001",
  "provider": "onedrive",
  "operation": "upload_file",
  "validation_status": "valid",
  "source_file_id": "file_pdf_001",
  "onedrive_file": {
    "id": "onedrive_file_id",
    "name": "client-brief.pdf",
    "mime_type": "application/pdf",
    "web_url": "provider_link_or_null",
    "folder_id": "configured_folder_id_or_null"
  },
  "manual_review_required": false,
  "error_code": null,
  "error_message": null,
  "next_action": "log_status",
  "downstream_components": ["C5-W"],
  "source_result": {}
}
`",
",

- upload-pdf.valid.json
- upload-csv.valid.json
- upload-image.valid.json
- missing-file.invalid.json
- missing-filename.invalid.json
- missing-mime-type.invalid.json
- missing-binary-property.invalid.json
- missing-folder.invalid.json

## Version
v1.0 draft
