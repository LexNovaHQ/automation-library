# Failed Draft Note - ADP-OAUTH-TEST

## Status
Parked failed draft. Not production built. Not active.

## Reason
This workflow was originally attempted as ADP-OAUTH-TEST under an adapter path, but it does not fit the Category 2 universal automation adapter model.

It functionally belongs under Category 6 debugging/reliability as a credential/API access diagnostic adapter attached to C6-C API Auth Debugger.

## Problems Identified

- The workflow name says OAuth, but the implementation does not perform OAuth flows such as authorization-code, refresh-token, or client-credentials token exchange.
- The implementation only tests none, bearer_token, and header_api_key request modes.
- Header API key execution hardcodes X-API-Key instead of using credential.header_name.
- HTTP response normalization loses original request context unless the tested API echoes it back.
- Credential material can leak into output objects.
- The workflow did not pass tests and had broken/fragile node connections.

## Superseding Component

Future rebuild should be:

- Component ID: C6-C1
- Name: Credential API Access Test Adapter
- Primary category: Category 6 - Debugging / Reliability
- Parent core: C6-C API Auth Debugger
- Layer type: COMPONENT_ADAPTER or future DIAGNOSTIC_ADAPTER
- Readiness: NOT_BUILT until rebuilt cleanly

## Rule

Do not commit this draft as a built workflow. Use only as historical reference.
