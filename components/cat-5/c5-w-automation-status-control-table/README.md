# C5-W - Automation Status Control Table

## Status
Built v1.0

## Category
C5 - Dashboards, Portals & Control Surfaces

## Purpose
Creates a standardized automation status/control record from upstream workflow outputs.

C5-W v1 does not write the record to Airtable, Google Sheets, Supabase, or any other database. It creates the structured control record that can later be written by C2-A adapters or displayed in a dashboard/control surface.

## Architecture
C5-W contains one n8n workflow:

1. `C5-W_CORE_Automation_Status_Control_Table_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Reads standardized upstream component outputs.
   - Classifies automation status and stage.
   - Extracts destination, approval, error, retry, and notification fields.
   - Creates a single `control_record` object for status tracking.

## Workflow Files
- `workflows/c5-w-core-automation-status-control-table-v1.json`

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
    "event_type": "",
    "destination": {},
    "write": {},
    "notification": {},
    "approval": {},
    "error_log": {},
    "routing": {},
    "payload": {},
    "metadata": {},
    "error": null,
    "next_action": ""
  },
  "config": {
    "owner": "",
    "priority": "normal",
    "status_mode": "auto",
    "current_status": "",
    "current_stage": "",
    "manual_notes": "",
    "default_next_action": "manual_review"
  }
}
{
  "success": true,
  "component_id": "C5-W",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "control_record": {
    "record_type": "automation_status",
    "event_id": "",
    "event_type": "",
    "current_status": "",
    "current_stage": "",
    "owner": "",
    "priority": "",
    "source_component": "",
    "source_component_version": "",
    "last_component": "",
    "destination_type": "",
    "destination_record_id": "",
    "write_status": "",
    "approval_id": "",
    "approval_status": "",
    "approval_type": "",
    "reviewer_email": "",
    "error_id": "",
    "error_status": "",
    "error_code": "",
    "error_severity": "",
    "retry_status": "",
    "retry_attempts": 0,
    "notification_channel": "",
    "notification_status": "",
    "notification_to": "",
    "next_action": "",
    "manual_notes": "",
    "created_at": "",
    "updated_at": ""
  },
  "source_result": {},
  "error": null,
  "next_action": ""
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
Status Classification Logic

C5-W v1 classifies status using the following priority order:

error_log.status = logged -> failed
approval.status = pending -> pending_approval
routing.status = fallback -> manual_review
notification.status = sent with success -> completed
write.status = created with success -> record_created
success = false -> failed
Otherwise -> in_progress
Test Payloads
test-payloads/completed-lead-status.valid.json
test-payloads/pending-approval-status.valid.json
test-payloads/error-logged-status.valid.json
test-payloads/manual-review-status.valid.json
test-payloads/missing-input.invalid.json
Output Samples
output-samples/success-completed-lead-status.json
output-samples/success-pending-approval-status.json
output-samples/success-error-logged-status.json
output-samples/success-manual-review-status.json
output-samples/error-missing-input.json
Passed Tests
Completed lead status
Pending approval status
Error logged status
Manual review status
Missing input
80/20 Interoperability Rule

The reusable 80% layer is the control-record generator: status classification, stage classification, destination extraction, approval extraction, error/retry extraction, notification extraction, and next-action tracking. The configurable 20% layer is owner, priority, manual notes, explicit status/stage override, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic status/control record generation.

Make.com

Can be rebuilt using JSON mapping, routers/filters, and Airtable/Google Sheets/Supabase record creation modules.

Zapier

Can be rebuilt for simple status tables using Zapier Tables, Google Sheets, or Airtable, but complex classification is better in n8n/Make.

Not Included

These are intentionally excluded from C5-W v1 and belong to other components:

Writing the control record to Airtable/Sheets -> C2-A1 / C2-A2
Error log generation -> C6-G
Human approval generation -> C2-O
Notification sending -> C2-I
KPI threshold monitoring -> C5-X
Dashboard UI creation -> C5-A / C5-B
Version

v1.0

Last Tested

2026-05-25
