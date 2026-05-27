# Universal Automation Roadmap

## Purpose

This roadmap defines the build order for the automation-library repo.

The goal is to build a practical freelance-ready automation library for Upwork/Fiverr/client delivery, without turning the repo into a confusing universal-platform project too early.

---

## Locked Strategy

The repo will not move into template glue first.

The locked build order is:

1. Complete Category 2 universal automation core and adapters
2. Build Category 1 outreach / sequence infrastructure
3. Build Category 3 onboarding / payment / document delivery infrastructure
4. Finish Category 6 fixing / debugging / reliability infrastructure
5. Use Category 5 dashboards as add-ons across every category
6. Then build controlled AI agents / AI add-ons
7. Use AI add-ons as free bonuses for the first 5-10 jobs
8. Build template glue after the core/adapter foundation is ready
9. Restructure the repo only after the foundation is proven

---

## Current Baseline

Latest audit baseline:

| Metric | Count |
|---|---:|
| Components found | 53 |
| Built components | 30 |
| Scaffold-only components | 23 |
| Broken builds | 0 |
| Catalog mismatches | 0 |
| Invalid JSON files | 0 |
| Duplicate component IDs | 0 |
| Classification rows | 80 |
| Classification FAIL issues | 0 |
| Classification WARN issues | 0 |

Current strength:

- intake
- validation
- dedupe
- routing
- AI classification / extraction / generation
- approval
- notification
- CRM/sheet writing
- status tracking
- error logging
- manual review
- client config layer

Current gap:

- parent data sync router
- live provider adapters
- outreach sequence infrastructure
- onboarding/payment/document delivery infrastructure
- fixing/debugging components beyond C6-G
- dashboard add-ons beyond base status/manual review/error logs
- controlled AI agent layer
- template glue

---

## Phase 1 - Category 2 Universal Automation Core + Adapters

### Objective

Complete the reusable automation base layer that every other category depends on.

### Build Order

| Order | Component / Adapter | Classification | Why |
|---:|---|---|---|
| 1 | C2-A Parent Data Sync Router | Core router | Gives templates one write abstraction instead of hardcoding Sheets/Airtable/HubSpot. |
| 2 | ADP-REST Generic REST API Adapter | Independent adapter | Universal fallback for unsupported tools. |
| 3 | ADP-WEBHOOK-SEND Generic Webhook Sender | Independent adapter | Needed for webhook/API sync jobs. |
| 4 | ADP-OAUTH-TEST OAuth Credential Test Adapter | Diagnostic adapter | Prevents auth/credential failures before build. |
| 5 | ADP-GMAIL-SEND Gmail Send Adapter | Independent adapter | Needed for Cat 1, Cat 2, Cat 3, and AI email workflows. |
| 6 | ADP-GMAIL-INBOX Gmail Inbox Trigger Adapter | Independent adapter | Needed for inbound email and reply workflows. |
| 7 | ADP-SLACK-SEND Slack Send Adapter | Independent adapter | Needed for team alerts, status, and error notifications. |
| 8 | ADP-GDRIVE Google Drive File Adapter | Independent adapter | Needed for file routing, onboarding, document delivery. |
| 9 | ADP-PDF PDF Text Extraction Adapter | Independent adapter | Needed for document workflows and extraction jobs. |
| 10 | ADP-NOTION-DB Notion Database Adapter | Independent adapter | Useful for SMB, creator, agency, and internal ops workflows. |

Optional later Category 2 adapters:

- ADP-PIPEDRIVE
- ADP-GHL
- ADP-GCAL-CREATE
- ADP-STRIPE-LINK
- ADP-RAZORPAY-LINK

---

## Phase 2 - Category 1 Outreach / Sequence Infrastructure

Category 1 should support manual-approved outreach ops, not spam automation.

Build targets:

| Component / Adapter | Classification | Notes |
|---|---|---|
| C1-E Multi-Step Sequence Engine | Core | Follow-ups, delays, reply states, stop conditions. |
| C1-F Reply Detection / Inbox State Classifier | Core + adapter dependent | Uses Gmail inbox/reply events. |
| C1-G Campaign Suppression + Compliance Guard | Core | Outreach-specific compliance layer over C2-P. |
| C1-H Sequence Performance Tracker | Dashboard/core bridge | Shows sent, replied, bounced, opted out, follow-up due. |
| ADP-GMAIL-SEND | Adapter | Required for controlled sending. |
| ADP-GMAIL-INBOX | Adapter | Required for reply tracking. |

Commercial use:

- lead list to approved email drafts
- manual-approved cold outreach workflow
- follow-up sequence setup
- reply tracking
- opt-out/suppression flow
- campaign status dashboard

---

## Phase 3 - Category 3 Onboarding / Payment / Document Delivery

Build targets:

| Component / Adapter | Classification | Notes |
|---|---|---|
| C3-E Document / Invoice Generation | Core + adapter dependent | Needs document/PDF generation. |
| C3-H Payment to Onboarding | Core glue | Payment event or payment confirmation triggers onboarding. |
| C3-I Welcome Sequence / Reminder Scheduler | Core | Welcome emails, reminders, follow-up tasks. |
| C3-F Delivery Tracking / Approval Status Workflow | Core | Tracks onboarding and delivery completion. |
| C3-M Client Handoff Pack Builder | Core | Final delivery docs, links, instructions, status. |
| ADP-STRIPE-LINK | Adapter | Payment links/invoices for global clients. |
| ADP-RAZORPAY-LINK | Adapter | India-facing payment workflows. |
| ADP-GDOC-GEN | Adapter | Google Docs generation. |
| ADP-PDF-GEN | Adapter | PDF generation/export. |
| ADP-GCAL-CREATE | Adapter | Calendar event creation. |

