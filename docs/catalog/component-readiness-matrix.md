# Component Readiness Matrix

## Purpose

This document is a human-readable readiness snapshot for the automation-library repo.

It summarizes what is built, what is scaffold-only, what is deferred, and what should be built next.

This document is not the source of truth.

The machine-readable source of truth is `audit/config/component-classification.csv`.

Generated audit reports live in `audit/reports/`.

---

## Current Audit Baseline

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

## Readiness Categories

| Readiness | Meaning |
|---|---|
| `BUILT` | Component/config asset has required artifacts and classification record. |
| `NOT_BUILT` | Component exists as a scaffold or planned row but is not implementation-ready. |
| `DEFERRED_ADAPTER` | Adapter is intentionally planned but not yet built. |
| `SCAFFOLD_ONLY` | Folder exists but has no workflow/test/output artifacts. |
| `BROKEN_BUILD` | Folder exists but required build artifacts are missing or inconsistent. |
| `CATALOG_MISMATCH` | Repo folder and catalog/classification metadata disagree. |

---

## Built Core Components

These are reusable workflow logic components currently treated as built.

| Component | Name | Layer Type | Notes |
|---|---|---|---|
| C2-B | Conditional Routing Engine | CORE_COMPONENT | Reusable branching/routing engine. |
| C2-C | Webhook Trigger System | CORE_COMPONENT | Webhook intake and normalization foundation. |
| C2-D | Deduplication / Merge Engine | CORE_COMPONENT | Duplicate detection and merge preparation. |
| C2-E | Form Intake Pipeline | CORE_COMPONENT | Form intake normalization. |
| C2-F | Payload Validation Layer | CORE_COMPONENT | Required field/schema validation. |
| C2-G | File Upload Routing | CORE_COMPONENT | Routes files by type/category. |
| C2-J | Digest Summary Notification Builder | CORE_COMPONENT | Builds digest objects. |
| C2-N | CSV / Excel Parser | CORE_COMPONENT | Parses tabular imports. |
| C2-O | Human Approval Gate | CORE_COMPONENT | Approval request creation. |
| C2-O2 | Approval Response Capture | CORE_COMPONENT | Approval/decline/revision response capture. |
| C2-P | Suppression / Opt-Out Guard | CORE_COMPONENT | Consent/suppression guard. |
| C4-A | AI Classification Pipeline | CORE_COMPONENT | AI classification of records/messages. |
| C4-B | AI Extraction Parser | CORE_COMPONENT | Structured extraction from text. |
| C4-D | AI Content Generation Pipeline | CORE_COMPONENT | General AI content generation. |
| C4-E | AI Email Draft Generator | CORE_COMPONENT | AI email draft generation. |
| C4-L | Lead Qualification Pipeline | CORE_COMPONENT | Lead scoring/qualification. |
| C4-M | AI Draft Approval Pipeline | CORE_COMPONENT | Packages drafts for approval. |
| C5-E | Manual Review Queue | CORE_COMPONENT | Manual review handoff queue. |
| C5-W | Automation Status Control Table | CORE_COMPONENT | Workflow status tracking. |
| C6-G | Error Log / Retry Queue | CORE_COMPONENT | Error capture and retry preparation. |

---

## Built Component Adapters

These adapters are currently built and attached to component families.

| Component | Name | Adapter For | Provider |
|---|---|---|---|
| C2-A1 | Google Sheets Write Adapter | Data write/sync | Google Sheets |
| C2-A2 | Airtable Write Adapter | Data write/sync | Airtable |
| C2-A3 | HubSpot Contact Write Adapter | CRM write/sync | HubSpot |
| C2-I | Notification / Alert Engine | Notification | Email/SMTP |
| C2-K | LLM in Workflow Adapter | AI/LLM call | OpenAI-compatible / Groq-style |

---

## Built Handoff-Only Cores

These are built cores that prepare structured handoff/action objects but do not yet execute every provider-specific live action.

