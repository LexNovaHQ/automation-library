# Independent Adapters

## Purpose

This folder contains reusable external-system adapters that are not owned by one core component.

Independent adapters can be used across templates and components.

Examples:

- Generic REST API Adapter
- Generic Webhook Sender
- OAuth Credential Test Adapter
- Gmail Send Adapter
- Gmail Inbox Trigger Adapter
- Slack Send Adapter
- Google Drive File Adapter
- Notion Database Adapter
- Pipedrive Adapter
- GoHighLevel Adapter

## Classification

Layer type: `INDEPENDENT_ADAPTER`

## Build Rule

An independent adapter should:

- accept a standard input object
- execute or prepare one external-system action
- return a standard output contract
- preserve source metadata
- fail safely into error/retry/manual-review paths
- avoid hardcoding one client configuration
