# Component Catalog

## Purpose

This is the human-readable catalog index for the automation-library repo.

It summarizes the component families, their role, and their current build direction.

This document is not the machine-readable source of truth.

The machine-readable source of truth is `audit/config/component-classification.csv`.

Generated audit reports live in `audit/reports/`.

Legacy catalog content was archived at:

- `docs/archive/component-catalog-v1-legacy.md`

---

## Current Repo Baseline

Latest clean audit baseline:

| Metric | Count |
|---|---:|
| Classification rows | 80 |
| Components found | 53 |
| Built component rows | 30 |
| Built repo folders | 30 |
| Scaffold-only repo folders | 23 |
| Broken builds | 0 |
| Catalog mismatches | 0 |
| Invalid JSON files | 0 |
| Duplicate component IDs | 0 |
| Classification FAIL issues | 0 |
| Classification WARN issues | 0 |

---

## Catalog Rules

- Do not use this document as the machine-readable source of truth.
- Update `audit/config/component-classification.csv` when classification/readiness changes.
- Update local component READMEs when implementation details change.
- Use this document as a readable map of component families and build direction.
- Do not mark a component as built here unless it is also built in the classification CSV and audit output.

---

## Category Overview

| Category | Role | Current Status |
|---|---|---|
| Category 1 | Outreach / sequence infrastructure | Not built beyond scaffold/planned layer. |
| Category 2 | Universal automation core and adapters | Strongest built layer; parent router and live adapters still needed. |
| Category 3 | Onboarding / payment / document delivery | Mostly scaffold/planned. |
| Category 4 | AI workflow systems | Several reusable AI cores built; agentic layer deferred. |
| Category 5 | Dashboards / control surfaces | Base status and review components built; dashboards used as add-ons. |
| Category 6 | Fixing / debugging / reliability | C6-G built; diagnostic suite still needed. |
| Client Config | Client/job/tool/AI/credential config layer | P0 config layer built. |
| Templates | Sellable workflow glue | Intentionally later. |
| AI Agents | Controlled agentic layer | Intentionally later. |

---

## Category 1 - Outreach / Sequence Infrastructure

Role:

- outreach stack setup
- campaign/lead database structure
- segmentation and routing
- AI personalization
- multi-step follow-up sequences
- reply detection
- suppression/compliance
- sequence performance tracking

Current build direction:

- Build after Category 2 email/inbox/status/suppression foundations are stronger.
- Position as manual-approved outreach operations, not spam automation.

Key components:

| Component | Role | Current Direction |
|---|---|---|
| C1-A | Outbound stack setup / deliverability setup | Keep as launch-support category, but not first technical build. |
| C1-B | Prospect database / CRM structure | Keep as campaign data model. |
| C1-C | Lead routing / segmentation | Align with C2-B and C2-P. |
| C1-D | AI personalization engine | Align with C4-E/C4-D and CFG-004. |
| C1-E | Multi-Step Sequence Engine | Build after Gmail send/inbox adapters. |
| C1-F | Reply Detection / Inbox State Classifier | Suggested future core. |
| C1-G | Campaign Suppression + Compliance Guard | Suggested future core. |
| C1-H | Sequence Performance Tracker | Suggested dashboard add-on. |

---

## Category 2 - Universal Automation Core and Adapters

Role:

- form intake
- webhook intake
- validation
- dedupe
- routing
- data sync
- notifications
- approvals
- files
- CSV/Excel parsing
- payments/scheduling/WhatsApp/publishing handoff cores
- generic adapters

Current build direction:

- This is the immediate priority.
- Complete the parent router and universal adapters before templates.

Built base:

