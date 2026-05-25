# C2-E - Form Intake Pipeline

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Normalizes form submissions from website forms, Tally, Typeform, Google Forms response rows, Webflow, and generic webhook form payloads into a standard lead/contact payload.

C2-E v1 does not validate, dedupe, qualify, write, notify, or enrich records. It creates a normalized payload and C2-F-compatible validation handoff.

## Architecture
C2-E contains one n8n workflow:

1. `C2-E_CORE_Form_Intake_Pipeline_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `normalize_form_intake`.
   - Requires `field_map`.
   - Supports nested object paths.
   - Supports Typeform `field.ref` answer extraction.
   - Normalizes name, email, phone, company, website, message, source, consent status, and submitted timestamp.
   - Creates C2-F-compatible validation handoff.

## Workflow Files
- `workflows/c2-e-core-form-intake-pipeline-v1.json`

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
    "component_id": "C2-C",
    "component_version": "v1",
    "event_id": "",
    "event_type": "form_submission",
    "payload": {},
    "metadata": {
      "origin": "",
      "environment": "",
      "submitted_at": ""
    },
    "error": null,
    "next_action": "normalize_form_intake"
  },
  "config": {
    "form_source": "",
    "typeform_ref_mode": false,
    "field_map": {
      "name": "",
      "email": "",
      "phone": "",
      "company": "",
      "website": "",
      "message": "",
      "consent": "",
      "consent_status": ""
    },
    "default_consent_status": "not_provided",
    "validation_rules": {
      "required_fields": ["name", "email", "message"],
      "email_fields": ["email"]
    },
    "default_next_action": "validate_payload"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-E",
  "component_version": "v1",
  "event_id": "",
  "event_type": "form_submission",
  "normalized_payload": {
    "name": "",
    "email": "",
    "phone": "",
    "company": "",
    "website": "",
    "message": "",
    "source": "",
    "consent_status": "",
    "submitted_at": ""
  },
  "c2f_handoff": {
    "next_component": "C2-F",
    "input": {},
    "config": {}
  },
  "source_result": {},
  "error": null,
  "next_action": "validate_payload"
}
Supported Sources in v1
Website contact form
Generic webhook form submission
Tally-style nested payloads
Typeform field.ref answer payloads
Google Forms response rows via Google Sheets trigger / parent workflow
Webflow/custom form payloads using configured field maps
Consent Normalization

C2-E normalizes consent into:

opted_in
opted_out
not_provided
custom normalized string if provided

Boolean true becomes opted_in.
Boolean false becomes not_provided.

Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
FORM_INTAKE_NOT_REQUESTED
MISSING_FIELD_MAP
Test Payloads
test-payloads/website-form.valid.json
test-payloads/tally-form.valid.json
test-payloads/typeform-ref-form.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/form-intake-not-requested.invalid.json
test-payloads/missing-field-map.invalid.json
Output Samples
output-samples/success-website-form.json
output-samples/success-tally-form.json
output-samples/success-typeform-ref-form.json
output-samples/error-upstream-action-failed.json
output-samples/error-form-intake-not-requested.json
output-samples/error-missing-field-map.json
Passed Tests
Website form
Tally form
Typeform ref form
Upstream failed
Form intake not requested
Missing field map
80/20 Interoperability Rule

The reusable 80% layer is the form normalization engine: source payload intake, field mapping, nested path extraction, Typeform ref extraction, consent normalization, standard payload construction, and validation handoff generation. The configurable 20% layer is form source, field map, Typeform mode, validation rules, consent defaults, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic form normalization and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using webhook/custom webhook modules, JSON parsing, mapping modules, and routers.

Zapier

Can be rebuilt using form triggers, Formatter, Paths, and downstream validation/write steps.

Not Included

These are intentionally excluded from C2-E v1 and belong to other components:

Webhook trigger/front door -> C2-C
Payload validation -> C2-F
Dedupe -> C2-D
Suppression/consent guard -> C2-P
Lead qualification -> C4-L
CRM/database writes -> C2-A
Notifications -> C2-I
Error logging -> C6-G
Status tracking -> C5-W
Version

v1.0

Last Tested

2026-05-25
