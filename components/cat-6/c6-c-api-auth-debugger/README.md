# C6-C - API/Auth Debugger

**Status:** Implemented; local runtime verification pending.

## Purpose
Diagnoses authentication, token-expiry, scope/permission, and access-path failures from sanitized evidence.

## Security boundary
Do not pass token, API-key, password, or other secret values into this diagnostic. Pass only status codes, response text, auth type, expiry metadata, and granted/required scope names. Use C6-C1 for a controlled live access test.

## Output
Returns a diagnosis category, confidence, structured checks, manual-review flag, and next action.
