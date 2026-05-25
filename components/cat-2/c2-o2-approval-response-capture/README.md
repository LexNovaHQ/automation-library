# C2-O2 - Approval Response Capture

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Captures reviewer approval decisions and converts them into standardized workflow decision outputs.

C2-O2 v1 closes the approval loop after C2-O and C5-E. It does not update storage, publish content, send emails, or execute downstream actions. It validates the reviewer response and returns an `approval_response` object with the decision, approval status, mapped action, reviewer notes, and next action.

## Architecture
C2-O2 contains one n8n workflow:

1. `C2-O2_CORE_Approval_Response_Capture_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream approval flows.
   - Refuses requests where `next_action` is not `capture_approval_response`.
   - Requires an approval object and response object.
   - Validates decision against allowed approval actions.
   - Validates reviewer email when expected reviewer exists.
   - Maps decision to workflow action.
   - Returns standardized `approval_response`.

## Workflow Files
- `workflows/c2-o2-core-approval-response-capture-v1.json`

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
      "allowed_actions": ["approve", "reject", "revise"],
      "context": {}
    },
    "response": {
      "decision": "approve",
      "reviewer_email": "",
      "reviewer_notes": "",
      "submitted_at": ""
    },
    "source_result": {},
    "error": null,
    "next_action": "capture_approval_response"
  },
  "config": {
    "decision_action_map": {
      "approve": "continue_workflow",
      "reject": "stop_workflow",
      "revise": "send_back_for_revision"
    },
    "default_next_action": "route_approval_decision"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-O2",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "approval_response": {
    "response_id": "",
    "approval_id": "",
    "approval_type": "",
    "approval_title": "",
    "previous_status": "pending",
    "decision": "approve",
    "approval_status": "approved",
    "reviewer_email": "",
    "reviewer_notes": "",
    "submitted_at": "",
    "source_component": "",
    "source_component_version": "",
    "event_id": "",
    "event_type": "",
    "context": {},
    "decision_action": "continue_workflow"
  },
  "source_result": {},
  "error": null,
  "next_action": "route_approval_decision"
}
Decisions Supported in v1
approve
reject
revise
Decision Mapping Supported in v1
Decision    Approval Status    Default Decision Action
approve    approved    continue_workflow
reject    rejected    stop_workflow
revise    revision_requested    send_back_for_revision
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
APPROVAL_RESPONSE_NOT_REQUESTED
MISSING_APPROVAL_OBJECT
MISSING_RESPONSE_OBJECT
MISSING_APPROVAL_ID
MISSING_DECISION
INVALID_DECISION
MISSING_REVIEWER_EMAIL
REVIEWER_MISMATCH
Test Payloads
test-payloads/approve-response.valid.json
test-payloads/reject-response.valid.json
test-payloads/revise-response.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/missing-response.invalid.json
test-payloads/invalid-decision.invalid.json
test-payloads/approval-response-not-requested.invalid.json
Output Samples
output-samples/success-approve-response.json
output-samples/success-reject-response.json
output-samples/success-revise-response.json
output-samples/error-upstream-action-failed.json
output-samples/error-missing-response.json
output-samples/error-invalid-decision.json
output-samples/error-approval-response-not-requested.json
Passed Tests
Approve response
Reject response
Revise response
Upstream failed
Missing response
Invalid decision
Approval response not requested
80/20 Interoperability Rule

The reusable 80% layer is the approval response capture engine: approval validation, response validation, allowed-action enforcement, reviewer matching, decision normalization, approval status mapping, and decision-action mapping. The configurable 20% layer is decision-action map and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic approval response validation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using webhook/form capture, JSON mapping, routers, and status update modules.

Zapier

Can be rebuilt using form/webhook response capture, Paths, and Tables/Sheets/Airtable updates.

Not Included

These are intentionally excluded from C2-O2 v1 and belong to other components:

Creating approval request -> C2-O
Review queue creation -> C5-E
Sending reviewer notifications -> C2-I
Updating database/status table -> C2-A / C5-W
Publishing/sending approved output -> C2-Q / C2-I / platform adapters
Revising AI draft -> C4-M / C4-E / C2-K
Error logging -> C6-G
Version

v1.0

Last Tested

2026-05-25
