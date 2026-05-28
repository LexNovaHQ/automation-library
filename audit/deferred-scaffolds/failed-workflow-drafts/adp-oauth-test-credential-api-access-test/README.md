# ADP-OAUTH-TEST - Credential / API Access Test Adapter

## Status

Phase 1 scaffold and test payloads ready; n8n workflow export pending

## Layer Type

INDEPENDENT_ADAPTER

## Purpose

ADP-OAUTH-TEST is a diagnostic adapter for testing whether an API access pattern works before building a client workflow.

It helps detect missing tokens, bad auth modes, bad headers, expired credentials, or unsupported auth patterns early.

## Adapter Boundary

ADP-OAUTH-TEST is not a provider-specific adapter.

It does not contain Gmail, Google Sheets, HubSpot, Airtable, WhatsApp, Slack, Stripe, or Notion-specific logic.

Provider-specific OAuth setup belongs in specialised adapters.

## Supported v1 Scope

- no-auth endpoint test
- bearer token header test
- header API key test
- missing endpoint validation
- missing token validation
- missing API key validation
- unsupported auth mode validation

## Not Supported in v1

- full OAuth2 authorization-code setup
- refresh token rotation
- provider-specific scopes
- provider-specific credential creation
- browser-based auth consent flows

## Phase 0 Platform Setup

Platform/API: httpbingo public test API
Account needed: No
Real API key needed: No
n8n credential needed: No for v1
Credential values: dummy test token/key supplied in payload

## Build Process

PHASE 0 - platform/API and n8n credential setup
PHASE 1 - scaffold and test payloads
PHASE 2 - build actual workflow in n8n and test
PHASE 3 - export, move, output samples, docs, audit, commit

## Files

- workflows/adp-oauth-test-credential-api-access-test-v1.json
- test-payloads/no-auth.valid.json
- test-payloads/bearer-token.valid.json
- test-payloads/header-api-key.valid.json
- test-payloads/missing-url.invalid.json
- test-payloads/missing-bearer-token.invalid.json
- test-payloads/missing-api-key.invalid.json
- test-payloads/unsupported-auth-mode.invalid.json

## Version

v1.0
