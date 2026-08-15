# ADP-NOTION-DB - Notion Data Source Page Adapter

**Status:** Implemented; provider verification pending.

## Job
Create a page under a Notion data source using the current Notion API page-creation contract.

## Input
`request_id`, `data_source_id`, and a Notion-compatible `properties` object.

## Verification
Set `NOTION_API_TOKEN` in local `.env`, share the target data source with the test integration, and execute the sandbox case. The adapter sends `Notion-Version: 2026-03-11`. Production/client deployments should bind a proper n8n credential.