Commercial use:

- payment received to onboarding workflow
- invoice generation workflow
- client onboarding workflow
- welcome email/CRM setup
- delivery tracker
- handoff pack

---

## Phase 4 - Category 6 Fixing / Debugging / Reliability

This is commercially important because many early freelance jobs are fixing jobs, not full builds.

Build targets:

| Component | Classification | Notes |
|---|---|---|
| C6-A Workflow Audit Checker | Diagnostic core | Checklist/SOP for broken workflow jobs. |
| C6-B Error Pattern Library | Diagnostic core | Reusable failure taxonomy. |
| C6-C API Auth / Webhook Health Debugger | Diagnostic adapter/core | Auth, webhook, API health checks. |
| C6-D Data Mapping Diagnostic | Diagnostic core | Payload/schema/mapping mismatch analysis. |
| C6-E Integration Health Check | Diagnostic core | Overall integration state. |
| C6-F Handoff Documentation Pack | Docs core | Fix report and client handoff. |
| C6-G Error Log / Retry Queue | Core | Already built; supports every category. |
| C6-H Credential / Auth Failure Classifier | Diagnostic core | Works with OAuth/API debugging. |
| C6-I Retry Policy Builder | Diagnostic core | Converts failure analysis into retry/manual-review rules. |
| C6-K Client Fix Handoff Pack Generator | Docs core | High-value deliverable for fixing jobs. |
| C6-L n8n Import/Export Validator | Diagnostic adapter | Checks workflow JSON before delivery/import. |

Commercial use:

- fix broken n8n workflow
- debug webhook/API auth
- repair data mapping
- add retry/error handling
- workflow audit and documentation

---

## Phase 5 - Dashboard Add-Ons

Category 5 is not a heavy standalone build phase right now.

Dashboards are add-ons across Category 1, Category 2, Category 3, and Category 6.

Every serious workflow should include:

- status table
- manual review queue
- error log / retry queue

Dashboard add-on targets:

| Dashboard Add-On | Category Supported | Priority | Notes |
|---|---|---:|---|
| C5-W Automation Status Control Table | All | Built | Base status/control table. |
| C5-E Manual Review Queue | Cat 2 / Cat 4 / Cat 6 | Built | Approval/review queue. |
| C6-G Error Log / Retry Queue | All | Built | Error/retry visibility. |
| C1-H Sequence Performance Tracker | Cat 1 | P1 | Outreach tracking. |
| C3-F Onboarding / Delivery Tracker | Cat 3 | P1 | Client delivery tracking. |
| C6-K Client Fix Handoff Pack Generator | Cat 6 | P1 | Fix summary / what broke / what changed. |

---

## Phase 6 - Controlled AI Add-Ons / Agentic Layer

AI agents are not the first build phase.

They are built after the practical automation foundation is ready.

Initial AI add-ons should be small, controlled, approval-first, and useful as free bonuses for the first 5-10 jobs.

Initial AI add-ons:

| Add-On | Use Case | Boundary |
|---|---|---|
| AI lead scorer | Cat 1 / Cat 2 | No autonomous sending. |
| AI inbox triage | Cat 1 / Cat 2 | Manual approval for external actions. |
| AI CRM note generator | Cat 2 / Cat 3 | No invented facts. |
| AI email draft assistant | Cat 1 / Cat 2 / Cat 3 | Approval-first. |
| AI document summary/extraction assistant | Cat 3 / Cat 4 | Low confidence routes to manual review. |
| AI error summarizer | Cat 6 | Diagnostic only; no destructive action. |
| AI daily digest assistant | Cat 5 add-on | Summary only. |
| AI next-action recommender | All | Recommendation only unless approved. |

Later agentic components:

| Component | Classification | Timing |
|---|---|---|
| AGT-001 Controlled Agent Workflow Executor | Agentic core | Later |
| AGT-002 Tool Permission / Action Policy Guard | Agent safety core | Later |
| AGT-003 Agent Memory + State Store | Agent core + adapter | Later |
| AGT-004 Human-in-the-Loop Agent Approval Gate | Agent/core bridge | Later |
| AGT-005 Agent Run Log + Replay Viewer | Diagnostic/core | Later |

Do not build fully autonomous agents until action permissions, run logs, approval gates, and rollback/retry logic are mature.

---

## Phase 7 - Template Glue

Template glue comes after the core/adapter foundation.

Templates should assemble existing components and adapters. They should not compensate for missing adapters by hardcoding provider-specific logic.

Initial template candidates after foundation:

- TPL-P0-001 Lead Intake to Qualification to Follow-up
- TPL-P0-002 Form Submission to CRM Update to Team Alert
- TPL-P0-003 CSV/Excel Cleanup to CRM Import
- TPL-P0-004 Webhook to Normalize to API Sync
- TPL-P0-005 AI Email Draft to Approval to Send
- TPL-P0-006 Inbound Email to Extract to CRM Update

---

## Phase 8 - Repo Restructure

Do not fully restructure the repo yet.

Final restructure happens after:

- Category 2 foundation
- Category 1
- Category 3
- Category 6
- dashboard add-ons
- initial AI add-ons

Target later structure:

- components/core/
- components/component-adapters/
- components/scaffolds/
- adapters/independent/
- templates/
- client-config/

---

## Next Build

The next technical build is:

`C2-A - Parent Data Sync Router`

This completes the existing C2-A family:

- C2-A1 Google Sheets Write Adapter
- C2-A2 Airtable Write Adapter
- C2-A3 HubSpot Contact Write Adapter

Future templates should call C2-A instead of hardcoding C2-A1/C2-A2/C2-A3 directly.
