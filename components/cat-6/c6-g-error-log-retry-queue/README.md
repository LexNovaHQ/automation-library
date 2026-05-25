@'
# C6-G - Error Log + Retry Queue

## Status
Built v1.0

## Category
C6 - Diagnostic, Error Handling, QA & Handoff Systems

## Purpose
Creates a standardized error log and retry queue object from failed upstream automation outputs.

C6-G v1 does not write the error record to a database and does not execute retries. It creates the structured error-log object, retry status, severity classification, and owner notification payload for downstream components.

## Architecture
C6-G contains one n8n workflow:

1. `C6-G_CORE_Error_Log_Retry_Queue_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses successful upstream outputs.
   - Requires a source error object.
   - Creates `error_id`.
   - Classifies severity from configurable severity rules.
   - Creates retry/manual-resolution fields.
   - Generates notification payload for error owner.

## Workflow Files
- `workflows/c6-g-core-error-log-retry-queue-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- Edit Fields / Set node

## Input Contract

```json
{
  "input": {
    "success": false,
    "component_id": "",
    "component_version": "",
    "event_id": "",
    "event_type": "",
    "payload": {},
    "metadata": {},
    "error": {
      "code": "",
      "message": "",
      "details": []
    },
    "next_action": "route_to_failure_log"
  },
  "config": {
    "error_owner_email": "",
    "severity_rules": {},
    "default_severity": "medium",
    "default_retry_status": "pending_manual_review",
    "default_next_action": "notify_error_owner"
  }
}

{
  "success": true,
  "component_id": "C6-G",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "error_log": {
    "error_id": "",
    "status": "logged",
    "severity": "medium",
    "retry_status": "pending_manual_review",
    "source_component": "",
    "source_component_version": "",
    "source_error_code": "",
    "source_error_message": "",
    "source_error_details": [],
    "owner_email": "",
    "created_at": "",
    "resolution_status": "open",
    "retry_attempts": 0,
    "manual_notes": ""
  },
  "source_result": {},
  "notification_payload": {
    "channel": "email",
    "to": "",
    "subject": "",
    "text": ""
  },
  "error": null,
  "next_action": "notify_error_owner"
}


Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
SOURCE_NOT_FAILED
MISSING_SOURCE_ERROR
MISSING_SOURCE_ERROR_CODE
Test Payloads
test-payloads/validation-failed.valid.json
test-payloads/write-failed.valid.json
test-payloads/notification-failed.valid.json
test-payloads/success-input.invalid.json
test-payloads/missing-error-object.invalid.json
Output Samples
output-samples/success-validation-error-log.json
output-samples/success-write-error-log.json
output-samples/success-notification-error-log.json
output-samples/error-source-not-failed.json
output-samples/error-missing-source-error.json
Passed Tests
Validation failed log
Write failed log
Notification failed log
Success input invalid
Missing error object invalid
80/20 Interoperability Rule

The reusable 80% layer is the error-log generator: failure validation, error ID creation, severity classification, retry status, resolution fields, and owner notification payload. The configurable 20% layer is error owner, severity rules, default retry status, default severity, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Code node for deterministic error log object generation.

Make.com

Can be rebuilt using JSON mapping, routers/filters, Data Store or Airtable/Sheets logging, and email/Slack notification modules.

Zapier

Can be rebuilt for simple cases using Paths, Tables/Sheets, and email notifications, but retry/state management is better in n8n/Make.

Not Included

These are intentionally excluded from C6-G v1 and belong to later components:

Writing error record to Airtable/Sheets/status table -> C2-A / C5-W
Sending error notification -> C2-I
Retrying failed workflow execution -> C6-G2
Dashboard/control table -> C5-W
Auto-fix diagnostics -> C6-A/C6-B/C6-C/C6-D
Version

v1.0

Last Tested

2026-05-25
'@ | Set-Content -Encoding UTF8 components\cat-6\c6-g-error-log-retry-queue\README.md