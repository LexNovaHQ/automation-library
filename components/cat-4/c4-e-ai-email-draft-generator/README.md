# C4-E - AI Email Draft Generator

## Status
Built v1.0

## Category
C4 - AI / LLM Workflow Systems

## Purpose
Generates client-configured, approval-ready email draft objects from lead/context payloads.

C4-E v1 is not a generic AI email writer and not an autonomous agent. It uses a client AI profile, email task config, and lead/source context to generate a structured email draft. It does not send emails, publish content, update CRM records, or make final business decisions.

## Architecture
C4-E contains one n8n workflow:

1. `C4-E_CORE_AI_Email_Draft_Generator_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `generate_email_draft`.
   - Requires `client_ai_profile`.
   - Requires LLM config.
   - Prepares a client-configured email drafting prompt.
   - Calls Groq through OpenAI-compatible chat completions.
   - Parses structured `email_draft`.
   - Creates C4-M-compatible handoff for approval packaging.

## Workflow Files
- `workflows/c4-e-core-ai-email-draft-generator-v1.json`

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
    "error": null,
    "next_action": "generate_email_draft"
  },
  "config": {
    "email_type": "first_response",
    "email_goal": "",
    "recipient_context": "",
    "client_ai_profile": {
      "client_profile": {},
      "audience_profile": {},
      "voice_profile": {},
      "offer_profile": {},
      "email_rules": {},
      "risk_boundaries": {},
      "approval_rules": {}
    },
    "llm": {
      "provider": "groq",
      "endpoint": "https://api.groq.com/openai/v1/chat/completions",
      "model": "llama-3.3-70b-versatile",
      "temperature": 0.2,
      "max_tokens": 700
    },
    "default_next_action": "package_draft_for_approval"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C4-E",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "email_draft": {
    "subject": "",
    "body": "",
    "cta": "",
    "email_type": "",
    "personalization_used": [],
    "assumptions": [],
    "risk_flags": [],
    "approval_required": true,
    "provider": "groq",
    "model": "llama-3.3-70b-versatile",
    "usage": {},
    "finish_reason": ""
  },
  "c4m_handoff": {
    "next_component": "C4-M",
    "input": {},
    "config": {}
  },
  "source_result": {},
  "error": null,
  "next_action": "package_draft_for_approval"
}
Client Customization Standard

C4-E follows the C4 client customization standard:

stable reusable engine
configurable client profile
configurable voice profile
configurable offer profile
configurable email rules
configurable examples/risk boundaries
stable output schema
approval-first external action policy

The component is designed to use:

client-assets/c4-client-ai-customization-questionnaire.md
client-assets/c4-client-ai-profile-schema.json
client-assets/sample-c4-client-ai-profile.json
Email Draft Fields

C4-E returns:

subject
body
cta
email_type
personalization_used
assumptions
risk_flags
approval_required
LLM provider/model metadata
C4-M handoff object
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
EMAIL_DRAFT_NOT_REQUESTED
MISSING_EMAIL_TYPE
MISSING_EMAIL_GOAL
MISSING_CLIENT_AI_PROFILE
INCOMPLETE_CLIENT_AI_PROFILE
MISSING_LLM_CONFIG
INCOMPLETE_LLM_CONFIG
UNSUPPORTED_LLM_PROVIDER
EMAIL_DRAFT_PARSE_FAILED
MISSING_EMAIL_DRAFT
Test Payloads
test-payloads/first-response-email.valid.json
test-payloads/follow-up-email.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/email-draft-not-requested.invalid.json
test-payloads/missing-client-profile.invalid.json
test-payloads/missing-llm-config.invalid.json
Output Samples
output-samples/success-first-response-email.json
output-samples/success-follow-up-email.json
output-samples/error-upstream-action-failed.json
output-samples/error-email-draft-not-requested.json
output-samples/error-missing-client-profile.json
output-samples/error-missing-llm-config.json
Passed Tests
First response email
Follow-up email
Upstream failed
Email draft not requested
Missing client profile
Missing LLM config
80/20 Interoperability Rule

The reusable 80% layer is the email draft generator: input validation, client profile enforcement, prompt construction, LLM call, structured draft parsing, metadata preservation, and C4-M approval handoff creation. The configurable 20% layer is client profile, voice profile, offer profile, email rules, risk boundaries, approval rules, email type, email goal, recipient context, LLM model, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Code nodes for prompt/request preparation and response parsing, plus HTTP Request with Header Auth against Groq's OpenAI-compatible endpoint.

Make.com

Can be rebuilt using HTTP module, JSON body mapping, response parsing, and approval/database modules.

Zapier

Can be rebuilt using AI/Webhooks steps and Tables/approval steps, but deterministic profile enforcement and structured parsing are better in n8n/Make.

Not an AI Agent

C4-E does not browse, plan, use tools, send emails, update databases, approve its own output, or run autonomous loops. It only generates a structured draft and handoff object.

Not Included

These are intentionally excluded from C4-E v1 and belong to other components:

Generic LLM adapter -> C2-K
Draft approval packaging -> C4-M
Human approval request -> C2-O
Approval response capture -> C2-O2
Email sending -> C2-I / future sender adapter
CRM/database writes -> C2-A
Status tracking -> C5-W
Error logging -> C6-G
Autonomous AI agent execution -> later C4 agent component
Version

v1.0

Last Tested

2026-05-25
