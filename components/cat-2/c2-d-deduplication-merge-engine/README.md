# C2-D - Deduplication & Merge Engine

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Evaluates whether an incoming validated record is new, a possible duplicate, or a confirmed duplicate before downstream write actions.

C2-D v1 is a dedupe decision engine. It does not perform live database lookup and does not mutate records. It accepts candidate records from input/config, scores them against the incoming payload, and returns a standardized dedupe decision for downstream routing.

## Architecture
C2-D contains one n8n workflow:

1. `C2-D_CORE_Deduplication_Merge_Engine_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `dedupe_check`.
   - Scores candidate records against the incoming payload.
   - Returns `new_record`, `possible_duplicate`, or `duplicate`.
   - Returns recommended action for parent orchestration workflows.

## Workflow Files
- `workflows/c2-d-core-deduplication-merge-engine-v1.json`

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
    "event_type": "",
    "payload": {
      "name": "",
      "email": "",
      "phone": "",
      "company": "",
      "website": ""
    },
    "metadata": {},
    "error": null,
    "next_action": "dedupe_check"
  },
  "config": {
    "candidate_records": [],
    "rules": {
      "exact_email_score": 100,
      "exact_phone_score": 90,
      "exact_domain_score": 70,
      "exact_company_score": 50,
      "exact_name_score": 30,
      "duplicate_threshold": 90,
      "possible_duplicate_threshold": 60
    },
    "default_next_action": "write_record"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-D",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "dedupe": {
    "status": "clear",
    "decision": "new_record",
    "recommended_action": "create_record",
    "best_match": null,
    "best_score": 0,
    "checked_candidates": 0,
    "match_reasons": [],
    "candidate_results": [],
    "thresholds": {
      "duplicate_threshold": 90,
      "possible_duplicate_threshold": 60
    }
  },
  "source_result": {},
  "error": null,
  "next_action": "write_record"
}
Decisions Returned in v1
Decision    Meaning    Recommended Action
new_record    No candidate crossed possible duplicate threshold    create_record
possible_duplicate    Candidate crossed possible duplicate threshold but not duplicate threshold    manual_review
duplicate    Candidate crossed duplicate threshold    update_existing_record
Match Signals Supported in v1
Exact email match
Exact phone match
Exact domain match from website or email
Exact company match
Exact name match
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
DEDUPE_NOT_REQUESTED
Test Payloads
test-payloads/new-record.valid.json
test-payloads/exact-email-duplicate.valid.json
test-payloads/possible-duplicate.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/dedupe-not-requested.invalid.json
Output Samples
output-samples/success-new-record.json
output-samples/success-exact-email-duplicate.json
output-samples/success-possible-duplicate.json
output-samples/error-upstream-action-failed.json
output-samples/error-dedupe-not-requested.json
Passed Tests
New record
Exact email duplicate
Possible duplicate
Upstream failed
Dedupe not requested
80/20 Interoperability Rule

The reusable 80% layer is the dedupe decision engine: payload normalization, candidate scoring, threshold evaluation, match reason tracking, and recommended action output. The configurable 20% layer is candidate source, scoring weights, duplicate thresholds, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic candidate scoring and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using array iterators, filters, scoring variables, and routers. Live lookup should be handled before this component.

Zapier

Can be rebuilt for simple exact email dedupe using Find/Create actions, but multi-signal scoring is better in n8n/Make.

Not Included

These are intentionally excluded from C2-D v1 and belong to other components:

Live Airtable/Sheets/HubSpot candidate lookup -> C2-D2 / C2-A / platform-specific lookup adapters
Actual record creation/update/merge -> C2-A adapters
Manual review queue -> C5-E / C5-W
Error logging -> C6-G
Status tracking -> C5-W
Version

v1.0

Last Tested

2026-05-25
