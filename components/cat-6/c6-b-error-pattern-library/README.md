# C6-B - Error Pattern Library

**Status:** Implemented; local runtime verification pending.

## Purpose
Normalizes common automation/provider failures into a stable failure taxonomy with likely causes, remediation steps, and a retryability decision.

## Supported v1 patterns
Authentication failure, authorization/scope failure, rate limit, timeout, not-found, duplicate/conflict, validation/mapping, provider 5xx, network connectivity, and unknown.

## Input
Pass `error` with any combination of `code`, `message`, and `status_code`.

## Output
Returns `pattern.id`, `pattern.category`, `pattern.retryable`, `likely_causes`, `remediations`, and a controlled `next_action`.

## Boundary
This component classifies evidence already available. It does not call a provider or mutate workflow state.
