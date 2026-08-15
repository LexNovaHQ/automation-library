# TPL-P0-006 - Inbound Email to Extract to CRM Update

**Status:** Implemented source template; local compile/import/end-to-end verification pending.

Takes a normalized inbound email/message payload, extracts structured fields with C4-B, validates the C4-B handoff through C2-F, and writes the resulting record through the selected Sheets/Airtable/HubSpot adapter. Gmail/Outlook/IMAP trigger adapters can feed this template upstream.
