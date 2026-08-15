# Automation Library

Reusable n8n automation components, provider adapters, diagnostics, client configuration assets, and commercial workflow templates for practical freelance/client delivery.

## What this repository is

This is a component-first automation delivery system. Reusable logic is implemented once, tested independently, and assembled into client-specific workflows rather than rebuilt inside every project.

The primary commercial lane is practical automation work: workflow builds, API/webhook integrations, CRM/data sync, email/team notifications, AI-assisted classification/extraction/drafting, human approval, diagnostics, retries, and handoff documentation.

## Architecture

- `components/` — reusable workflow logic and component adapters.
- `adapters/independent/` — provider-specific execution adapters.
- `templates/p0/` — commercial P0 template glue assembled from reusable components.
- `client-config/` — discovery, tool-stack, credential, and template-configuration assets.
- `client-deliveries/` — reusable handoff pack templates.
- `audit/` — machine-readable classification and repository audit scripts/reports.
- `scripts/windows/` — Windows/WSL2/Docker/n8n machine bootstrap and local compile/import tools.

## Commercial P0 templates

1. `TPL-P0-001` — Lead Intake -> Qualification -> Follow-up
2. `TPL-P0-002` — Form Submission -> CRM Update -> Team Alert
3. `TPL-P0-003` — CSV/Excel Cleanup -> CRM Import
4. `TPL-P0-004` — Webhook -> Normalize -> API Sync
5. `TPL-P0-005` — AI Email Draft -> Human Approval -> Send
6. `TPL-P0-006` — Inbound Email -> Extract -> CRM Update

Template source files are portable. They reference reusable workflows with repository-path placeholders rather than machine-specific n8n workflow IDs. `scripts/windows/compile-import-library.ps1` imports the components, resolves the local workflow IDs, compiles the templates into `.build/`, and imports the compiled copies.

## Core capabilities

### Automation / data
- webhook and form intake
- validation and conditional routing
- dedupe / merge preparation
- Google Sheets, Airtable, and HubSpot writes
- CSV/Excel parsing
- generic REST and webhook execution
- file routing and storage

### Messaging / integrations
- Gmail and Outlook inbox/send adapters
- generic SMTP / IMAP
- Slack and Microsoft Teams notifications
- Google Drive and OneDrive file storage
- Notion, Pipedrive, and GoHighLevel adapters

### AI utility
- classification
- structured extraction
- summary/content generation
- email drafting
- lead qualification
- approval-first AI draft packaging

### Reliability / diagnostics
- workflow static audit
- error taxonomy
- API/auth diagnosis
- credential/API access test
- data-mapping diagnosis
- integration health aggregation
- error/retry queue
- client handoff generator

### Reporting / client visibility
- status/control table
- manual review queue
- dashboard table payloads
- reporting data model
- KPI summaries and threshold alerts
- file preview metadata
- CSV/JSON report export

## New Windows machine setup

Run the scripts in order:

1. `scripts/windows/bootstrap-01-machine.ps1` as Administrator.
2. Restart Windows if WSL/Docker requests it.
3. Launch Ubuntu once and finish first-run setup.
4. Launch Docker Desktop and enable/use the WSL2 engine.
5. Open PowerShell 7.
6. Run `scripts/windows/bootstrap-02-project.ps1`.
7. Create the fresh n8n owner account at `http://localhost:5678` if prompted.
8. Add sandbox/test credentials in n8n.
9. Run `scripts/windows/compile-import-library.ps1`.
10. Execute the verification checklist before promoting newly implemented items to `BUILT` in the machine classification.

## Security rules

- `.env`, private keys, and `.build/` are ignored by Git.
- n8n encryption keys are generated locally per machine and never committed.
- client/provider secrets belong in n8n Credentials or local environment variables, never workflow JSON, screenshots, README files, or test fixtures.
- diagnostic components should receive sanitized credential metadata, not secret values.
- external AI/email actions remain human-approval-first where the workflow can affect a person or business externally.

## Readiness model

Repository source implementation and production verification are deliberately separate:

- `SCAFFOLD` — placeholder only.
- `IMPLEMENTED` — workflow/docs/tests authored.
- `LOCAL_VERIFIED` — imports and deterministic tests pass on local n8n.
- `PROVIDER_VERIFIED` — required provider sandbox path exercised.
- `BUILT` — machine classification can be promoted after applicable gates pass.

See `docs/launch/full-build-status.md` and `docs/launch/full-build-backlog.csv` for the current full-build sprint.

## Current working branch

The August/September 2026 completion sprint is being developed on `sept-launch-full-build`. Merge to `main` only after the new-laptop import/test/provider verification gates pass.
