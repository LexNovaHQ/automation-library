# C2-G - File Upload Routing

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Routes uploaded files based on file metadata, extension, MIME type, file size, and configured routing rules.

C2-G v1 does not perform OCR, parse CSV rows, extract fields, validate records, permanently store files, or process documents. It only validates file routing eligibility and creates downstream handoff objects.

## Architecture
C2-G contains one n8n workflow:

1. `C2-G_CORE_File_Upload_Routing_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream uploads.
   - Refuses requests where `next_action` is not `route_file_upload`.
   - Requires `input.file`.
   - Requires filename and resolvable extension.
   - Checks blocked extensions.
   - Checks allowed extensions.
   - Checks max file size.
   - Matches file extension against configured route rules.
   - Creates downstream handoff to the configured next component.
   - Creates C5-E manual review handoff if no route rule matches.

## Workflow Files
- `workflows/c2-g-core-file-upload-routing-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- Edit Fields / Set node

## Input Contract

```json
{
  "input": {
    "success": true,
    "component_id": "",
    "component_version": "",
    "event_id": "",
    "event_type": "file_upload",
    "file": {
      "file_id": "",
      "filename": "",
      "mime_type": "",
      "extension": "",
      "size_bytes": 0,
      "source_url": "",
      "storage_provider": ""
    },
    "metadata": {
      "origin": "",
      "environment": "",
      "uploaded_at": ""
    },
    "error": null,
    "next_action": "route_file_upload"
  },
  "config": {
    "max_file_size_bytes": 10485760,
    "allowed_extensions": [],
    "blocked_extensions": [],
    "route_rules": {
      "spreadsheet": {
        "extensions": ["csv", "xlsx", "xls"],
        "next_component": "C2-N",
        "next_action": "parse_spreadsheet_rows"
      },
      "document": {
        "extensions": ["pdf", "docx", "txt"],
        "next_component": "C4-T",
        "next_action": "process_document"
      },
      "image": {
        "extensions": ["png", "jpg", "jpeg"],
        "next_component": "C4-T",
        "next_action": "process_document"
      }
    },
    "default_next_action": "route_file"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-G",
  "component_version": "v1",
  "event_id": "",
  "event_type": "file_upload",
  "file_route": {
    "file_id": "",
    "filename": "",
    "extension": "",
    "mime_type": "",
    "size_bytes": 0,
    "source_url": "",
    "storage_provider": "",
    "file_category": "",
    "route_status": "routed",
    "route_reason": "",
    "routed_at": ""
  },
  "downstream_handoff": {
    "next_component": "",
    "input": {},
    "config": {}
  },
  "manual_review_handoff": {
    "next_component": "C5-E",
    "input": {},
    "config": {}
  },
  "source_result": {},
  "error": null,
  "next_action": "route_file"
}
File Categories Supported in v1

C2-G supports configurable file categories through route_rules.

Common categories used in test payloads:

spreadsheet
document
image
Default Routing Examples
File Type    Extensions    Default Component    Default Action
Spreadsheet    csv, xlsx, xls    C2-N    parse_spreadsheet_rows
Document    pdf, docx, txt    C4-T    process_document
Image    png, jpg, jpeg    C4-T    process_document
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
FILE_ROUTING_NOT_REQUESTED
MISSING_FILE_OBJECT
MISSING_FILENAME
MISSING_FILE_EXTENSION
BLOCKED_FILE_EXTENSION
UNSUPPORTED_FILE_EXTENSION
FILE_TOO_LARGE
Test Payloads
test-payloads/csv-upload.valid.json
test-payloads/pdf-upload.valid.json
test-payloads/image-upload.valid.json
test-payloads/blocked-extension.invalid.json
test-payloads/oversized-file.invalid.json
test-payloads/upstream-failed.invalid.json
test-payloads/file-routing-not-requested.invalid.json
test-payloads/missing-file.invalid.json
Output Samples
output-samples/success-csv-upload.json
output-samples/success-pdf-upload.json
output-samples/success-image-upload.json
output-samples/error-blocked-extension.json
output-samples/error-oversized-file.json
output-samples/error-upstream-failed.json
output-samples/error-file-routing-not-requested.json
output-samples/error-missing-file.json
Passed Tests
CSV upload
PDF upload
Image upload
Blocked extension
Oversized file
Upstream failed
File routing not requested
Missing file
80/20 Interoperability Rule

The reusable 80% layer is the file routing engine: upload metadata intake, extension normalization, blocked-extension enforcement, allowed-extension enforcement, size checking, route rule matching, downstream handoff creation, and manual-review fallback. The configurable 20% layer is allowed extensions, blocked extensions, max file size, route rules, reviewer, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic file routing and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using file upload modules, routers, filters, extension checks, and downstream parser/OCR modules.

Zapier

Can be rebuilt using file trigger steps, Formatter/Code, Paths, and downstream parser/OCR actions.

Not Included

These are intentionally excluded from C2-G v1 and belong to other components:

Webhook/front-door receiving -> C2-C
CSV/Excel row parsing -> C2-N
OCR/document processing -> C4-T
Field extraction -> C4-B
Payload validation -> C2-F
File storage/permanent archiving -> future storage adapter
Manual review queue creation -> C5-E
Error logging -> C6-G
Status tracking -> C5-W
Version

v1.0

Last Tested

2026-05-25
