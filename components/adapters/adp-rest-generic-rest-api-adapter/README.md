# ADP-REST - Generic REST API Adapter

## Status

Built v1.0

## Layer Type

INDEPENDENT_ADAPTER

## Purpose

ADP-REST is the generic REST API adapter for long-tail APIs.

It accepts a normalized REST request object and executes it through a generic HTTP request workflow.

It is used when a specialised provider adapter does not exist or is not worth building yet.

## Adapter Boundary

ADP-REST must remain provider-agnostic.

It must not contain provider-specific logic for HubSpot, Airtable, Google Sheets, Stripe, WhatsApp, Notion, Slack, Gmail, or any other named platform.

Provider-specific logic belongs in specialised adapters.

## Supported v1 Scope

- GET requests
- POST requests
- PUT requests
- PATCH requests
- DELETE requests
- headers
- query parameters
- JSON body
- no-auth public APIs

## Phase 0 Platform Setup

Platform/API: httpbin public REST test API
Endpoint: https://httpbingo.org/anything
Account needed: No
API key needed: No
n8n credential needed: No
Authentication mode: none

## Build Process

PHASE 0 - platform/API and n8n credential setup
PHASE 1 - scaffold and test payloads
PHASE 2 - build actual workflow in n8n and test
PHASE 3 - export, move, output samples, docs, audit, commit

## Files

- workflows/adp-rest-generic-rest-api-adapter-v1.json
- test-payloads/get.valid.json
- test-payloads/post.valid.json
- test-payloads/patch.valid.json
- test-payloads/delete.valid.json
- test-payloads/missing-url.invalid.json
- test-payloads/unsupported-method.invalid.json
- test-payloads/auth-mode-not-supported.invalid.json

## Version

v1.0



