# C2-C — Webhook Trigger System

## Status
Built v1.0

## Category
C2 — Automation Workflows

## Purpose
Receives external webhook events and converts them into a normalized event object for downstream automation components.

This component is the reusable webhook entry layer for C2 workflows. It does not perform business-specific validation, database writes, alerts, AI classification, deduplication, or dashboards.

## Architecture
C2-C contains two n8n workflows:

1. `C2-C_CORE_Event_Normalizer_v1`
   - Reusable core component.
   - Triggered by another workflow.
   - Accepts `{ data, config }`.
   - Returns normalized success/error event object.

2. `C2-C_WEBHOOK_Receiver_Wrapper_v1`
   - External webhook wrapper.
   - Receives POST requests.
   - Converts raw external body into `{ data, config }`.
   - Calls the core normalizer.
   - Returns normalized response to caller.

## Workflow Files
- `workflows/c2-c-core-event-normalizer-v1.json`
- `workflows/c2-c-webhook-receiver-wrapper-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Webhook node
- Code node
- Execute Workflow / Execute Sub-workflow node
- Respond to Webhook node
- PowerShell for local testing

## Input Contract — Core Normalizer

```json
{
  "data": {
    "event_type": "",
    "source": "",
    "origin": "",
    "environment": "",
    "payload": {}
  },
  "config": {
    "default_next_action": "",
    "require_payload": true
  }
}

External Webhook Input Example
{
  "event_type": "lead_intake",
  "source": "webhook",
  "origin": "manual_test",
  "environment": "test",
  "payload": {
    "name": "Riya Sharma",
    "email": "riya@example.com",
    "company": "GrowthOps Studio",
    "message": "We need automation help."
  }
}
Success Output Contract
{
  "success": true,
  "component_id": "C2-C",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "source": "webhook",
  "received_at": "",
  "payload": {},
  "metadata": {
    "origin": "",
    "environment": ""
  },
  "error": null,
  "next_action": ""
}
Failure Output Contract
{
  "success": false,
  "component_id": "C2-C",
  "component_version": "v1",
  "event_id": "",
  "event_type": null,
  "source": "webhook",
  "received_at": "",
  "payload": {},
  "metadata": {
    "origin": null,
    "environment": "test"
  },
  "error": {
    "code": "",
    "message": "",
    "field": ""
  },
  "next_action": "route_to_failure_log"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_DATA_OBJECT
MISSING_EVENT_TYPE
MISSING_PAYLOAD
INVALID_PAYLOAD_TYPE
Test Payloads
test-payloads/lead-intake.valid.json
test-payloads/payment-success.valid.json
test-payloads/whatsapp-message.valid.json
test-payloads/missing-event-type.invalid.json
test-payloads/missing-payload.invalid.json
test-payloads/empty-payload.invalid.json
Output Samples
output-samples/success-output.json
output-samples/error-empty-input.json
output-samples/error-missing-event-type.json
output-samples/error-missing-payload.json
Passed Tests
Lead intake success
Payment success
WhatsApp-style message success
Missing event_type failure
Missing payload failure
Empty input failure
80/20 Interoperability Rule

The generic reusable layer is the core normalizer. The client/template-specific layer is the webhook wrapper configuration: event type, origin, environment, next action, and payload source.

Not Included

These are intentionally excluded from C2-C and belong to later components:

Business-specific payload validation → C2-F
Google Sheets / Airtable / HubSpot writes → C2-A
Slack / Gmail notifications → C2-I
AI classification or summary → C2-K / C4-A
Deduplication → C2-D
Error pattern library → C6-B
Dashboards or logs → C5
WhatsApp production signature verification → C2-M later
Stripe signature verification → C2-H later
Version

v1.0

Last Tested

2026-05-24