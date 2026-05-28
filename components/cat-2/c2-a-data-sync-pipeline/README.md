# C2-A - Parent Data Sync Router

## Status

Built v1.0

## Category

Category 2 - Universal Automation Core / Adapters

## Layer Type

CORE_COMPONENT

## Purpose

C2-A is the parent data sync router for write operations.

It does not directly write to every external tool itself.

Instead, it receives a normalized write request, validates destination configuration, selects the correct destination adapter, and returns a unified write-routing result.

Current attached write adapters:

- C2-A1 Google Sheets Write Adapter
- C2-A2 Airtable Write Adapter
- C2-A3 HubSpot Contact Write Adapter

Future adapters may include:

- Notion database adapter
- Pipedrive adapter
- GoHighLevel adapter
- Generic REST write adapter
- Supabase/Postgres adapter

---

## Why This Exists

Without C2-A, templates and client workflows would hardcode write destinations directly.

That creates duplicate glue logic across templates.

C2-A gives future templates one stable write-router contract:

- send data to C2-A
- C2-A selects destination adapter
- adapter writes to provider
- C2-A returns a unified result object

---

## Router Responsibilities

C2-A is responsible for:

- accepting normalized write requests
- checking upstream validation status
- validating destination configuration
- validating provider support
- validating record payload presence
- selecting destination adapter
- preparing adapter input
- returning unified routing metadata
- flagging unsupported provider errors
- flagging missing destination errors
- flagging missing record errors
- preserving manual-review/error routing metadata

---

## What C2-A Does Not Do

C2-A does not:

- directly call Google Sheets
- directly call Airtable
- directly call HubSpot
- replace C2-A1/C2-A2/C2-A3
- perform deduplication
- perform validation beyond router-level requirements
- make live API calls itself
- suppress contacts
- send notifications

Those actions belong to other components/adapters.

---

## Input Contract

C2-A expects an input object with:

| Field | Required | Meaning |
|---|---|---|
| `request_id` | yes | Unique request/run identifier. |
| `source_component` | yes | Component that produced the write request. |
| `upstream_status` | yes | Expected `success` before routing. |
| `destination.provider` | yes | Target provider, such as `google_sheets`, `airtable`, or `hubspot`. |
| `destination.operation` | yes | Operation such as `create`, `update`, or `upsert`. |
| `destination.config` | yes | Provider-specific destination config. |
| `record` | yes | Normalized record payload to write. |
| `routing_options` | no | Retry/manual-review/status behavior. |

---

## Supported Providers v1

| Provider | Adapter | Status |
|---|---|---|
| `google_sheets` | C2-A1 | Built |
| `airtable` | C2-A2 | Built |
| `hubspot` | C2-A3 | Built |

---

## Output Contract

C2-A returns a unified router result:

| Field | Meaning |
|---|---|
| `router_status` | `routed`, `blocked`, or `error`. |
| `selected_adapter` | Adapter selected for provider. |
| `provider` | Destination provider. |
| `operation` | Requested operation. |
| `adapter_input` | Prepared input for selected adapter. |
| `manual_review_required` | Whether item should be reviewed. |
| `error_code` | Error code if routing failed. |
| `next_action` | What the caller should do next. |

---

## Error Codes

| Error Code | Meaning |
|---|---|
| `UPSTREAM_VALIDATION_FAILED` | Prior component failed. Do not route. |
| `MISSING_DESTINATION` | Destination object missing. |
| `MISSING_PROVIDER` | Destination provider missing. |
| `UNSUPPORTED_PROVIDER` | Provider is not supported by C2-A v1. |
| `MISSING_RECORD` | Record payload missing. |
| `MISSING_DESTINATION_CONFIG` | Required destination config missing. |

---

## Files

- `workflows/c2-a-core-data-sync-router-v1.json`
- `test-payloads/google-sheets-write.valid.json`
- `test-payloads/airtable-write.valid.json`
- `test-payloads/hubspot-contact-write.valid.json`
- `test-payloads/missing-destination.invalid.json`
- `test-payloads/unsupported-provider.invalid.json`
- `test-payloads/missing-record.invalid.json`
- `test-payloads/upstream-validation-failed.invalid.json`
- `output-samples/success-google-sheets-routed.json`
- `output-samples/success-airtable-routed.json`
- `output-samples/success-hubspot-routed.json`
- `output-samples/error-missing-destination.json`
- `output-samples/error-unsupported-provider.json`
- `output-samples/error-missing-record.json`
- `output-samples/error-upstream-validation-failed.json`

---

## Version

v1.0


