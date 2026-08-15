# TPL-P0-003 - CSV/Excel Cleanup to CRM Import

**Status:** Implemented source template; local compile/import/end-to-end verification pending.

Parses normalized spreadsheet rows with C2-N, expands them into per-record items, validates each through C2-F, writes each through the selected Sheets/Airtable/HubSpot adapter, and returns an import summary.
