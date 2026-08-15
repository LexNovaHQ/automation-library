# ADP-ONEDRIVE - OneDrive Small File Upload Adapter

**Status:** Implemented; local import and Microsoft Graph provider verification pending.

## Job
Upload a small binary file to the signed-in user's OneDrive through Microsoft Graph.

## Input
- `request_id`
- `parent_id` — OneDrive parent folder item ID
- `filename`
- `binary_property` — defaults to `data`
- incoming n8n binary data in that property

## Provider contract
Uses `PUT /me/drive/items/{parent-id}:/{filename}:/content`. Microsoft Graph currently supports this single-call upload path for files up to 250 MB; larger files require an upload session.

## Security / verification
Set `MS_GRAPH_ACCESS_TOKEN` only in local `.env` for controlled sandbox verification. Least-privileged delegated permission for this path is `Files.ReadWrite`. Production/client deployments should use a proper stored n8n Microsoft credential rather than an environment token.
