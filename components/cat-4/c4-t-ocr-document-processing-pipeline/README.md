# C4-T - OCR / Document Processing Pipeline

## Status
Built v1.0

## Category
C4 - AI / LLM Workflow Systems

## Purpose
Processes routed document/image uploads by deciding whether text is already available, OCR is needed, field extraction can proceed, or manual review is required.

C4-T v1 does not directly OCR files, parse document layouts, extract structured fields, validate records, or store files permanently. It prepares structured document-processing outputs and downstream handoffs.

## Architecture
C4-T contains one n8n workflow:

1. `C4-T_CORE_OCR_Document_Processing_Pipeline_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `process_document`.
   - Requires `input.file`.
   - Requires filename and resolvable extension.
   - Enforces supported extensions.
   - Enforces max file size.
   - Detects whether usable document text is already available.
   - Creates C4-B handoff when text is ready.
   - Creates OCR adapter handoff when OCR is required.
   - Creates C5-E manual review handoff when no automatic processing path is available.

## Workflow Files
- `workflows/c4-t-core-ocr-document-processing-pipeline-v1.json`

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
    "file_route": {
      "file_category": "",
      "route_status": ""
    },
    "document": {
      "text_available": true,
      "extracted_text": "",
      "page_count": 1,
      "source_text_method": ""
    },
    "metadata": {},
    "error": null,
    "next_action": "process_document"
  },
  "config": {
    "document_goal": "",
    "supported_extensions": ["pdf", "docx", "txt", "png", "jpg", "jpeg"],
    "ocr_extensions": ["pdf", "png", "jpg", "jpeg"],
    "ocr_required_when_no_text": true,
    "max_file_size_bytes": 10485760,
    "extraction_target": {
      "next_component": "C4-B",
      "next_action": "extract_fields",
      "extraction_goal": ""
    },
    "ocr_target": {
      "next_component": "ocr_adapter",
      "next_action": "run_ocr"
    },
    "client_ai_profile": {},
    "llm": {},
    "default_next_action": "extract_fields"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C4-T",
  "component_version": "v1",
  "event_id": "",
  "event_type": "file_upload",
  "document_processing": {
    "file_id": "",
    "filename": "",
    "extension": "",
    "mime_type": "",
    "size_bytes": 0,
    "source_url": "",
    "storage_provider": "",
    "file_category": "",
    "page_count": 1,
    "text_available": true,
    "extracted_text": "",
    "source_text_method": "",
    "document_goal": "",
    "route_status": "text_ready",
    "route_reason": "",
    "processed_at": ""
  },
  "c4b_handoff": {
    "next_component": "C4-B",
    "input": {},
    "config": {}
  },
  "ocr_handoff": {
    "next_component": "ocr_adapter",
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
  "next_action": "extract_fields"
}
Document Routes Supported in v1
text_ready
ocr_required
manual_review_required
Extension Handling in v1

Supported extensions are configured through supported_extensions.

Common supported extensions:

pdf
docx
txt
png
jpg
jpeg

OCR-capable extensions are configured through ocr_extensions.

Common OCR extensions:

pdf
png
jpg
jpeg
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
DOCUMENT_PROCESSING_NOT_REQUESTED
MISSING_FILE_OBJECT
MISSING_FILENAME
MISSING_FILE_EXTENSION
UNSUPPORTED_FILE_EXTENSION
FILE_TOO_LARGE
Test Payloads
test-payloads/pdf-text-ready.valid.json
test-payloads/pdf-needs-ocr.valid.json
test-payloads/image-receipt-ocr.valid.json
test-payloads/txt-ready.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/document-processing-not-requested.invalid.json
test-payloads/missing-file.invalid.json
test-payloads/unsupported-extension.invalid.json
test-payloads/oversized-file.invalid.json
Output Samples
output-samples/success-pdf-text-ready.json
output-samples/success-pdf-needs-ocr.json
output-samples/success-image-receipt-ocr.json
output-samples/success-txt-ready.json
output-samples/error-upstream-action-failed.json
output-samples/error-document-processing-not-requested.json
output-samples/error-missing-file.json
output-samples/error-unsupported-extension.json
output-samples/error-oversized-file.json
Passed Tests
PDF text ready
PDF needs OCR
Image receipt OCR
TXT ready
Upstream failed
Document processing not requested
Missing file
Unsupported extension
Oversized file
80/20 Interoperability Rule

The reusable 80% layer is the document processing router: input validation, file metadata inspection, extension enforcement, file-size enforcement, text-availability detection, C4-B extraction handoff creation, OCR handoff creation, manual review fallback, and metadata preservation. The configurable 20% layer is supported extensions, OCR extensions, max file size, extraction target, OCR target, OCR provider, client AI profile, LLM config, reviewer, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic document processing route selection and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using file metadata modules, filters, routers, OCR modules, and downstream AI extraction modules.

Zapier

Can be rebuilt using file triggers, Paths, Webhooks/OCR actions, and downstream AI extraction steps.

Not Included

These are intentionally excluded from C4-T v1 and belong to other components/adapters:

File upload routing -> C2-G
Actual OCR execution -> future OCR adapter
AI field extraction -> C4-B
Payload validation -> C2-F
CSV/Excel parsing -> C2-N
File storage/permanent archiving -> future storage adapter
Manual review queue creation -> C5-E
Status tracking -> C5-W
Error logging -> C6-G
Version

v1.0

Last Tested

2026-05-26
