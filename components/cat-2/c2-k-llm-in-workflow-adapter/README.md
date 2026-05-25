# C2-K - Groq/OpenAI-Compatible LLM Adapter

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Calls a configured LLM provider from inside an automation workflow and returns a standardized AI result object.

C2-K v1 is a safe LLM-in-workflow adapter, not an autonomous AI agent. It prepares a prompt, calls a Groq/OpenAI-compatible chat completions endpoint, parses the response, and returns structured output for downstream routing, approval, writing, notification, or status tracking.

## Architecture
C2-K contains one n8n workflow:

1. `C2-K_CORE_Groq_OpenAI_Compatible_LLM_Adapter_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `run_ai`.
   - Prepares an OpenAI-compatible chat completions request.
   - Calls Groq using HTTP Request and Header Auth.
   - Parses JSON response content when possible.
   - Returns a standardized `ai_result` object.

## Workflow Files
- `workflows/c2-k-core-groq-openai-compatible-llm-adapter-v1.json`

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
    "next_action": "run_ai"
  },
  "config": {
    "provider": "groq",
    "endpoint": "https://api.groq.com/openai/v1/chat/completions",
    "model": "llama-3.3-70b-versatile",
    "task_type": "",
    "system_instruction": "",
    "user_instruction": "",
    "response_format": "json_object",
    "temperature": 0.2,
    "max_tokens": 600,
    "default_next_action": "route_ai_result"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-K",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "ai_result": {
    "provider": "groq",
    "model": "llama-3.3-70b-versatile",
    "task_type": "",
    "status": "completed",
    "content": "",
    "parsed_json": {},
    "usage": {},
    "finish_reason": ""
  },
  "source_result": {},
  "error": null,
  "next_action": "route_ai_result"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
AI_NOT_REQUESTED
MISSING_PROVIDER
UNSUPPORTED_PROVIDER
MISSING_ENDPOINT
MISSING_MODEL
MISSING_TASK_TYPE
Warning State Covered in v1
AI_RESPONSE_PARSE_WARNING

This warning is returned when the LLM response is received but cannot be parsed as JSON. In that case, raw content is still preserved and ai_result.status becomes completed_unparsed.

Test Payloads
test-payloads/lead-summary.valid.json
test-payloads/content-classification.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/missing-model.invalid.json
test-payloads/ai-not-requested.invalid.json
Output Samples
output-samples/success-lead-summary.json
output-samples/success-content-classification.json
output-samples/error-upstream-action-failed.json
output-samples/error-missing-model.json
output-samples/error-ai-not-requested.json
Passed Tests
Lead summary
Content classification
Upstream failed
Missing model
AI not requested
80/20 Interoperability Rule

The reusable 80% layer is the LLM adapter: input validation, prompt/request preparation, provider endpoint call, response parsing, source preservation, and standardized AI result output. The configurable 20% layer is provider, endpoint, model, task type, system instruction, user instruction, temperature, max tokens, response format, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses HTTP Request with Header Auth against Groq's OpenAI-compatible chat completions endpoint.

Make.com

Can be rebuilt using HTTP module with Bearer token header, JSON body, and response parsing.

Zapier

Can be rebuilt using Webhooks by Zapier or AI action steps, but deterministic JSON parsing and failure control are better in n8n/Make.

Model-Agnostic Design

C2-K v1 is implemented with Groq for the free/demo provider, but the component is intentionally model-agnostic. The same request/response pattern can be adapted for OpenAI-compatible providers such as OpenRouter or other compatible gateways. Non-compatible providers such as Gemini or Claude may require separate request-shape adapters.

Not an AI Agent

C2-K does not plan, browse, use tools, execute external actions, approve outputs, send emails, write records, or run autonomous loops. It only calls an LLM and returns a structured result.

Agentic execution belongs to later C4 components.

Not Included

These are intentionally excluded from C2-K v1 and belong to other components:

AI draft approval pipeline -> C4-M
Human approval -> C2-O
Routing AI result -> C2-B
Writing AI result -> C2-A
Notification -> C2-I
Status tracking -> C5-W
Error logging -> C6-G
Autonomous AI agent/tool execution -> later C4 agent component
Version

v1.0

Last Tested

2026-05-25
