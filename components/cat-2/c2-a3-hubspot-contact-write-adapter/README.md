# C2-A3 - HubSpot Contact Write Adapter

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Creates HubSpot contacts from validated C2-F event payloads using a configurable HubSpot property map.

C2-A3 is the third destination adapter in the C2-A Data Sync Pipeline family. It writes contact records to HubSpot after upstream validation has passed.

## Architecture
C2-A3 contains one n8n workflow:

1. `C2-A3_CORE_HubSpot_Contact_Write_Adapter_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream validation outputs.
   - Maps payload fields to HubSpot contact properties.
   - Creates a HubSpot contact through the HubSpot CRM Contacts API using HTTP Request.
   - Returns a standard write success/failure object.

## Workflow Files
- `workflows/c2-a3-core-hubspot-contact-write-adapter-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- IF node
- HTTP Request node
- HubSpot Service Key
- HubSpot CRM Contacts API

## Input Contract

```json
{
  "input": {
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
  },
  "config": {
    "destination": "hubspot",
    "object_type": "contacts",
    "field_map": {},
    "default_next_action": "notify_team"
  }
}

Config Example
{
  "destination": "hubspot",
  "object_type": "contacts",
  "field_map": {
    "payload.firstname": "firstname",
    "payload.lastname": "lastname",
    "payload.email": "email",
    "payload.company": "company",
    "payload.message": "message"
  },
  "default_next_action": "notify_team"
}
Output Contract
{
  "success": true,
  "component_id": "C2-A3",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "destination": {
    "type": "hubspot",
    "object_type": "contacts",
    "record_id": ""
  },
  "write": {
    "status": "created",
    "fields_written": []
  },
  "payload": {},
  "metadata": {},
  "error": null,
  "next_action": "notify_team"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_VALIDATION_FAILED
MISSING_OBJECT_TYPE
UNSUPPORTED_OBJECT_TYPE
MISSING_FIELD_MAP
MISSING_EMAIL_PROPERTY
Test Payloads
test-payloads/contact-write.valid.json
test-payloads/upstream-validation-failed.invalid.json
test-payloads/missing-field-map.invalid.json
Output Samples
output-samples/success-output.json
output-samples/error-upstream-validation-failed.json
output-samples/error-missing-field-map.json
Passed Tests
Valid HubSpot contact write
Upstream validation failed
Missing field map
HubSpot Service Key read/write confirmed
80/20 Interoperability Rule

The reusable 80% layer is the HubSpot contact write adapter: validated input, property mapping, create-contact request, write result normalization, and failure blocking. The configurable 20% layer is the HubSpot object type, property map, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses HTTP Request with HubSpot Service Key and HubSpot CRM Contacts API.

Make.com

Can be rebuilt using Make scenario input, JSON mapping, and HubSpot > Create a Contact module. The same input contract, field map, and output samples should be used.

Zapier

Can be rebuilt for simple cases using Zapier trigger + Formatter/Code by Zapier + HubSpot Create Contact. Complex failure handling is better in n8n/Make.

Not Included

These are intentionally excluded from C2-A3 and belong to later components:

Google Sheets write -> C2-A1
Airtable write -> C2-A2
Deduplication / update existing contact -> C2-D
Conditional routing -> C2-B
Notifications -> C2-I
AI summary/classification -> C2-K / C4-A
Dashboard/logs -> C5
Version

v1.0

Last Tested

2026-05-25