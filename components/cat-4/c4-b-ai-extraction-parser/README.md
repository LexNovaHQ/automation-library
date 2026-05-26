# C4-B - AI Extraction Parser

## Status
Built v1.0

## Category
C4 - AI / LLM Workflow Systems

## Purpose
Extracts structured fields from messy text, emails, notes, form messages, transcripts, or document text using client-specific extraction rules.

C4-B v1 is not a classifier, lead qualifier, email drafter, workflow executor, or autonomous agent. It extracts fields only and returns structured extraction results plus downstream handoff objects.

## Architecture
C4-B contains one n8n workflow:

1. `C4-B_CORE_AI_Extraction_Parser_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `extract_fields`.
   - Requires `extraction_goal`.
   - Requires `client_ai_profile`.
   - Requires `extraction_rules.required_fields`.
   - Requires raw text from `payload.raw_text`, `payload.message`, or `payload.text`.
   - Requires LLM config.
   - Uses raw text, source payload, upstream context, client profile, extraction rules, and risk/manual-review rules.
   - Calls Groq through OpenAI-compatible chat completions.
   - Returns standardized `extraction`.
   - Creates C2-F handoff for clean extracted payloads.
   - Creates C5-E handoff for missing/low-confidence/manual-review extractions.

## Workflow Files
- `workflows/c4-b-core-ai-extraction-parser-v1.json`

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
    "event_type": "inbound_message",
    "payload": {
      "raw_text": ""
    },
    "classification": {},
    "metadata": {},
    "error": null,
    "next_action": "extract_fields"
  },
  "config": {
    "extraction_mode": "rules_plus_ai",
    "extraction_goal": "",
    "client_ai_profile": {
      "client_profile": {},
      "extraction_rules": {
        "required_fields": [],
        "optional_fields": [],
        "missing_required_field_action": "manual_review",
        "allow_inference": false,
        "never_infer_fields": [],
        "low_confidence_action": "manual_review",
        "manual_review_confidence_threshold": 0.75
      },
      "risk_boundaries": {
        "manual_review_triggers": []
      },
      "approval_rules": {}
    },
    "llm": {
      "provider": "groq",
      "endpoint": "https://api.groq.com/openai/v1/chat/completions",
      "model": "llama-3.3-70b-versatile",
      "temperature": 0.1,
      "max_tokens": 800
    },
    "default_next_action": "validate_payload"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C4-B",
  "component_version": "v1",
  "event_id": "",
  "event_type": "inbound_message",
  "extraction": {
    "extracted_fields": {},
    "field_confidence": {},
    "missing_required_fields": [],
    "low_confidence_fields": [],
    "assumptions": [],
    "risk_flags": [],
    "manual_review_required": false,
    "recommended_next_action": "validate_payload",
    "provider": "groq",
    "model": "llama-3.3-70b-versatile",
    "usage": {},
    "finish_reason": ""
  },
  "c2f_handoff": {
    "next_component": "C2-F",
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
  "next_action": "validate_payload"
}
Extraction Rules Supported in v1
Required fields
Optional fields
Missing required field action
Inference disabled/enabled flag
Never-infer field list
Low confidence action
Manual review confidence threshold
Risk/manual-review triggers
Client Customization Standard

C4-B follows the C4 client customization standard:

stable reusable engine
configurable client profile
configurable required fields
configurable optional fields
configurable inference policy
configurable confidence threshold
configurable manual-review triggers
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
EXTRACTION_NOT_REQUESTED
MISSING_EXTRACTION_GOAL
MISSING_CLIENT_AI_PROFILE
INCOMPLETE_CLIENT_AI_PROFILE
MISSING_REQUIRED_FIELDS
MISSING_LLM_CONFIG
INCOMPLETE_LLM_CONFIG
UNSUPPORTED_LLM_PROVIDER
MISSING_RAW_TEXT
EXTRACTION_PARSE_FAILED
MISSING_EXTRACTION
Test Payloads
test-payloads/inbound-lead-text.valid.json
test-payloads/support-text.valid.json
test-payloads/missing-required-fields.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/extraction-not-requested.invalid.json
test-payloads/missing-client-profile.invalid.json
test-payloads/missing-raw-text.invalid.json
Output Samples
output-samples/success-inbound-lead-text.json
output-samples/success-support-text.json
output-samples/success-missing-required-fields.json
output-samples/error-upstream-action-failed.json
output-samples/error-extraction-not-requested.json
output-samples/error-missing-client-profile.json
output-samples/error-missing-raw-text.json
Passed Tests
Inbound lead text
Support text
Missing required fields
Upstream failed
Extraction not requested
Missing client profile
Missing raw text
80/20 Interoperability Rule

The reusable 80% layer is the extraction parser: input validation, client profile enforcement, raw text selection, extraction rule enforcement, prompt construction, LLM call, structured extraction parsing, missing-required detection, low-confidence detection, C2-F validation handoff creation, and C5-E manual-review handoff creation. The configurable 20% layer is client profile, required fields, optional fields, inference policy, confidence threshold, risk boundaries, LLM model, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Code nodes for prompt/request preparation and response parsing, an IF node for failure short-circuiting, and HTTP Request with Header Auth against Groq's OpenAI-compatible endpoint.

Make.com

Can be rebuilt using HTTP module, JSON body mapping, response parsing, routers, and downstream validation/review modules.

Zapier

Can be rebuilt using AI/Webhooks steps and Paths, but deterministic extraction rule enforcement and structured parsing are better in n8n/Make.

Not an AI Agent

C4-B does not browse, plan, execute tools, send emails, update databases, approve its own output, classify as its main job, or run autonomous loops. It only extracts structured fields and returns handoff objects.

Not Included

These are intentionally excluded from C4-B v1 and belong to other components:

Generic LLM adapter -> C2-K
Classification -> C4-A
Lead qualification -> C4-L
Payload validation -> C2-F
Conditional routing -> C2-B
Manual review queue creation -> C5-E
CRM/database writes -> C2-A
Email sending -> C2-I
Status tracking -> C5-W
Error logging -> C6-G
Autonomous agent workflow execution -> later agentic component
Version

v1.0

Last Tested

2026-05-25
