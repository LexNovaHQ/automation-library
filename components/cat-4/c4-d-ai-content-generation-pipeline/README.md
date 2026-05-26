# C4-D - AI Content Generation Pipeline

## Status
Built v1.0

## Category
C4 - AI / LLM Workflow Systems

## Purpose
Generates client-configured content drafts for LinkedIn posts, blog drafts, newsletters, ad copy, short scripts, landing page sections, and other non-email draft content.

C4-D v1 is not a publishing component, autonomous agent, email drafter, or approval gate. It creates structured content draft objects and C4-M-compatible approval handoffs.

## Architecture
C4-D contains one n8n workflow:

1. `C4-D_CORE_AI_Content_Generation_Pipeline_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `generate_content_draft`.
   - Requires `content_type`.
   - Requires `platform`.
   - Requires `content_goal`.
   - Requires `client_ai_profile`.
   - Requires `content_rules`.
   - Requires a content brief from `payload.content_brief`, `payload.brief`, or `payload.topic`.
   - Requires LLM config.
   - Enforces enabled content types when configured.
   - Uses content brief, source context, client profile, voice rules, content rules, offer rules, risk boundaries, and approval rules.
   - Calls Groq through OpenAI-compatible chat completions.
   - Returns standardized `content_draft`.
   - Creates C4-M handoff for approval packaging.

## Workflow Files
- `workflows/c4-d-core-ai-content-generation-pipeline-v1.json`

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
    "event_type": "content_request",
    "payload": {
      "content_brief": "",
      "topic": "",
      "source_context": "",
      "source": ""
    },
    "metadata": {},
    "error": null,
    "next_action": "generate_content_draft"
  },
  "config": {
    "content_type": "linkedin_post",
    "platform": "linkedin",
    "content_goal": "",
    "client_ai_profile": {
      "client_profile": {},
      "voice_profile": {},
      "offer_profile": {},
      "content_rules": {
        "enabled_content_types": [],
        "preferred_tone": [],
        "preferred_length": "",
        "preferred_structure": "",
        "topics_allowed": [],
        "topics_avoided": [],
        "cta_style": "",
        "external_claims_allowed": false,
        "approval_required": true,
        "platform_rules": {}
      },
      "risk_boundaries": {
        "forbidden_claims": [],
        "manual_review_triggers": []
      },
      "approval_rules": {}
    },
    "llm": {
      "provider": "groq",
      "endpoint": "https://api.groq.com/openai/v1/chat/completions",
      "model": "llama-3.3-70b-versatile",
      "temperature": 0.4,
      "max_tokens": 1000
    },
    "default_next_action": "package_draft_for_approval"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C4-D",
  "component_version": "v1",
  "event_id": "",
  "event_type": "content_request",
  "content_draft": {
    "title": "",
    "body": "",
    "platform": "",
    "content_type": "",
    "cta": "",
    "sections": [],
    "claims_used": [],
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
Content Types Supported in v1

C4-D supports any configured content type provided in content_rules.enabled_content_types.

Common test types:

linkedin_post
blog_draft
ad_copy

Other intended types:

newsletter
short_script
landing_page_section
product_description
Client Customization Standard

C4-D follows the C4 client customization standard:

stable reusable engine
configurable client profile
configurable voice profile
configurable offer profile
configurable content rules
configurable platform rules
configurable risk boundaries
stable draft output schema
approval-first external action policy

The component is designed to use:

client-assets/c4-client-ai-customization-questionnaire.md
client-assets/c4-client-ai-profile-schema.json
client-assets/sample-c4-client-ai-profile.json
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
CONTENT_GENERATION_NOT_REQUESTED
MISSING_CONTENT_TYPE
MISSING_PLATFORM
MISSING_CONTENT_GOAL
MISSING_CLIENT_AI_PROFILE
INCOMPLETE_CLIENT_AI_PROFILE
MISSING_CONTENT_BRIEF
MISSING_LLM_CONFIG
INCOMPLETE_LLM_CONFIG
UNSUPPORTED_LLM_PROVIDER
CONTENT_TYPE_NOT_ENABLED
CONTENT_DRAFT_PARSE_FAILED
MISSING_CONTENT_DRAFT
Test Payloads
test-payloads/linkedin-post.valid.json
test-payloads/blog-draft.valid.json
test-payloads/risky-ad-copy.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/content-generation-not-requested.invalid.json
test-payloads/missing-client-profile.invalid.json
test-payloads/missing-content-brief.invalid.json
Output Samples
output-samples/success-linkedin-post.json
output-samples/success-blog-draft.json
output-samples/success-risky-ad-copy.json
output-samples/error-upstream-action-failed.json
output-samples/error-content-generation-not-requested.json
output-samples/error-missing-client-profile.json
output-samples/error-missing-content-brief.json
Passed Tests
LinkedIn post
Blog draft
Risky ad copy
Upstream failed
Content generation not requested
Missing client profile
Missing content brief
80/20 Interoperability Rule

The reusable 80% layer is the content draft generator: input validation, client profile enforcement, content brief handling, content type enforcement, prompt construction, LLM call, structured draft parsing, metadata preservation, risk flag preservation, and C4-M approval handoff creation. The configurable 20% layer is client profile, voice profile, offer profile, content rules, platform rules, risk boundaries, content type, platform, content goal, LLM model, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Code nodes for prompt/request preparation and response parsing, an IF node for failure short-circuiting, and HTTP Request with Header Auth against Groq's OpenAI-compatible endpoint.

Make.com

Can be rebuilt using HTTP module, JSON body mapping, response parsing, approval modules, and downstream publishing modules.

Zapier

Can be rebuilt using AI/Webhooks steps and draft/approval steps, but deterministic rule enforcement and structured parsing are better in n8n/Make.

Not an AI Agent

C4-D does not browse, plan, execute tools, publish content, update databases, approve its own output, or run autonomous loops. It only generates a structured content draft and approval handoff object.

Not Included

These are intentionally excluded from C4-D v1 and belong to other components:

Generic LLM adapter -> C2-K
Email draft generation -> C4-E
Draft approval packaging -> C4-M
Human approval request -> C2-O
Approval response capture -> C2-O2
Publishing -> C2-Q
Status tracking -> C5-W
Error logging -> C6-G
Autonomous agent workflow execution -> later agentic component
Version

v1.0

Last Tested

2026-05-25
