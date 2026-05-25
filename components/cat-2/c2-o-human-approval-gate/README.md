# C2-O - Human Approval Gate

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Creates a standardized human approval request before a workflow performs a high-risk action.

C2-O v1 creates the approval object and notification payload. It does not capture approve/reject responses yet.

## Architecture
C2-O contains one n8n workflow:

1. `C2-O_CORE_Human_Approval_Gate_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `request_approval`.
   - Creates `approval_id`.
   - Extracts configured context fields.
   - Returns a pending approval object and notification payload.

## Workflow Files
- `workflows/c2-o-core-human-approval-gate-v1.json`

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
    "payload": {},
    "metadata": {},
    "error": null,
    "next_action": "request_approval"
  },
  "config": {
    "approval_type": "",
    "approval_title": "",
    "reviewer_email": "",
    "approval_actions": ["approve", "reject"],
    "approval_context_fields": [],
    "default_next_action": "notify_reviewer"
  }
}

Output Contract
{
  "success": true,
  "component_id": "C2-O",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "approval": {
    "approval_id": "",
    "status": "pending",
    "approval_type": "",
    "approval_title": "",
    "reviewer_email": "",
    "allowed_actions": [],
    "context": {},
    "requested_at": ""
  },
  "source_result": {},
  "notification_payload": {
    "channel": "email",
    "to": "",
    "subject": "",
    "text": ""
  },
  "error": null,
  "next_action": "notify_reviewer"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
APPROVAL_NOT_REQUESTED
MISSING_APPROVAL_TYPE
MISSING_APPROVAL_TITLE
MISSING_REVIEWER_EMAIL
Test Payloads
test-payloads/content-approval.valid.json
test-payloads/campaign-approval.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/missing-reviewer.invalid.json
test-payloads/approval-not-requested.invalid.json
Output Samples
output-samples/success-content-approval.json
output-samples/success-campaign-approval.json
output-samples/error-upstream-action-failed.json
output-samples/error-missing-reviewer.json
output-samples/error-approval-not-requested.json
Passed Tests
Content approval request
Campaign approval request
Upstream failed
Missing reviewer
Approval not requested
80/20 Interoperability Rule

The reusable 80% layer is the approval object generator: input validation, approval ID creation, context extraction, allowed actions, and notification payload generation. The configurable 20% layer is approval type, title, reviewer, allowed actions, context fields, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Code node for deterministic approval object generation.

Make.com

Can be rebuilt using JSON mapping, data-store/database record creation, and email/Slack notification modules.

Zapier

Can be rebuilt for simple approvals using tables/forms plus email notifications, but response capture is better handled in n8n/Make.

Not Included

These are intentionally excluded from C2-O v1 and belong to later components:

Capturing approve/reject responses -> C2-O2
Sending reviewer notification -> C2-I
Writing approval item to status table -> C5-W / C2-A
Publishing approved content -> C2-Q
Error logging/retry queue -> C6-G
AI draft generation -> C2-K / C4-M
Version

v1.0

Last Tested

2026-05-25