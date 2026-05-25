# C4-A - AI Classification Pipeline

## Status
Built v1.0

## Category
C4 - AI / LLM Workflow Systems

## Purpose
Classifies incoming workflow records, messages, leads, support requests, spam, partnership requests, or manual-review items using client-specific classification rules.

C4-A v1 is not an autonomous agent. It does not extract full structured profiles, draft messages, send emails, update CRM records, or execute workflows. It creates a structured classification decision and downstream handoff object.

## Architecture
C4-A contains one n8n workflow:

1. `C4-A_CORE_AI_Classification_Pipeline_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `classify_input`.
   - Requires `classification_goal`.
   - Requires `client_ai_profile`.
   - Requires `classification_rules.categories`.
   - Requires LLM config.
   - Uses source payload, metadata, client profile, categories, priority rules, routing rules, and manual-review triggers.
   - Calls Groq through OpenAI-compatible chat completions.
   - Returns standardized `classification`.
   - Creates C2-B handoff for routable classifications.
   - Creates C5-E handoff for manual review classifications.

## Workflow Files
- `workflows/c4-a-core-ai-classification-pipeline-v1.json`

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
    "payload": {},
    "metadata": {},
    "error": null,
    "next_action": "classify_input"
  },
  "config": {
    "classification_mode": "rules_plus_ai",
    "classification_goal": "",
    "client_ai_profile": {
      "client_profile": {},
      "classification_rules": {
        "categories": [],
        "priority_rules": {
          "high": [],
          "medium": [],
          "low": []
        },
        "routing_rules": {},
        "manual_review_triggers": []
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
      "max_tokens": 700
    },
    "default_next_action": "route_classification"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C4-A",
  "component_version": "v1",
  "event_id": "",
  "event_type": "inbound_message",
  "classification": {
    "category": "",
    "priority": "medium",
    "confidence": "medium",
    "confidence_score": 0,
    "reasons": [],
    "risk_flags": [],
    "manual_review_required": false,
    "recommended_next_action": "",
    "provider": "groq",
    "model": "llama-3.3-70b-versatile",
    "usage": {},
    "finish_reason": ""
  },
  "c2b_handoff": {
    "next_component": "C2-B",
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
  "next_action": "route_classification"
}
Classification Categories Supported in v1

C4-A supports any client-defined category list provided in:

client_ai_profile.classification_rules.categories

Common categories used in test payloads:

qualified_lead
possible_lead
support_request
spam
partnership
manual_review
other
Recommended Next Actions Supported in v1

C4-A recommends next actions using classification_rules.routing_rules.

Common examples:

qualify_lead
route_to_support
do_not_contact
manual_review
Client Customization Standard

C4-A follows the C4 client customization standard:

stable reusable engine
configurable client profile
configurable classification categories
configurable priority rules
configurable routing rules
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
CLASSIFICATION_NOT_REQUESTED
MISSING_CLASSIFICATION_GOAL
MISSING_CLIENT_AI_PROFILE
INCOMPLETE_CLIENT_AI_PROFILE
MISSING_CLASSIFICATION_CATEGORIES
MISSING_LLM_CONFIG
INCOMPLETE_LLM_CONFIG
UNSUPPORTED_LLM_PROVIDER
CLASSIFICATION_PARSE_FAILED
MISSING_CLASSIFICATION
INVALID_CLASSIFICATION_CATEGORY
Test Payloads
test-payloads/qualified-lead-classification.valid.json
test-payloads/support-request-classification.valid.json
test-payloads/spam-classification.valid.json
test-payloads/manual-review-classification.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/classification-not-requested.invalid.json
test-payloads/missing-client-profile.invalid.json
Output Samples
output-samples/success-qualified-lead-classification.json
output-samples/success-support-request-classification.json
output-samples/success-spam-classification.json
output-samples/success-manual-review-classification.json
output-samples/error-upstream-action-failed.json
output-samples/error-classification-not-requested.json
output-samples/error-missing-client-profile.json
Passed Tests
Qualified lead classification
Support request classification
Spam classification
Manual review classification
Upstream failed
Classification not requested
Missing client profile
80/20 Interoperability Rule

The reusable 80% layer is the classification processor: input validation, client profile enforcement, category enforcement, prompt construction, LLM call, structured classification parsing, allowed-category validation, C2-B routing handoff creation, and C5-E manual-review handoff creation. The configurable 20% layer is client profile, category list, priority rules, routing rules, manual-review triggers, risk boundaries, LLM model, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Code nodes for prompt/request preparation and response parsing, an IF node for failure short-circuiting, and HTTP Request with Header Auth against Groq's OpenAI-compatible endpoint.

Make.com

Can be rebuilt using HTTP module, JSON body mapping, response parsing, routers, and downstream CRM/notification modules.

Zapier

Can be rebuilt using AI/Webhooks steps and Paths, but deterministic category enforcement and structured parsing are better in n8n/Make.

Not an AI Agent

C4-A does not browse, plan, execute tools, send emails, update databases, approve its own output, or run autonomous loops. It only generates a structured classification decision and handoff objects.

Not Included

These are intentionally excluded from C4-A v1 and belong to other components:

Generic LLM adapter -> C2-K
Field extraction -> C4-B
Lead qualification -> C4-L
Conditional routing execution -> C2-B
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