| Component | Role |
|---|---|
| C2-A1 | Google Sheets Write Adapter |
| C2-A2 | Airtable Write Adapter |
| C2-A3 | HubSpot Contact Write Adapter |
| C2-B | Conditional Routing Engine |
| C2-C | Webhook Trigger System |
| C2-D | Deduplication / Merge Engine |
| C2-E | Form Intake Pipeline |
| C2-F | Payload Validation Layer |
| C2-G | File Upload Routing |
| C2-H | Payment-on-Intake Flow / handoff core |
| C2-I | Notification / Alert Engine |
| C2-J | Digest Summary Notification Builder |
| C2-K | LLM in Workflow Adapter |
| C2-L | Calendar / Scheduling Automation / handoff core |
| C2-M | WhatsApp Message Automation / handoff core |
| C2-N | CSV / Excel Parser |
| C2-O | Human Approval Gate |
| C2-O2 | Approval Response Capture |
| C2-P | Suppression / Opt-Out Guard |
| C2-Q | Publishing Adapter Family / handoff core |

Immediate Cat 2 build targets:

| Component / Adapter | Role |
|---|---|
| C2-A | Parent Data Sync Router |
| ADP-REST | Generic REST API Adapter |
| ADP-WEBHOOK-SEND | Generic Webhook Sender |
| ADP-OAUTH-TEST | OAuth Credential Test Adapter |
| ADP-GMAIL-SEND | Gmail Send Adapter |
| ADP-GMAIL-INBOX | Gmail Inbox Trigger Adapter |
| ADP-SLACK-SEND | Slack Send Adapter |
| ADP-GDRIVE | Google Drive File Adapter |
| ADP-PDF | PDF Text Extraction Adapter |
| ADP-NOTION-DB | Notion Database Adapter |

---

## Category 3 - Onboarding / Payment / Document Delivery

Role:

- client intake
- payment-to-onboarding
- document/invoice generation
- welcome sequences
- delivery tracking
- client handoff packs

Current build direction:

- Build after Category 1.
- Use Cat 2 adapters for email, Drive, payment, calendar, and status/error logging.

Key components:

| Component | Role | Current Direction |
|---|---|---|
| C3-D | E-Signature Flow | Keep as handoff-first unless e-sign adapter is built. |
| C3-E | Document / Invoice Generation | Build with document/PDF adapters. |
| C3-F | Delivery Tracking | Build as onboarding/dashboard add-on. |
| C3-G | Subscription Billing Engine | Build later after payment adapters. |
| C3-H | Payment to Onboarding | Build as core Cat 3 workflow. |
| C3-I | Welcome Sequence | Build as reusable onboarding sequence core. |
| C3-M | Client Handoff Pack Builder | Suggested future core. |

Likely adapters:

- ADP-STRIPE-LINK
- ADP-RAZORPAY-LINK
- ADP-GDOC-GEN
- ADP-PDF-GEN
- ADP-GCAL-CREATE

---

## Category 4 - AI Workflow Systems

Role:

- classification
- extraction
- content generation
- email drafting
- lead qualification
- approval packaging
- OCR/document processing

Current build direction:

- Use C4 as controlled AI workflow support.
- Do not treat C4 as full autonomous agents yet.
- Agentic layer is separate and later.

Built / active AI cores:

| Component | Role |
|---|---|
| C4-A | AI Classification Pipeline |
| C4-B | AI Extraction Parser |
| C4-D | AI Content Generation Pipeline |
| C4-E | AI Email Draft Generator |
| C4-L | Lead Qualification Pipeline |
| C4-M | AI Draft Approval Pipeline |
| C4-T | OCR / Document Processing Pipeline |

Future AI workflow components:

| Component | Role |
|---|---|
| C4-C | AI Summary Generator |
| C4-F | AI Content Repurpose Engine |
| C4-K | AI Risk / Guardrail Evaluator |
| C4-N | AI CRM Note Generator |
| C4-O | AI Daily Digest Assistant |
| C4-P | AI Next-Action Recommender |
| C4-R | Escalation / Exception Handler |

---

## Category 5 - Dashboards / Control Surfaces

Role:

- status visibility
- manual review
- approval queues
- error visibility
- client delivery surfaces
- dashboards as add-ons

Current build direction:

- Category 5 is not a heavy standalone phase right now.
- Use dashboards as add-ons across Cat 1, Cat 2, Cat 3, and Cat 6.

Built dashboard/control components:

| Component | Role |
|---|---|
| C5-E | Manual Review Queue |
| C5-W | Automation Status Control Table |

