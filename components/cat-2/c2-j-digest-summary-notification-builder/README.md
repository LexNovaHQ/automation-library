# C2-J - Digest / Summary Notification Builder

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Builds daily, weekly, or event-batch summaries from automation status records, error logs, approval records, and workflow events.

C2-J v1 creates a standardized digest object and notification payload. It does not send the digest itself. Downstream notification sending belongs to C2-I.

## Architecture
C2-J contains one n8n workflow:

1. `C2-J_CORE_Digest_Summary_Notification_Builder_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `build_digest`.
   - Requires `input.records` array.
   - Counts records by type, event type, status, owner, and priority.
   - Identifies failed, pending approval, manual review, retry, and completed items.
   - Creates digest text and email-ready notification payload.

## Workflow Files
- `workflows/c2-j-core-digest-summary-notification-builder-v1.json`

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
    "records": [],
    "metadata": {},
    "error": null,
    "next_action": "build_digest"
  },
  "config": {
    "digest_type": "daily",
    "digest_title": "",
    "recipient_email": "",
    "owner": "",
    "include_record_details": true,
    "max_detail_items": 10,
    "default_next_action": "send_digest_notification"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-J",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "digest": {
    "digest_id": "",
    "digest_type": "",
    "digest_title": "",
    "total_records": 0,
    "counts": {
      "completed": 0,
      "failed": 0,
      "pending_approval": 0,
      "manual_review": 0,
      "by_record_type": {},
      "by_event_type": {},
      "by_status": {},
      "by_owner": {},
      "by_priority": {}
    },
    "attention_items": [],
    "summary_text": "",
    "owner": "",
    "created_at": ""
  },
  "notification_payload": {
    "channel": "email",
    "to": "",
    "subject": "",
    "text": ""
  },
  "source_result": {},
  "error": null,
  "next_action": "send_digest_notification"
}
Digest Types Supported in v1
daily
error
approval
Any custom digest type provided in config
Count Groups Supported in v1
Completed records
Failed/error records
Pending approval records
Manual review / retry records
By record type
By event type
By status
By owner
By priority
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
DIGEST_NOT_REQUESTED
MISSING_RECORDS_ARRAY
MISSING_DIGEST_TYPE
MISSING_RECIPIENT_EMAIL
Test Payloads
test-payloads/daily-digest.valid.json
test-payloads/error-digest.valid.json
test-payloads/approval-digest.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/digest-not-requested.invalid.json
test-payloads/missing-records.invalid.json
Output Samples
output-samples/success-daily-digest.json
output-samples/success-error-digest.json
output-samples/success-approval-digest.json
output-samples/error-upstream-action-failed.json
output-samples/error-digest-not-requested.json
output-samples/error-missing-records.json
Passed Tests
Daily digest
Error digest
Approval digest
Upstream failed
Digest not requested
Missing records
80/20 Interoperability Rule

The reusable 80% layer is the digest builder: batch record summarization, counts, attention-item extraction, digest text generation, and notification payload generation. The configurable 20% layer is digest type, title, recipient, owner, detail inclusion, max detail count, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic digest creation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using aggregators, array functions, routers, and email/Slack modules.

Zapier

Can be rebuilt for simple daily digests using Digest by Zapier, Formatter, and email steps, but complex multi-record summaries are better in n8n/Make.

Not Included

These are intentionally excluded from C2-J v1 and belong to other components:

Sending the digest email -> C2-I
Fetching status/error/approval records from storage -> C2-A / C5-W / platform lookup components
Creating status records -> C5-W
Creating error logs -> C6-G
Approval response handling -> C2-O2
Dashboard rendering -> C5-A / C5-E
Version

v1.0

Last Tested

2026-05-25
