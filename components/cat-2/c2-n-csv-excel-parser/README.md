# C2-N - CSV / Excel Parser

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Parses CSV, Excel, Google Sheets export, Airtable export, or manually pasted spreadsheet-style rows into standardized records for downstream validation, dedupe, qualification, and CRM/write workflows.

C2-N v1 does not validate, dedupe, qualify, write, or enrich records. It converts row-based input into normalized record objects and creates a C2-F-compatible batch validation handoff.

## Architecture
C2-N contains one n8n workflow:

1. `C2-N_CORE_CSV_Excel_Parser_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `parse_spreadsheet_rows`.
   - Requires `input.rows` array.
   - Requires `field_map`.
   - Supports configurable CSV/Excel column names.
   - Normalizes name, email, phone, company, website, message, source, consent status, imported timestamp, and row number.
   - Skips fully empty rows.
   - Creates C2-F-compatible batch validation handoff.

## Workflow Files
- `workflows/c2-n-core-csv-excel-parser-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- Edit Fields / Set node

## Implementation Note
In the n8n Final Output Contract node, `parsed_records` must be typed as **Array**, not Object.

## Input Contract

```json
{
  "input": {
    "success": true,
    "component_id": "",
    "component_version": "",
    "event_id": "",
    "event_type": "csv_import",
    "rows": [],
    "metadata": {
      "origin": "",
      "environment": "",
      "filename": "",
      "uploaded_at": ""
    },
    "error": null,
    "next_action": "parse_spreadsheet_rows"
  },
  "config": {
    "source_type": "csv",
    "source_name": "",
    "field_map": {
      "name": "",
      "email": "",
      "phone": "",
      "company": "",
      "website": "",
      "message": "",
      "consent": "",
      "consent_status": ""
    },
    "default_consent_status": "not_provided",
    "start_row_number": 2,
    "validation_rules": {
      "required_fields": ["name", "email"],
      "email_fields": ["email"]
    },
    "default_next_action": "validate_batch_payload"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-N",
  "component_version": "v1",
  "event_id": "",
  "event_type": "csv_import",
  "parsed_records": [
    {
      "record_id": "row_2",
      "row_number": 2,
      "payload": {
        "row_number": 2,
        "name": "",
        "email": "",
        "phone": "",
        "company": "",
        "website": "",
        "message": "",
        "source": "",
        "consent_status": "",
        "imported_at": ""
      },
      "metadata": {
        "source_component": "",
        "original_event_type": "",
        "source_type": "",
        "source_name": "",
        "empty_fields": [],
        "parsed_at": ""
      }
    }
  ],
  "batch_summary": {
    "total_rows_received": 0,
    "total_records_parsed": 0,
    "empty_rows_skipped": 0,
    "source_type": "",
    "source_name": ""
  },
  "c2f_batch_handoff": {
    "next_component": "C2-F",
    "input": {},
    "config": {}
  },
  "source_result": {},
  "error": null,
  "next_action": "validate_batch_payload"
}
Supported Sources in v1
CSV rows
Excel rows
Google Sheets export rows
Airtable export rows
Manual/pasted spreadsheet rows
Any row-array payload with configurable column mapping
Consent Normalization

C2-N normalizes consent into:

opted_in
opted_out
not_provided
custom normalized string if provided

Boolean true becomes opted_in.
Boolean false becomes not_provided.

Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
PARSER_NOT_REQUESTED
MISSING_ROWS_ARRAY
MISSING_FIELD_MAP
Test Payloads
test-payloads/csv-rows.valid.json
test-payloads/excel-rows.valid.json
test-payloads/messy-rows.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/parser-not-requested.invalid.json
test-payloads/missing-rows.invalid.json
test-payloads/missing-field-map.invalid.json
Output Samples
output-samples/success-csv-rows.json
output-samples/success-excel-rows.json
output-samples/success-messy-rows.json
output-samples/error-upstream-action-failed.json
output-samples/error-parser-not-requested.json
output-samples/error-missing-rows.json
output-samples/error-missing-field-map.json
Passed Tests
CSV rows
Excel rows
Messy rows
Upstream failed
Parser not requested
Missing rows
Missing field map
80/20 Interoperability Rule

The reusable 80% layer is the row parsing engine: row-array intake, configurable field mapping, row number handling, email normalization, consent normalization, empty-row skipping, metadata preservation, batch summary generation, and C2-F batch validation handoff creation. The configurable 20% layer is source type, source name, field map, start row number, consent default, validation rules, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic row parsing and an Edit Fields / Set node for final output. parsed_records must be typed as Array.

Make.com

Can be rebuilt using CSV/Excel parsers, array iterators, mapping modules, and routers.

Zapier

Can be rebuilt using Formatter, Looping by Zapier, Google Sheets/CSV import triggers, and downstream validation/write steps.

Not Included

These are intentionally excluded from C2-N v1 and belong to other components:

File upload / storage routing -> C2-G
Payload validation -> C2-F
Dedupe -> C2-D
Suppression/consent guard -> C2-P
Lead qualification -> C4-L
CRM/database writes -> C2-A
Notifications -> C2-I
Error logging -> C6-G
Status tracking -> C5-W
Version

v1.0

Last Tested

2026-05-25
