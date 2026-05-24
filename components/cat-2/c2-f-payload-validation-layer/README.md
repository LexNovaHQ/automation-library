# C2-F — Payload Validation Layer

## Status
Built v1.0

## Category
C2 — Automation Workflows

## Purpose
Validates normalized event payloads from C2-C before routing them to downstream components.

C2-F checks whether required business fields are present and whether field values satisfy configurable validation rules. It does not receive external webhooks directly and does not write to databases, send alerts, call AI, or create dashboards.

## Architecture
C2-F contains one n8n workflow:

1. `C2-F_CORE_Payload_Validator_v1`
   - Reusable core validation component.
   - Triggered by another workflow.
   - Accepts `{ event, config }`.
   - Returns validation success/failure output.

## Workflow Files
- `workflows/c2-f-core-payload-validator-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- Edit Fields / Set node
- PowerShell / local JSON files for testing

## Input Contract

```json
{
  "event": {
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
    "next_action": "validate_payload"
  },
  "config": {
    "required_fields": [],
    "field_rules": {},
    "default_next_action": "route_payload"
  }
}

Config Rules Supported in v1
{
  "required_fields": ["name", "email", "message"],
  "field_rules": {
    "email": "email",
    "message": "min_length:10",
    "amount": "number",
    "payment_status": "allowed:paid,failed,pending"
  },
  "default_next_action": "route_payload"
}
Success Output Contract
{
  "success": true,
  "component_id": "C2-F",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "source_component": "C2-C",
  "payload": {},
  "metadata": {},
  "validation": {
    "status": "passed",
    "checked_fields": [],
    "failed_fields": []
  },
  "error": null,
  "next_action": "route_payload"
}
Failure Output Contract
{
  "success": false,
  "component_id": "C2-F",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "source_component": "C2-C",
  "payload": {},
  "metadata": {},
  "validation": {
    "status": "failed",
    "checked_fields": [],
    "failed_fields": []
  },
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Payload failed validation.",
    "details": []
  },
  "next_action": "route_to_failure_log"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_EVENT_OBJECT
UPSTREAM_EVENT_FAILED
MISSING_OR_INVALID_PAYLOAD
VALIDATION_FAILED
Validation Rules Covered in v1
Required field check
Email format check
Minimum string length check
Number check
Allowed values check
Unknown validation rule detection
Test Payloads
test-payloads/lead-intake.valid.json
test-payloads/payment-success.valid.json
test-payloads/lead-intake.missing-email.invalid.json
test-payloads/lead-intake.invalid-email.invalid.json
test-payloads/lead-intake.short-message.invalid.json
test-payloads/empty-payload.invalid.json
Output Samples
output-samples/success-output.json
output-samples/error-missing-required-field.json
output-samples/error-invalid-email.json
output-samples/error-min-length.json
output-samples/error-empty-payload.json
Passed Tests
Valid lead intake
Valid payment success
Missing email failure
Invalid email failure
Short message failure
Empty payload failure
80/20 Interoperability Rule

The reusable 80% layer is the generic validation engine. The configurable 20% layer is the validation config: required fields, field rules, allowed values, and default next action.

Not Included

These are intentionally excluded from C2-F and belong to later components:

External webhook receiving → C2-C
Database writes → C2-A
Conditional routing after validation → C2-B
Slack / Gmail notifications → C2-I
AI classification or summary → C2-K / C4-A
Deduplication → C2-D
Error pattern library → C6-B
Dashboards or logs → C5
Version

v1.0

Last Tested

2026-05-25