# C4-L - Lead Qualification Pipeline

## Status
Built v1.0

## Category
C4 - AI / LLM Workflow Systems

## Purpose
Qualifies inbound or workflow-generated leads using a client-specific AI profile, lead qualification rules, upstream context, and structured scoring.

C4-L v1 is not an autonomous sales agent. It does not email the lead, update CRM records, send notifications, or make final sales decisions. It creates a structured lead qualification result and downstream handoff object.

## Architecture
C4-L contains one n8n workflow:

1. `C4-L_CORE_Lead_Qualification_Pipeline_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `qualify_lead`.
   - Requires `client_ai_profile`.
   - Requires score thresholds.
   - Requires LLM config.
   - Uses lead payload, upstream context, audience profile, qualification rules, and risk/manual review rules.
   - Calls Groq through OpenAI-compatible chat completions.
   - Returns standardized `lead_qualification`.
   - Creates C4-E handoff for qualified leads.
   - Creates C5-E handoff for manual review leads.

## Workflow Files
- `workflows/c4-l-core-lead-qualification-pipeline-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- IF node
- HTTP Request node
- Header Auth credential
- Groq OpenAI-compatible API

## Demo Provider
- Provider: Groq
- Endpoint: `https://api.groq.com/openai/v1/chat/completions`
- Model used in tests: `llama-3.3-70b-versatile`

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
    "suppression": {},
    "dedupe": {},
    "error": null,
    "next_action": "qualify_lead"
  },
  "config": {
    "qualification_mode": "rules_plus_ai",
    "client_ai_profile": {
      "client_profile": {},
      "audience_profile": {},
      "lead_qualification_rules": {},
      "risk_boundaries": {},
      "approval_rules": {}
    },
    "score_thresholds": {
      "qualified": 75,
      "possible_fit": 45,
      "manual_review": 40
    },
    "llm": {
      "provider": "groq",
      "endpoint": "https://api.groq.com/openai/v1/chat/completions",
      "model": "llama-3.3-70b-versatile",
      "temperature": 0.1,
      "max_tokens": 700
    },
    "default_next_action": "generate_email_draft"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C4-L",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "lead_qualification": {
    "status": "qualified",
    "score": 0,
    "priority": "high",
    "fit": "good_fit",
    "reasons": [],
    "disqualifiers": [],
    "manual_review_required": false,
    "confidence": "high",
    "recommended_next_action": "generate_email_draft",
    "provider": "groq",
    "model": "llama-3.3-70b-versatile",
    "usage": {},
    "finish_reason": ""
  },
  "c4e_handoff": {
    "next_component": "C4-E",
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
  "next_action": "generate_email_draft"
}
Qualification Statuses Supported in v1
qualified
possible_fit
unqualified
manual_review
Recommended Next Actions Supported in v1
generate_email_draft
manual_review
do_not_contact
nurture
Client Customization Standard

C4-L follows the C4 client customization standard:

stable reusable engine
configurable client profile
configurable audience profile
configurable qualification rules
configurable scoring thresholds
configurable risk/manual review boundaries
stable output schema
no autonomous external action

The component is designed to use:

client-assets/c4-client-ai-customization-questionnaire.md
client-assets/c4-client-ai-profile-schema.json
client-assets/sample-c4-client-ai-profile.json
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
QUALIFICATION_NOT_REQUESTED
MISSING_CLIENT_AI_PROFILE
INCOMPLETE_CLIENT_AI_PROFILE
MISSING_SCORE_THRESHOLDS
MISSING_LLM_CONFIG
INCOMPLETE_LLM_CONFIG
UNSUPPORTED_LLM_PROVIDER
QUALIFICATION_PARSE_FAILED
MISSING_LEAD_QUALIFICATION
Test Payloads
test-payloads/qualified-lead.valid.json
test-payloads/possible-fit-lead.valid.json
test-payloads/unqualified-lead.valid.json
test-payloads/manual-review-duplicate.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/qualification-not-requested.invalid.json
test-payloads/missing-client-profile.invalid.json
Output Samples
output-samples/success-qualified-lead.json
output-samples/success-possible-fit-lead.json
output-samples/success-unqualified-lead.json
output-samples/success-manual-review-duplicate.json
output-samples/error-upstream-action-failed.json
output-samples/error-qualification-not-requested.json
output-samples/error-missing-client-profile.json
Passed Tests
Qualified lead
Possible fit lead
Unqualified lead
Manual review duplicate
Upstream failed
Qualification not requested
Missing client profile
80/20 Interoperability Rule

The reusable 80% layer is the lead qualification processor: input validation, client profile enforcement, prompt construction, LLM call, structured qualification parsing, action recommendation, C4-E handoff creation, and C5-E manual review handoff creation. The configurable 20% layer is client profile, audience profile, qualification rules, scoring thresholds, risk boundaries, approval reviewer, LLM model, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Code nodes for prompt/request preparation and response parsing, plus HTTP Request with Header Auth against Groq's OpenAI-compatible endpoint.

Make.com

Can be rebuilt using HTTP module, JSON body mapping, response parsing, routers, and downstream CRM/notification modules.

Zapier

Can be rebuilt using AI/Webhooks steps and Paths, but deterministic profile enforcement and structured parsing are better in n8n/Make.

Not an AI Agent

C4-L does not browse, plan, email, update databases, approve its own output, or run autonomous loops. It only generates a structured lead qualification result and handoff objects.

Not Included

These are intentionally excluded from C4-L v1 and belong to other components:

Generic LLM adapter -> C2-K
Email draft generation -> C4-E
Manual review queue creation -> C5-E
CRM/database writes -> C2-A
Email sending -> C2-I
Status tracking -> C5-W
Error logging -> C6-G
Autonomous sales agent execution -> later C4 agent component
Version

v1.0

Last Tested

2026-05-25
