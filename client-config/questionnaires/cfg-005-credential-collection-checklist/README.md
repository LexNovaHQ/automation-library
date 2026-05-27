# CFG-005 - Credential Collection Checklist

## Status
Built v1.0

## Layer Type
CLIENT_CONFIG_ASSET

## Purpose
Internal credential and access-readiness checklist for automation delivery.

It captures:

- required tool access
- credential type needed
- access ownership
- OAuth/API key readiness
- workspace invite needs
- sandbox/test availability
- production restrictions
- security/privacy constraints
- adapter readiness
- blockers before implementation

## File
- `../credential-collection-checklist.md`
- `../../examples/credential-readiness-response.example.json`

## Assembly Engine Role
The future Assembly Engine will use credential readiness to decide:

- whether implementation can start
- whether only mock/demo build is possible
- which adapters are blocked by missing access
- whether manual handoff is required
- whether credential/security constraints change the implementation plan

## Version
v1.0
