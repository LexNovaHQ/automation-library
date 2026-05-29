# Category 2 Adapter Family Roadmap

## Purpose

This document locks the Category 2 adapter build strategy.

Instead of building dozens of isolated adapters, each adapter family follows a strict rule:

1. Build or update the universal adapter first.
2. Build the two highest-ROI platform adapters.
3. Defer the long tail.
4. Move to the next family.

## Why

This prevents adapter sprawl while still making the automation-library commercially useful for Upwork/Fiverr and client delivery.

## Build Rule

| Layer | Meaning |
|---|---|
| Universal adapter | Configurable fallback that can serve unsupported platforms through REST, webhook, SMTP, IMAP, or generic handoff. |
| Platform adapter 1 | Highest-demand provider in the family. |
| Platform adapter 2 | Second highest-demand provider in the family. |
| Deferred adapters | Long-tail platforms not built until client/job demand proves the need. |

## Family Build Matrix

| Order | Family | Universal Adapter | Platform Adapter 1 | Platform Adapter 2 | Current Status |
|---:|---|---|---|---|---|
| 1 | API / Webhook Execution | ADP-REST + ADP-WEBHOOK-SEND | N/A | N/A | Family base complete |
| 2 | Email Send / Inbox | ADP-SMTP-SEND + ADP-IMAP-INBOX | Gmail Send + Gmail Inbox | Outlook Send + Outlook Inbox | In progress |
| 3 | Team Notifications | ADP-WEBHOOK-SEND | Slack | Microsoft Teams | Planned |
| 4 | Data / CRM Write | C2-A + ADP-REST | Sheets / Airtable / HubSpot | Notion + Pipedrive | In progress |
| 5 | File Storage / Intake | ADP-FILE-HANDOFF | Google Drive | OneDrive or Dropbox | Planned |
| 6 | Calendar / Scheduling | C2-L + ADP-REST | Google Calendar | Calendly or Outlook Calendar | Planned |
| 7 | Payment | C2-H + ADP-REST | Stripe | Razorpay | Planned |
| 8 | WhatsApp / SMS | C2-M + ADP-REST | WhatsApp Cloud | Twilio | Deferred P2 |
| 9 | Task / Project Management | ADP-TASK-API | ClickUp | Trello or Asana | Planned P1 |
| 10 | Publishing | C2-Q + ADP-REST | WordPress | Webflow | Deferred |
| 11 | Document Intake / Parsing | C4-T | PDF Parser | DOCX Parser | Deferred until document template |

## Current Family

Current active family:

FAM-C2-EMAIL - Email Send and Inbox

Already built:

- ADP-GMAIL-SEND
- ADP-GMAIL-INBOX

Next builds to complete the family:

- ADP-SMTP-SEND
- ADP-IMAP-INBOX
- ADP-OUTLOOK-SEND
- ADP-OUTLOOK-INBOX

## Defer Rule

Do not build long-tail adapters unless:

1. A client/job specifically requires it.
2. The adapter is reused by at least two templates.
3. It unlocks a high-value workflow family.
4. It replaces repeated manual implementation work.

## Repo Rule

All new adapters must update:

- audit/config/component-classification.csv
- audit/config/category-2-adapter-family-roadmap.csv
- component README
- test payloads
- output samples
- audit reports

## n8n Build Rules

1. Credentials are added manually by the user inside n8n.
2. Switch fallback/extra outputs must be confirmed manually in n8n when used.
3. Every test must include payload and expected response/output shape.
4. Phase 2 should provide an importable n8n workflow JSON first.
5. Final repo artifact must use the tested/exported n8n workflow JSON.
