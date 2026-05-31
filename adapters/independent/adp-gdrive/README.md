# ADP-GDRIVE - Google Drive File Storage Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-FILE - File Storage and File Intake

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Uploads or stores routed workflow files into Google Drive and returns a stable file reference for downstream automation.

## Why This Exists
ADP-GDRIVE is the first high-ROI platform adapter in the File Storage family. Google Drive is a common client storage destination for uploaded documents, generated reports, invoices, receipts, contracts, and AI-processed files.

## Relationship to C2-G
C2-G is the universal file upload routing core. C2-G decides whether a file should be routed and which downstream component should receive it. ADP-GDRIVE performs the provider-specific Google Drive storage/upload step.

## Provider Rule
Use n8n Google Drive node with manually configured Google credentials. Do not hardcode OAuth credentials, service account keys, folder IDs, file IDs, or sharing links in workflow JSON.

## Credential Rule
Credentials are added manually by the user inside n8n. No real Google client ID, client secret, OAuth token, service account key, folder ID, file ID, or Drive link is embedded in workflow JSON.

## n8n Import Note
Google Drive credentials and destination folder must be configured manually in n8n after import. If a Switch node is used, fallback/extra output must be confirmed manually in n8n.

## Supported v1 Operations
- Accept standardized file handoff object from C2-G or another upstream component
- Validate file metadata
- Upload/store file into configured Google Drive folder where binary/file input is available
- Preserve source metadata
- Return stable Google Drive file reference
- Return manual-review/error output for missing file metadata or provider failure

## Not Included in v1
- Google Drive credential creation automation
- Folder creation
- Recursive folder routing
- Permission/share management
- Public link generation
- OCR/document parsing
- CSV/Excel row parsing
- File versioning
- Large multipart/resumable upload optimization

## Input Contract

`json
{
  "request_id": "req_gdrive_upload_001",
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
  "drive": {
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
  "component_id": "ADP-GDRIVE",
  "component_version": "v1",
  "request_id": "req_gdrive_upload_001",
  "provider": "google_drive",
  "operation": "upload_file",
  "validation_status": "valid",
  "source_file_id": "file_pdf_001",
  "drive_file": {
    "id": "google_drive_file_id",
    "name": "client-brief.pdf",
    "mime_type": "application/pdf",
    "web_view_link": "provider_link_or_null",
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
