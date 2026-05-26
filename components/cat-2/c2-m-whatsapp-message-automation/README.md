# C2-M - WhatsApp Message Automation

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Prepares provider-agnostic WhatsApp message handoffs for WhatsApp Cloud API, Twilio WhatsApp, WATI, and manual WhatsApp workflows.

C2-M v1 does not directly send WhatsApp messages. It prepares structured WhatsApp message objects and downstream provider/manual handoff objects.

## Architecture
C2-M contains one n8n workflow:

1. `C2-M_CORE_WhatsApp_Message_Automation_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `prepare_whatsapp_message`.
   - Requires provider and mode.
   - Requires recipient phone.
   - Requires message body for text messages.
   - Supports approval-required gating.
   - Supports allowed message type gating.
   - Supports WhatsApp Cloud API provider handoff.
   - Supports Twilio WhatsApp provider handoff.
   - Supports WATI provider handoff.
   - Supports manual WhatsApp review handoff.
   - Does not call WhatsApp/Twilio/WATI APIs directly.

## Workflow Files
- `workflows/c2-m-core-whatsapp-message-automation-v1.json`

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
    "event_type": "approved_message",
    "payload": {
      "recipient_name": "",
      "recipient_phone": "",
      "message_body": "",
      "message_type": "",
      "context": ""
    },
    "approved_action": {
      "approved": true,
      "action": "prepare_whatsapp_message"
    },
    "metadata": {},
    "error": null,
    "next_action": "prepare_whatsapp_message"
  },
  "config": {
    "provider": "whatsapp_cloud_api",
    "mode": "provider_handoff",
    "message_format": "text",
    "from_phone_number_id": "",
    "business_account_id": "",
    "from_whatsapp_number": "",
    "wati_api_endpoint": "",
    "requires_approval": true,
    "approval_status_required": true,
    "allowed_message_types": [],
    "reviewer_email": "",
    "default_next_action": "send_whatsapp_provider_handoff"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-M",
  "component_version": "v1",
  "event_id": "",
  "event_type": "approved_message",
  "whatsapp_message": {
    "provider": "",
    "mode": "",
    "status": "ready",
    "message_format": "text",
    "message_type": "",
    "recipient": {
      "name": "",
      "phone": ""
    },
    "body": "",
    "context": "",
    "requires_approval": true,
    "approval_status_required": true,
    "prepared_at": ""
  },
  "provider_handoff": {
    "next_component": "",
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
  "next_action": "send_whatsapp_provider_handoff"
}
Providers Supported in v1
whatsapp_cloud_api
twilio_whatsapp
wati
manual
Modes Supported in v1
provider_handoff
manual_handoff
Message Formats Supported in v1
text
template
Provider / Mode Rules
Provider    Supported Mode    Output
whatsapp_cloud_api    provider_handoff    WhatsApp Cloud API adapter handoff
twilio_whatsapp    provider_handoff    Twilio WhatsApp adapter handoff
wati    provider_handoff    WATI adapter handoff
manual    manual_handoff    C5-E manual review handoff
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
WHATSAPP_NOT_REQUESTED
MISSING_PROVIDER
MISSING_MODE
UNSUPPORTED_PROVIDER
UNSUPPORTED_MODE
UNSUPPORTED_MESSAGE_FORMAT
INVALID_PROVIDER_MODE
MESSAGE_NOT_APPROVED
MISSING_RECIPIENT_PHONE
MISSING_MESSAGE_BODY
MESSAGE_TYPE_NOT_ALLOWED
MISSING_CLOUD_API_PHONE_NUMBER_ID
MISSING_TWILIO_FROM_NUMBER
MISSING_WATI_ENDPOINT
Test Payloads
test-payloads/whatsapp-cloud-api.valid.json
test-payloads/twilio-whatsapp.valid.json
test-payloads/wati-handoff.valid.json
test-payloads/manual-whatsapp.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/whatsapp-not-requested.invalid.json
test-payloads/missing-provider.invalid.json
test-payloads/missing-recipient-phone.invalid.json
test-payloads/missing-message-body.invalid.json
test-payloads/not-approved.invalid.json
Output Samples
output-samples/success-whatsapp-cloud-api.json
output-samples/success-twilio-whatsapp.json
output-samples/success-wati-handoff.json
output-samples/success-manual-whatsapp.json
output-samples/error-upstream-action-failed.json
output-samples/error-whatsapp-not-requested.json
output-samples/error-missing-provider.json
output-samples/error-missing-recipient-phone.json
output-samples/error-missing-message-body.json
output-samples/error-not-approved.json
Passed Tests
WhatsApp Cloud API
Twilio WhatsApp
WATI handoff
Manual WhatsApp
Upstream failed
WhatsApp not requested
Missing provider
Missing recipient phone
Missing message body
Not approved
80/20 Interoperability Rule

The reusable 80% layer is the WhatsApp message preparation engine: input validation, provider/mode validation, approval gating, message type gating, recipient/body validation, provider payload construction, provider adapter handoff creation, and manual review handoff creation. The configurable 20% layer is provider, mode, sender identity, API endpoint, approval policy, allowed message types, reviewer, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic WhatsApp handoff preparation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using routers, filters, HTTP modules, Twilio/WATI modules, and manual approval paths.

Zapier

Can be rebuilt using Paths, Webhooks, Twilio actions, and manual review steps.

Not Included

These are intentionally excluded from C2-M v1 and belong to other components/adapters:

AI WhatsApp message drafting -> C4-E or future message draft component
Draft approval packaging -> C4-M
Human approval request -> C2-O
Approval response capture -> C2-O2
Actual WhatsApp Cloud API send -> future WhatsApp Cloud API adapter
Actual Twilio WhatsApp send -> future Twilio adapter
Actual WATI send -> future WATI adapter
Status tracking -> C5-W
Error logging -> C6-G
Digest/summary -> C2-J
Version

v1.0

Last Tested

2026-05-25