Future dashboard add-ons:

| Component | Role |
|---|---|
| C5-A | Basic Dashboard View |
| C5-B | Client Portal Table |
| C5-C | Reporting Data Model |
| C5-D | KPI Summary Builder |
| C5-H | Approval Inbox View |
| C5-L | File Preview |
| C5-P | Alert / SLA Monitor |
| C5-T | Export Reports |
| C5-X | KPI Monitoring + Threshold Alert Engine |
| C5-Y | Client Handoff Dashboard Template |

---

## Category 6 - Fixing / Debugging / Reliability

Role:

- workflow audit
- API/auth debugging
- webhook health checks
- data mapping diagnostics
- integration health checks
- fix reports
- error logging and retry

Current build direction:

- Build after Cat 3.
- This is the fixing/debugging offer lane.

Built reliability component:

| Component | Role |
|---|---|
| C6-G | Error Log / Retry Queue |

Future diagnostic components:

| Component | Role |
|---|---|
| C6-A | Workflow Audit Checker |
| C6-B | Error Pattern Library |
| C6-C | API Auth / Webhook Health Debugger |
| C6-D | Data Mapping Diagnostic |
| C6-E | Integration Health Check |
| C6-F | Handoff Documentation Pack |
| C6-H | Credential / Auth Failure Classifier |
| C6-I | Retry Policy Builder |
| C6-K | Client Fix Handoff Pack Generator |
| C6-L | n8n Import/Export Validator |

---

## Client Config Layer

Role:

- client profile
- workflow discovery
- tool stack discovery
- AI profile compatibility
- credential readiness
- template config generation

Status:

- P0 client config layer is built.

Built config assets:

- CFG-001 Client Profile Schema
- CFG-002 Workflow Discovery Questionnaire
- CFG-002A Client-Facing Workflow Discovery Form
- CFG-003 Tool Stack Questionnaire
- CFG-003A Client-Facing Tool Stack Form
- CFG-004 AI Profile Compatibility Pack
- CFG-004A Client-Facing AI Customization Form
- CFG-005 Credential Collection Checklist
- CFG-005A Client-Facing Credential Checklist
- CFG-006 Template Config Generator Spec

---

## Template Glue

Role:

- assemble built core components and adapters into sellable workflows

Status:

- intentionally later
- build only after core/adapter foundation is ready

Initial future templates:

- TPL-P0-001 Lead Intake to Qualification to Follow-up
- TPL-P0-002 Form Submission to CRM Update to Team Alert
- TPL-P0-003 CSV/Excel Cleanup to CRM Import
- TPL-P0-004 Webhook to Normalize to API Sync
- TPL-P0-005 AI Email Draft to Approval to Send
- TPL-P0-006 Inbound Email to Extract to CRM Update

---

## AI Agents / Agentic Layer

Role:

- controlled agentic workflows
- tool permissioning
- memory/state
- human-in-the-loop action approval
- agent run logging and replay

Status:

- intentionally later
- use C4 AI workflow components first
- build agentic layer after Cat 2, Cat 1, Cat 3, Cat 6, and dashboard foundations are stronger

Future agentic components:

- AGT-001 Controlled Agent Workflow Executor
- AGT-002 Tool Permission / Action Policy Guard
- AGT-003 Agent Memory + State Store
- AGT-004 Human-in-the-Loop Agent Approval Gate
- AGT-005 Agent Run Log + Replay Viewer

---

## Immediate Next Build

Next technical build:

`C2-A - Parent Data Sync Router`

Reason:

- C2-A1, C2-A2, and C2-A3 are already built.
- C2-A creates a single write abstraction for future workflows.
- Future templates should call C2-A instead of directly hardcoding destination adapters.

---

## Maintenance Rule

Use this catalog as a readable map.

For exact readiness and classification details, use:

- `audit/config/component-classification.csv`
- `audit/reports/classification-summary.md`
- `audit/reports/classification-consistency.md`
- `audit/reports/component-inventory.csv`

Legacy v1 catalog is archived at:

- `docs/archive/component-catalog-v1-legacy.md`
