# C5-E - Manual Review Queue

## Status
Built v1.0

## Category
C5 - Dashboards, Portals & Control Surfaces

## Purpose
Creates a standardized manual review queue item from workflow outputs that require human attention.

C5-E v1 does not write the review item to Airtable, Google Sheets, Supabase, or any other database. It creates the structured review queue object and reviewer notification payload. Downstream storage belongs to C2-A adapters or dashboard/control components.

## Architecture
C5-E contains one n8n workflow:

1. `C5-E_CORE_Manual_Review_Queue_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Accepts review-triggering actions such as `manual_review`, `notify_reviewer`, and `notify_error_owner`.
   - Infers queue type, review reason, priority, allowed actions, and context.
   - Creates a standardized `review_queue_item`.
   - Creates reviewer notification payload.

## Workflow Files
- `workflows/c5-e-core-manual-review-queue-v1.json`

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
    "dedupe": {},
    "suppression": {},
    "approval": {},
    "error_log": {},
    "routing": {},
    "source_result": {},
    "error": null,
    "next_action": "manual_review"
  },
  "config": {
    "queue_type": "",
    "review_reason": "",
    "reviewer_email": "",
    "owner": "",
    "priority": "normal",
    "allowed_actions": [],
    "default_next_action": "notify_reviewer"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C5-E",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "review_queue_item": {
    "review_id": "",
    "queue_type": "",
    "review_status": "open",
    "review_reason": "",
    "event_id": "",
    "event_type": "",
    "source_component": "",
    "source_component_version": "",
    "owner": "",
    "reviewer_email": "",
    "priority": "",
    "allowed_actions": [],
    "context": {},
    "decision": null,
    "reviewer_notes": "",
    "created_at": "",
    "updated_at": ""
  },
  "notification_payload": {
    "channel": "email",
    "to": "",
    "subject": "",
    "text": ""
  },
  "source_result": {},
  "error": null,
  "next_action": "notify_reviewer"
}
Queue Types Supported in v1
dedupe_review
consent_review
approval_review
error_retry_review
routing_review
manual_review
Any custom queue type provided in config
Review Sources Supported in v1
C2-D possible duplicate outputs
C2-P consent/suppression manual review outputs
C2-O pending approval outputs
C6-G error/retry outputs
C2-B fallback/manual route outputs
C5-W status/manual review outputs
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
REVIEW_NOT_REQUESTED
MISSING_REVIEWER_EMAIL
Test Payloads
test-payloads/possible-duplicate-review.valid.json
test-payloads/consent-review.valid.json
test-payloads/approval-review.valid.json
test-payloads/error-retry-review.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/review-not-requested.invalid.json
Output Samples
output-samples/success-possible-duplicate-review.json
output-samples/success-consent-review.json
output-samples/success-approval-review.json
output-samples/success-error-retry-review.json
output-samples/error-upstream-action-failed.json
output-samples/error-review-not-requested.json
Passed Tests
Possible duplicate review
Consent review
Approval review
Error retry review
Upstream failed
Review not requested
80/20 Interoperability Rule

The reusable 80% layer is the manual review queue object generator: queue type inference, review reason inference, context capture, allowed action generation, reviewer assignment, priority assignment, and notification payload generation. The configurable 20% layer is queue type, review reason, reviewer, owner, priority, allowed actions, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic review queue item generation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using JSON mapping, routers, and Airtable/Sheets/Data Store modules.

Zapier

Can be rebuilt for simple approval/review queues using Zapier Tables, Google Sheets, Airtable, and email notifications.

Not Included

These are intentionally excluded from C5-E v1 and belong to other components:

Writing review queue item to database -> C2-A / C5-W
Sending reviewer notification -> C2-I
Capturing approval/review response -> C2-O2
Retrying failed workflows -> C6-G2
Dashboard rendering -> C5-A / C5-B
Version

v1.0

Last Tested

2026-05-25
