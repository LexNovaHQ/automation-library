# ADP-WEBHOOK-SEND - Generic Webhook Sender

## Status

Built v1.0

## Layer Type

INDEPENDENT_ADAPTER

## Purpose

ADP-WEBHOOK-SEND is the generic outbound webhook sender adapter.

It accepts a normalized webhook send request and delivers a JSON payload to a target webhook URL.

It is used when a workflow needs to push data to an external webhook endpoint without building a specialised provider adapter.

## Adapter Boundary

ADP-WEBHOOK-SEND must remain provider-agnostic.

It must not contain provider-specific logic for Slack, Discord, Airtable, HubSpot, WhatsApp, Gmail, Stripe, Notion, or any other named platform.

Provider-specific webhook formats belong in specialised adapters or template glue.

## Supported v1 Scope

- outbound POST webhook delivery
- headers
- query parameters
- JSON payload
- no-auth public webhook endpoints
- normalized success response
- normalized validation error response

## Phase 0 Platform Setup

Platform/API: httpbingo public webhook-style endpoint
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

- workflows/adp-webhook-send-generic-webhook-sender-v1.json
- test-payloads/webhook-send.valid.json
- test-payloads/webhook-send-with-query.valid.json
- test-payloads/webhook-send-minimal.valid.json
- test-payloads/missing-url.invalid.json
- test-payloads/missing-payload.invalid.json
- test-payloads/auth-mode-not-supported.invalid.json

## Version

v1.0

