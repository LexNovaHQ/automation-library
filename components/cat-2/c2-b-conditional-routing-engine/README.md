# C2-B - Conditional Routing Engine

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Evaluates configurable route rules against standardized upstream component outputs and returns the next route/action.

C2-B does not execute the next workflow. It only decides the route. Parent orchestration workflows use its output to call the correct downstream component.

## Architecture
C2-B contains one n8n workflow:

1. `C2-B_CORE_Conditional_Routing_Engine_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Evaluates route rules in priority order.
   - Returns the first matched route.
   - Returns fallback route if no rule matches.
   - Returns failure if input/config is invalid.

## Workflow Files
- `workflows/c2-b-core-conditional-routing-engine-v1.json`

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
    "destination": {},
    "write": {},
    "validation": {},
    "notification": {},
    "payload": {},
    "metadata": {},
    "error": null,
    "next_action": ""
  },
  "config": {
    "rules": [],
    "fallback_route": {
      "route_key": "manual_review",
      "target_component": "C5-W",
      "next_action": "manual_review"
    }
  }
}

Route Rule Format
{
  "rule_id": "write_success_notify_team",
  "priority": 10,
  "conditions": [
    { "path": "success", "operator": "equals", "value": true },
    { "path": "write.status", "operator": "equals", "value": "created" },
    { "path": "next_action", "operator": "equals", "value": "notify_team" }
  ],
  "route": {
    "route_key": "notify_team",
    "target_component": "C2-I1",
    "next_action": "send_email_notification"
  }
}
Operators Supported in v1
equals
not_equals
exists
not_exists
in
contains
Output Contract
{
  "success": true,
  "component_id": "C2-B",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "routing": {
    "status": "matched",
    "matched": true,
    "matched_rule_id": "",
    "route_key": "",
    "target_component": "",
    "evaluated_rules": []
  },
  "source_result": {},
  "error": null,
  "next_action": ""
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
MISSING_ROUTE_RULES
Test Payloads
test-payloads/write-success-notify.valid.json
test-payloads/validation-failed-route.valid.json
test-payloads/hubspot-sales-route.valid.json
test-payloads/fallback-route.valid.json
test-payloads/missing-rules.invalid.json
Output Samples
output-samples/success-matched-notify-route.json
output-samples/success-validation-error-route.json
output-samples/success-fallback-route.json
output-samples/error-missing-route-rules.json
Passed Tests
Write success notify route
Validation failed to error queue route
HubSpot contact to sales follow-up route
Fallback manual review route
Missing route rules failure
80/20 Interoperability Rule

The reusable 80% layer is the route evaluator: reads standardized upstream output, evaluates prioritized rules, returns route metadata, and falls back safely. The configurable 20% layer is the route rule list, rule priorities, conditions, target component, and fallback route.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic rule evaluation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using routers, filters, and condition groups. For more complex priority ordering, use a small code/JSON step or sequential route checks.

Zapier

Can be rebuilt with Paths by Zapier for simple cases. Complex dynamic rule configuration is better in n8n or Make.

Not Included

These are intentionally excluded from C2-B and belong to later components:

Actually executing downstream workflow calls -> parent orchestration workflow
Email notifications -> C2-I1
Slack notifications -> C2-I2
Human approval -> C2-O
Error logging and retry queue -> C6-G
Status/control table -> C5-W
AI decisioning -> C2-K / C4
Version

v1.0

Last Tested

2026-05-25

