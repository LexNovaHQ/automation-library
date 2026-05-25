# C2-P - Suppression / Opt-Out Guard

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Checks whether a record is safe to contact before downstream outreach, messaging, calling, or campaign actions.

C2-P v1 is a suppression and consent decision engine. It does not perform live database lookup and does not mutate records. It accepts suppression records and blocked lists from input/config, evaluates the incoming payload, and returns a standardized suppression decision.

## Architecture
C2-P contains one n8n workflow:

1. `C2-P_CORE_Suppression_Opt_Out_Guard_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `suppression_check`.
   - Checks email, phone, domain, suppression records, blocked lists, and consent status.
   - Returns `allowed`, `blocked`, or `manual_review`.
   - Returns recommended action for parent orchestration workflows.

## Workflow Files
- `workflows/c2-p-core-suppression-opt-out-guard-v1.json`

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
      "message": "",
      "consent_status": ""
    },
    "metadata": {},
    "error": null,
    "next_action": "suppression_check"
  },
  "config": {
    "suppression_records": [],
    "blocked_domains": [],
    "blocked_emails": [],
    "blocked_phones": [],
    "require_consent": true,
    "allowed_consent_values": ["opted_in", "consented", "subscribed"],
    "manual_review_consent_values": ["unknown", "not_provided"],
    "default_next_action": "write_record"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-P",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "suppression": {
    "status": "clear",
    "decision": "allowed",
    "allowed_to_contact": true,
    "recommended_action": "write_record",
    "reasons": [],
    "matched_records": [],
    "checked_records": 0,
    "consent_status": ""
  },
  "source_result": {},
  "error": null,
  "next_action": "write_record"
}
Decisions Returned in v1
Decision    Meaning    Recommended Action
allowed    No suppression/blocked/consent issue detected    configured default action, usually write_record
blocked    Contact is suppressed, blocked, unsubscribed, or consent is not allowed    do_not_contact
manual_review    Consent status is missing or uncertain    manual_review
Match Signals Supported in v1
Exact suppression email match
Exact suppression phone match
Suppression email-domain match
Blocked email match
Blocked phone match
Blocked domain match
Consent status check
Unknown/missing consent manual review
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
SUPPRESSION_NOT_REQUESTED
Test Payloads
test-payloads/allowed-contact.valid.json
test-payloads/blocked-suppression-email.valid.json
test-payloads/blocked-domain.valid.json
test-payloads/manual-review-unknown-consent.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/suppression-not-requested.invalid.json
Output Samples
output-samples/success-allowed-contact.json
output-samples/success-blocked-suppression-email.json
output-samples/success-blocked-domain.json
output-samples/success-manual-review-unknown-consent.json
output-samples/error-upstream-action-failed.json
output-samples/error-suppression-not-requested.json
Passed Tests
Allowed contact
Blocked suppression email
Blocked domain
Manual review unknown consent
Upstream failed
Suppression not requested
80/20 Interoperability Rule

The reusable 80% layer is the suppression decision engine: payload normalization, blocked-list checks, suppression-record matching, consent evaluation, reasons tracking, and recommended action output. The configurable 20% layer is suppression record source, blocked lists, consent requirement, allowed consent values, manual-review consent values, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic suppression and consent evaluation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using array iterators, filters, routers, and configured blocked/suppression lists. Live lookup should happen before this component.

Zapier

Can be rebuilt for simple unsubscribe checks using lookup tables and Paths, but multi-signal suppression checks are better in n8n/Make.

Not Included

These are intentionally excluded from C2-P v1 and belong to other components:

Live suppression lookup from Airtable/Sheets/CRM/email platform -> C2-P2 or platform lookup adapters
Actual unsubscribe/writeback action -> C2-A adapters or email-platform adapters
Email/WhatsApp sending -> C2-I / C2-M
Manual review queue -> C5-E / C5-W
Error logging -> C6-G
Status tracking -> C5-W
Version

v1.0

Last Tested

2026-05-25
