# C6-C1 - Credential API Access Test Adapter

**Status:** Implemented; local import and provider verification pending.

## Purpose
Executes a minimal GET/POST/HEAD request to a provider test endpoint using one of three v1 modes: no auth, bearer token, or configurable header API key.

## Security contract
Credential material exists only in transient execution input used by the HTTP Request node. Normalized output never returns the token/API key. Never pin real secrets, commit them, or include them in screenshots.

## Boundary
This v1 is an API access tester, not a general OAuth token-flow implementation.

## Verification
No-auth smoke test can use a public test endpoint. Bearer/API-key cases require sandbox/test credentials on the new laptop before promotion to BUILT.
