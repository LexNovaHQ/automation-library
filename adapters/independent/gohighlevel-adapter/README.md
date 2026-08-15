# ADP-GHL - GoHighLevel Contact Upsert Adapter

**Status:** Implemented; local import and provider verification pending.

## Job
Upsert a contact into a HighLevel sub-account using the documented Contacts API.

## Input
`request_id`, `locationId`, and `contact` fields such as email, phone, firstName, lastName.

## Local verification
Set `GHL_ACCESS_TOKEN` only in local `.env` using a sandbox/private-integration token. The workflow uses the documented `/contacts/upsert` endpoint and the required API version header. Production/client deployments should use n8n Credentials rather than long-lived environment tokens.
