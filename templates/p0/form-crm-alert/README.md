# TPL-P0-002 - Form Submission to CRM Update to Team Alert

**Status:** Implemented source template; local compile/import/end-to-end verification pending.

## Outcome
Normalize a form submission, validate it, write it to Google Sheets/Airtable/HubSpot, then send a human-facing alert by email or Microsoft Teams.

## Components
C2-E -> C2-F -> selected C2-A1/A2/A3 -> C2-I1 or ADP-TEAMS-SEND.

## Portability
The source workflow uses `__WF::<repo path>__` placeholders. Run `scripts/windows/compile-import-library.ps1` to resolve them to the local n8n workflow IDs.

## Required config
`form_event`, `form_config`, `validation`, `destination.provider`, `destination.config`, and `alert`.
