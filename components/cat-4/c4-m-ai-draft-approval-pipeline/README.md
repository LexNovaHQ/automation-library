# C4-M - AI Draft Approval Pipeline

## Status
Built v1.0

## Category
C4 - AI / LLM Workflow Systems

## Purpose
Turns a completed LLM result into a review-ready draft package and approval handoff payload.

C4-M v1 is a higher-level AI workflow component. It does not call the LLM directly. It expects upstream AI output from C2-K, creates a standardized draft package, and prepares a C2-O-compatible approval handoff object.

## Architecture
C4-M contains one n8n workflow:

1. `C4-M_CORE_AI_Draft_Approval_Pipeline_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream AI outputs.
   - Requires a completed `ai_result`.
   - Creates `draft_id`.
   - Creates standardized `draft_package`.
   - Creates `approval_handoff` for C2-O.
   - Returns the draft package for routing, approval, status tracking, or writing.

## Workflow Files
- `workflows/c4-m-core-ai-draft-approval-pipeline-v1.json`

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
    "component_id": "C2-K",
    "component_version": "v1",
    "event_id": "",
    "event_type": "",
    "ai_result": {
      "provider": "",
      "model": "",
      "task_type": "",
      "status": "completed",
      "content": "",
      "parsed_json": {},
      "usage": {},
      "finish_reason": ""
    },
    "source_result": {},
    "error": null,
    "next_action": "request_approval"
  },
  "config": {
    "draft_type": "",
    "draft_status": "needs_review",
    "approval_type": "",
    "approval_title": "",
    "reviewer_email": "",
    "approval_actions": ["approve", "reject", "revise"],
    "owner": "",
    "priority": "normal",
    "default_next_action": "request_approval"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C4-M",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "draft_package": {
    "draft_id": "",
    "draft_type": "",
    "draft_status": "needs_review",
    "draft_title": "",
    "draft_summary": "",
    "draft_content": {
      "raw_content": "",
      "parsed_json": {}
    },
    "ai_metadata": {
      "provider": "",
      "model": "",
      "task_type": "",
      "usage": {},
      "finish_reason": ""
    },
    "owner": "",
    "priority": "",
    "created_at": "",
    "updated_at": ""
  },
  "approval_handoff": {
    "next_component": "C2-O",
    "input": {
      "success": true,
      "component_id": "C4-M",
      "component_version": "v1",
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
      "approval_actions": [],
      "approval_context_fields": [],
      "default_next_action": "notify_reviewer"
    }
  },
  "source_result": {},
  "error": null,
  "next_action": "request_approval"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
MISSING_AI_RESULT
AI_RESULT_NOT_COMPLETED
MISSING_DRAFT_TYPE
MISSING_APPROVAL_TYPE
MISSING_REVIEWER_EMAIL
Test Payloads
test-payloads/blog-draft-approval.valid.json
test-payloads/email-draft-approval.valid.json
test-payloads/ai-failed.invalid.json
test-payloads/missing-ai-result.invalid.json
test-payloads/missing-reviewer.invalid.json
Output Samples
output-samples/success-blog-draft-approval.json
output-samples/success-email-draft-approval.json
output-samples/error-ai-failed.json
output-samples/error-missing-ai-result.json
output-samples/error-missing-reviewer.json
Passed Tests
Blog draft approval
Email draft approval
AI failed
Missing AI result
Missing reviewer
80/20 Interoperability Rule

The reusable 80% layer is the AI draft approval package generator: completed AI result validation, draft ID creation, draft package formation, AI metadata preservation, approval handoff generation, and next-action routing. The configurable 20% layer is draft type, draft status, approval type, approval title, reviewer, approval actions, owner, priority, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic draft-package and approval-handoff generation.

Make.com

Can be rebuilt using JSON mapping modules after an upstream LLM step, then passed to email/approval/database modules.

Zapier

Can be rebuilt for simple AI draft approval workflows using AI output, Formatter, Zapier Tables, and email approval steps, but complex handoff is better in n8n/Make.

Relationship to Other Components

C4-M is a productized AI workflow component that depends on lower-level C2/C5/C6 components:

C2-K generates the AI result.
C4-M packages the AI result into a review-ready draft.
C2-O creates the human approval request.
C2-I notifies the reviewer.
C5-W tracks approval/status state.
C6-G logs failures.
Not Included

These are intentionally excluded from C4-M v1 and belong to other components:

Direct LLM call -> C2-K
Human approval request generation -> C2-O
Approval response capture -> C2-O2
Reviewer notification -> C2-I
Draft/database storage -> C2-A / C5-W
Publishing approved content -> C2-Q
Error logging -> C6-G
Autonomous AI agent/tool execution -> later C4 agent component
Version

v1.0

Last Tested

2026-05-25
