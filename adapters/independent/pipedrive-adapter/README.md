# ADP-PIPEDRIVE - Pipedrive Person Create Adapter

**Status:** Implemented; provider verification pending.

## Job
Create a Pipedrive person through the current v2 Persons endpoint.

## Input
`request_id`, `person.name`, optional emails/phones/org/owner fields.

## Verification
For the local sandbox path set `PIPEDRIVE_COMPANY_DOMAIN` and `PIPEDRIVE_API_TOKEN` in `.env`. Pipedrive documents API-token authentication via query string; for client/production use, prefer a stored n8n credential/OAuth path so tokens aren't exposed in request URLs or execution logs.
