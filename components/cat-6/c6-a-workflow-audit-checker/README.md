# C6-A - Workflow Audit Checker

**Status:** Implemented on `sept-launch-full-build`; local import/runtime verification pending.

## Purpose
Audits an n8n workflow export for structural and operational red flags before a repair or client handoff.

## Input
Pass `workflow` as an n8n workflow JSON object. The checker reviews trigger presence, graph connectivity, generic node names, resilience/error controls, possible literal secrets, and basic export settings.

## Output
Returns `audit.score`, `audit.blocking`, and structured `audit.findings[]` with severity, code, message, remediation, and affected node where available.

## Boundaries
This is a static audit. It cannot prove that credentials, provider APIs, or live webhooks work. Pair it with C6-C/C6-C1 and C6-E for runtime/provider checks.

## Verification
Run both cases in `test-payloads/cases.json`; capture the resulting output into the expected contract before promoting the classification row to `BUILT`.