| Component | Name | Needs Attached Adapters |
|---|---|---|
| C2-H | Payment-on-Intake Flow | Stripe, Razorpay, PayPal, Wise/payment-status adapters. |
| C2-L | Calendar / Scheduling Automation | Google Calendar, Outlook Calendar, Calendly, Cal.com adapters. |
| C2-M | WhatsApp Message Automation | WhatsApp Cloud API, Twilio, WATI adapters. |
| C2-Q | Publishing Adapter Family | LinkedIn, WordPress, Webflow, X/Twitter adapters. |
| C4-T | OCR / Document Processing Pipeline | OCR, PDF parser, DOCX parser adapters. |

---

## Built Client Config Assets

The P0 client-config layer is built.

| Component | Name | Role |
|---|---|---|
| CFG-001 | Client Profile Schema | Master client profile schema. |
| CFG-002 | Workflow Discovery Questionnaire | Internal workflow/job discovery intake. |
| CFG-002A | Client-Facing Workflow Discovery Form | Client-facing workflow discovery form. |
| CFG-003 | Tool Stack Questionnaire | Internal tool stack and adapter discovery intake. |
| CFG-003A | Client-Facing Tool Stack Form | Client-facing tool stack form. |
| CFG-004 | AI Profile Compatibility Pack | Maps CFG-001 AI profile into C4 client_ai_profile contracts. |
| CFG-004A | Client-Facing AI Customization Form | Client-facing AI customization intake. |
| CFG-005 | Credential Collection Checklist | Internal credential/access readiness checklist. |
| CFG-005A | Client-Facing Credential Checklist | Client-facing credential/access checklist. |
| CFG-006 | Template Config Generator Spec | Spec for template config, adapter gap, and assembly recommendation outputs. |

---

## Current Scaffold-Only / Not-Built Areas

These areas exist or are planned but are not yet implementation-ready.

| Area | Examples | Current Meaning |
|---|---|---|
| Category 1 | C1-E and future C1-F/C1-G/C1-H | Outreach/sequence layer not built yet. |
| Category 2 parent/adapters | C2-A, ADP-REST, ADP-GMAIL-SEND, ADP-SLACK-SEND, etc. | Cat 2 foundation still needs universal router and live adapters. |
| Category 3 | C3-D to C3-I and future C3-M | Onboarding/payment/document delivery layer not built yet. |
| Category 5 dashboards | C5-A/B/C/D/L/T/X and future add-ons | Only C5-E and C5-W are built. Dashboard layer is mostly future add-on work. |
| Category 6 diagnostics | C6-A to C6-F and future C6-H/C6-I/C6-K/C6-L | Only C6-G is built. Fixing/debugging lane still needs diagnostic tools. |
| Templates | TPL-P0-* | Template glue is intentionally later. |
| AI agents | AGT-* | Agentic layer is intentionally later. |

---

## Locked Build Priority

The current build priority is controlled by `docs/roadmap/universal-automation-roadmap.md`.

Short version:

1. Complete Category 2 universal automation core and adapters.
2. Build Category 1 outreach / sequence infrastructure.
3. Build Category 3 onboarding / payment / document delivery infrastructure.
4. Finish Category 6 fixing / debugging / reliability infrastructure.
5. Use Category 5 dashboards as add-ons across every category.
6. Build controlled AI add-ons / agentic layer after the practical base is ready.
7. Build template glue later.
8. Restructure repo later.

---

## Immediate Next Build

Next technical build:

`C2-A - Parent Data Sync Router`

Why:

- C2-A1, C2-A2, and C2-A3 are already built.
- Future templates should call one parent data-sync router instead of hardcoding destination adapters.
- Cat 1, Cat 2, Cat 3, Cat 6, dashboards, and AI add-ons all benefit from a stable write router.

---

## Maintenance Rule

Update this document only as a human-readable snapshot.

When exact counts or classification details matter, use:

- `audit/config/component-classification.csv`
- `audit/reports/classification-summary.md`
- `audit/reports/classification-consistency.md`
- `audit/reports/component-inventory.csv`
