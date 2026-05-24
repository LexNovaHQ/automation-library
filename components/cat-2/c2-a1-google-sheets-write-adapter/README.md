# C2-A1 - Google Sheets Write Adapter

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Writes validated C2-F event payloads into Google Sheets using a configurable field map.

C2-A1 is the first destination adapter in the C2-A Data Sync Pipeline family. It writes rows to Google Sheets after upstream validation has passed.

## Architecture
C2-A1 contains one n8n workflow:

1. `C2-A1_CORE_Google_Sheets_Write_Adapter_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream validation outputs.
   - Maps payload fields to Google Sheets columns.
   - Appends a row through the Google Sheets API using HTTP Request.
   - Returns a standard write success/failure object.

## Workflow Files
- `workflows/c2-a1-core-google-sheets-write-adapter-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- IF node
- HTTP Request node
- Google Service Account API credential
- Google Sheets API

## Input Contract

```json
{
  "input": {
    "success": true,
    "component_id": "C2-F",
    "component_version": "v1",
    "event_id": "",
    "event_type": "",
    "source_component": "C2-C",
    "payload": {},
    "metadata": {},
    "validation": {
      "status": "passed",
      "checked_fields": [],
      "failed_fields": []
    },
    "error": null,
    "next_action": "route_payload"
  },
  "config": {
    "destination": "google_sheets",
    "spreadsheet_id": "",
    "sheet_name": "",
    "field_map": {},
    "default_next_action": "notify_team"
  }
}

Config Example
{
  "destination": "google_sheets",
  "spreadsheet_id": "SHEET_ID",
  "sheet_name": "Leads",
  "field_map": {
    "event_id": "Event ID",
    "event_type": "Event Type",
    "payload.name": "Name",
    "payload.email": "Email",
    "payload.company": "Company",
    "payload.message": "Message",
    "source_component": "Source",
    "metadata.origin": "Origin",
    "metadata.environment": "Environment"
  },
  "default_next_action": "notify_team"
}
Output Contract
{
  "success": true,
  "component_id": "C2-A1",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "destination": {
    "type": "google_sheets",
    "spreadsheet_id": "",
    "sheet_name": "",
    "record_id": ""
  },
  "write": {
    "status": "created",
    "fields_written": []
  },
  "payload": {},
  "metadata": {},
  "error": null,
  "next_action": "notify_team"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_VALIDATION_FAILED
MISSING_SPREADSHEET_ID
MISSING_SHEET_NAME
MISSING_FIELD_MAP
Test Payloads
test-payloads/lead-write.valid.json
test-payloads/upstream-validation-failed.invalid.json
test-payloads/missing-spreadsheet-id.invalid.json
Output Samples
output-samples/success-output.json
output-samples/error-upstream-validation-failed.json
output-samples/error-missing-spreadsheet-id.json
Passed Tests
Valid lead write
Upstream validation failed
Missing spreadsheet ID
Google Sheets service account read/write confirmed
80/20 Interoperability Rule

The reusable 80% layer is the Google Sheets write adapter: validated input, field mapping, append request, write result normalization, and failure blocking. The configurable 20% layer is the spreadsheet ID, sheet name, field map, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses HTTP Request with Google Service Account API credential and Google Sheets API append endpoint.

Make.com

Can be rebuilt using Make Custom Webhook or scenario input, JSON mapping, and Google Sheets > Add a Row module. The same input contract, field map, and output samples should be used.

Zapier

Can be rebuilt for simple cases using Zapier trigger + Formatter/Code by Zapier + Google Sheets Create Spreadsheet Row. Complex field mapping or failure handling is better in n8n/Make.

Not Included

These are intentionally excluded from C2-A1 and belong to later components:

Airtable write -> C2-A2
HubSpot contact write -> C2-A3
Deduplication -> C2-D
Conditional routing -> C2-B
Notifications -> C2-I
AI summary/classification -> C2-K / C4-A
Dashboard/logs -> C5
Version

v1.0

Last Tested

2026-05-25