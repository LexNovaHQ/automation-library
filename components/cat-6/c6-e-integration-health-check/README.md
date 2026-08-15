# C6-E - Integration Health Check

**Status:** Implemented; local verification pending.

## Purpose
Aggregates runtime checks from credentials, mappings, webhooks, provider tests, and other diagnostics into one integration health result.

## Input
`checks[]` with `name`, `status` (`pass|warn|fail`), optional `critical`, `detail`, `latency_ms`, and `source`.

## Output
Health status (`healthy|warning|degraded|down`), score, counts, normalized checks, and next action.

## Pairing
Feed results from C6-C1, C6-D, webhook tests, and provider-specific smoke tests into this component.
