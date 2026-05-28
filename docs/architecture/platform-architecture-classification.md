# Platform Architecture Classification

## Purpose

This document defines the operating classification model for the automation-library repo.

It explains what each layer type means and how files should be classified.

This document does not define build order. Build order is controlled by docs/roadmap/universal-automation-roadmap.md.

Component readiness is controlled by udit/config/component-classification.csv.

---

## Source of Truth

The machine-readable source of truth is udit/config/component-classification.csv.

This CSV controls component ID, component name, folder path, layer type, readiness, execution level, adapter relationship, provider, priority, template readiness, dependencies, usage, and notes.

Human-readable docs must not override the CSV.

---

## Layer Types

| Layer Type | Meaning | Example |
|---|---|---|
| CORE_COMPONENT | Tool-agnostic reusable workflow logic | Form Intake, Validation, Dedupe, Classification |
| COMPONENT_ADAPTER | Provider/tool-specific adapter attached to a core component | Google Sheets Write Adapter under C2-A family |
| INDEPENDENT_ADAPTER | Reusable connector used across multiple components/templates | Gmail Send, Slack Send, Generic REST |
| HANDOFF_ONLY_CORE | Built core that prepares a handoff object but does not execute live provider API action | Payment, Scheduling, WhatsApp, Publishing handoff routers |
| DEFERRED_ADAPTER | Adapter intentionally planned but not built yet | Stripe live adapter, Slack live adapter |
| TEMPLATE_GLUE | Sellable workflow assembly connecting multiple components/adapters | Lead Intake to Qualification to Follow-up |
| CLIENT_CONFIG_ASSET | Questionnaire/schema/config/generator used to customize workflows per client | Client profile schema, workflow questionnaire |
| SCAFFOLD_ONLY | Folder exists but is not built | README-only component placeholder |
| DIAGNOSTIC_CORE | Diagnostic/fixing workflow logic | Workflow audit checker, API auth debugger |
| AGENTIC_CORE | Controlled AI agent execution layer | Agent workflow executor, tool permission guard |

---

## 1. Core Component

A CORE_COMPONENT is reusable workflow logic.

It answers: what job does this workflow part perform?

A core component must be provider-neutral, reusable across templates, configurable by client/job profile, independently testable, and documented with payloads and output samples.

Examples:

- C2-E Form Intake Pipeline
- C2-F Payload Validation Layer
- C2-D Deduplication / Merge Engine
- C2-B Conditional Routing Engine
- C4-A AI Classification Pipeline
- C4-B AI Extraction Parser
- C5-W Automation Status Control Table
- C6-G Error Log / Retry Queue

Rule: a core component should not be named after a single vendor unless its core job is specifically vendor execution.

---

## 2. Component Adapter

A COMPONENT_ADAPTER is a provider/tool-specific adapter attached to a core component family.

It answers: which tool/provider performs this core action?

Example core family: C2-A Data Sync Pipeline.

Attached component adapters:

- C2-A1 Google Sheets Write Adapter
- C2-A2 Airtable Write Adapter
- C2-A3 HubSpot Contact Write Adapter

Rule: component adapters should not contain unrelated business logic. They should execute a provider-specific action behind a stable core contract.

---

## 3. Independent Adapter

An INDEPENDENT_ADAPTER is a reusable connector that can be used across many components/templates.

Examples:

- ADP-REST Generic REST API Adapter
- ADP-WEBHOOK-SEND Generic Webhook Sender
- ADP-GMAIL-SEND Gmail Send Adapter
- ADP-GMAIL-INBOX Gmail Inbox Trigger Adapter
- ADP-SLACK-SEND Slack Send Adapter
- ADP-GDRIVE Google Drive File Adapter
- ADP-PDF PDF Text Extraction Adapter

Rule: independent adapters should be built when a provider action is useful across multiple categories.

---

## 4. Handoff-Only Core

A HANDOFF_ONLY_CORE is a built reusable core that prepares a structured action/handoff object but does not execute the live provider-specific action yet.

Examples:

- C2-H Payment-on-Intake Flow
- C2-L Calendar / Scheduling Automation
- C2-M WhatsApp Message Automation
- C2-Q Publishing Adapter Family
- C4-T OCR / Document Processing Pipeline

Rule: do not pretend handoff-only cores are live adapters.

---

## 5. Deferred Adapter

A DEFERRED_ADAPTER is an adapter that is expected but intentionally not built yet.

Examples:

- ADP-GMAIL-SEND
- ADP-SLACK-SEND
- ADP-STRIPE-LINK
- ADP-RAZORPAY-LINK
- ADP-GDRIVE
- ADP-PDF

Rule: if a workflow needs a deferred adapter, the assembly must mark it as an adapter gap, manual handoff, custom build need, or blocker.

---

## 6. Template Glue

TEMPLATE_GLUE is a sellable workflow assembly.

It connects core components, component adapters, independent adapters, client config, dashboard/status/error layers, and AI add-ons where applicable.

Rule: templates come after the core/adapter foundation. Templates should not hardcode provider-specific logic that belongs in adapters.

---

## 7. Client Config Asset

CLIENT_CONFIG_ASSET includes reusable intake, schema, questionnaire, profile, and config-generator files.

Examples:

- CFG-001 Client Profile Schema
- CFG-002 Workflow Discovery Questionnaire
- CFG-003 Tool Stack Questionnaire
- CFG-004 AI Profile Compatibility Pack
- CFG-005 Credential Collection Checklist
- CFG-006 Template Config Generator Spec

Rule: client config assets define customization inputs. They do not execute workflows.

---

## 8. Scaffold-Only

SCAFFOLD_ONLY means a folder exists but the component is not built.

A scaffold usually has README/placeholder folders but no workflow JSON, test payloads, or output samples.

Rule: scaffold-only components are not broken builds. They are placeholders and should not be sold as built.

---

## 9. Diagnostic Core

DIAGNOSTIC_CORE is reusable logic for fixing, debugging, auditing, and reliability work.

Examples:

- C6-A Workflow Audit Checker
- C6-B Error Pattern Library
- C6-C API Auth / Webhook Health Debugger
- C6-D Data Mapping Diagnostic
- C6-E Integration Health Check
- C6-F Handoff Documentation Pack
- C6-G Error Log / Retry Queue

Rule: diagnostic cores power Category 6 fixing/debugging offers and should produce client-readable findings, not only technical logs.

---

## 10. Agentic Core

AGENTIC_CORE is the future controlled AI agent layer.

Examples:

- AGT-001 Controlled Agent Workflow Executor
- AGT-002 Tool Permission / Action Policy Guard
- AGT-003 Agent Memory + State Store
- AGT-004 Human-in-the-Loop Agent Approval Gate
- AGT-005 Agent Run Log + Replay Viewer

Rule: agentic components come after core automation, adapters, dashboards, approvals, and error logging are mature.

Agents must be approval-first where external actions are involved, tool-permission limited, logged, replayable where possible, safe on low confidence, and reversible where possible.

---

## Build Artifact Rules

A workflow component should not be marked BUILT unless it has README, workflow JSON or executable spec, test payloads, output samples, and a classification CSV record.

A config asset/spec may be marked BUILT if it has README/spec, schema/questionnaire/example files where applicable, and a classification CSV record.

A deferred adapter should remain DEFERRED_ADAPTER until real adapter artifacts exist.

---

## Folder Strategy

Current repo structure remains category-based until the foundation is proven.

Later target structure:

- components/core/
- components/component-adapters/
- components/scaffolds/
- adapters/independent/
- templates/
- client-config/

Do not restructure folders before the roadmap says so.

---

## Relationship to Other Docs

| Doc | Role |
|---|---|
| docs/README.md | Docs index and source-of-truth rules |
| docs/roadmap/universal-automation-roadmap.md | Build order and strategy |
| docs/process/assembly-pipeline.md | Post-foundation assembly discipline |
| docs/catalog/component-catalog.md | Human-readable component catalog |
| docs/catalog/component-readiness-matrix.md | Readiness snapshot |
| udit/config/component-classification.csv | Machine-readable source of truth |
| udit/reports/* | Generated reports |

---

## Adapter Strategy Lock

The repo will not build 10-15 platform adapters blindly.

The locked adapter strategy is:

- core component
- generic REST/webhook adapter path
- 3-4 highest-demand specialised adapters
- manual/handoff fallback

## Adapter Build Rule

For each adapter family, prefer:

1. A stable core component contract.
2. A generic REST/webhook route for long-tail APIs.
3. A small number of high-ROI specialised adapters.
4. A manual/handoff fallback for unsupported providers.

Do not build low-demand provider adapters until real client/job demand proves the need.

## Immediate P0 Adapter Sprint

| Order | Adapter | Type | Why |
|---:|---|---|---|
| 1 | ADP-REST Generic REST API Adapter | Generic independent adapter | Universal long-tail API adapter. |
| 2 | ADP-WEBHOOK-SEND Generic Webhook Sender | Generic independent adapter | Universal outbound webhook adapter. |
| 3 | C6-C1 Credential API Access Test Adapter | Diagnostic adapter | Prevents credential/access failures before build. |
| 4 | ADP-GMAIL-SEND Gmail Send Adapter | Specialised adapter | Email send is universal. |
| 5 | ADP-GMAIL-INBOX Gmail Inbox Trigger Adapter | Specialised adapter | Inbound/reply workflows. |
| 6 | ADP-WHATSAPP-CLOUD WhatsApp Cloud API Adapter | Specialised adapter | Very high-demand business messaging. |
| 7 | ADP-WHATSAPP-TEMPLATE WhatsApp Template Message Adapter | Specialised adapter | Required for compliant outbound WhatsApp templates. |

## P1 Adapter Sprint

| Adapter | Type | Why |
|---|---|---|
| ADP-WHATSAPP-INBOUND | Specialised adapter | WhatsApp reply/support/lead capture. |
| ADP-SLACK-SEND | Specialised adapter | Team alerts, status, error notifications. |
| ADP-GDRIVE | Specialised adapter | File routing, onboarding, document workflows. |
| ADP-PDF | Specialised adapter | Document parsing/extraction workflows. |
| ADP-NOTION-DB | Specialised adapter | SMB/agency/creator database workflows. |
| ADP-GCAL-CREATE | Specialised adapter | Calendar event creation. |
| ADP-STRIPE-LINK | Specialised adapter | Payment links for global clients. |

## Adapter Family Rules

| Family | Core Component | Generic Route | Specialised Adapters Now | Later Only If Demand Proves |
|---|---|---|---|---|
| Data write / CRM / database | C2-A | ADP-REST, ADP-WEBHOOK-SEND | C2-A1, C2-A2, C2-A3, ADP-NOTION-DB | Pipedrive, GHL, Zoho, Close, Monday, ClickUp |
| Messaging / notification | C2-I, C2-M | ADP-REST, ADP-WEBHOOK-SEND | ADP-GMAIL-SEND, ADP-WHATSAPP-CLOUD, ADP-WHATSAPP-TEMPLATE, ADP-SLACK-SEND | Twilio, WATI, Telegram, Discord, SMS |
| Inbound message / inbox | C1-F, C2-C, C2-M | C2-C Webhook Trigger | ADP-GMAIL-INBOX, ADP-WHATSAPP-INBOUND | Outlook, Telegram, Slack inbound |
| File / document | C2-G, C4-T, C4-B | ADP-REST | ADP-GDRIVE, ADP-PDF | Dropbox, OneDrive, S3, Google Vision |
| Scheduling / calendar | C2-L | ADP-REST | ADP-GCAL-CREATE | Outlook Calendar, Calendly, Cal.com |
| Payment | C2-H, C3-H | ADP-REST | ADP-STRIPE-LINK, ADP-RAZORPAY-LINK | PayPal, Wise, Square, Paddle |

## Do-Not-Deviate Rule

Do not expand the adapter backlog just because a platform exists.

Only build a new specialised adapter when it is:

- frequently requested in client/freelance jobs,
- useful across multiple categories,
- hard to handle cleanly with ADP-REST/ADP-WEBHOOK-SEND,
- credential/auth/object-mapping heavy, or
- valuable enough to improve portfolio/demo credibility.

Current next adapter build:

ADP-REST - Generic REST API Adapter



---

## Primary Category and 80-20 Build Standard

Every component must have a clear primary category.

A component may be shared or borrowed by other categories, but its built status is judged against the job it is supposed to perform in its primary category.

## Required Classification Fields

Every component or adapter must be classed by:

- primary_category
- layer_type
- primary_job
- borrowed_by_categories
- production_80_20_status

## Allowed Layer Types

- CORE_COMPONENT
- PROVIDER_ADAPTER
- UNIVERSAL_ADAPTER
- DIAGNOSTIC_CORE
- DIAGNOSTIC_ADAPTER
- CONFIG_COMPONENT
- GLUE_TEMPLATE
- DEFERRED_ADAPTER
- SCAFFOLD_ONLY

## 80-20 Built Rule

A component may be marked BUILT only when roughly 80 percent of its production job is complete at component level.

The remaining 10-20 percent must be limited to client configuration, credential selection, account-specific IDs, field mapping, endpoint selection, template selection, or destination details.

A component is not validly built if a client job would still require rebuilding core workflow logic, adding missing validation, inventing output contracts, adding missing error handling, or redesigning the component.

## Built Status Test

Before marking any component BUILT, answer yes to all:

- Does it perform its primary category job?
- Is the workflow logic already implemented?
- Are validation paths present?
- Are success outputs normalized?
- Are error outputs normalized?
- Are manual-review, status, or error-log hooks present where relevant?
- Is client customization limited to the expected 10-20 percent?
- Can it be assembled into a real production workflow without rebuilding the component?

If any answer is no, do not mark it BUILT.

Use one of these instead:

- SCAFFOLD_ONLY
- SPEC_DRAFTED
- DEMO_ONLY
- DIAGNOSTIC_ONLY
- DEFERRED

## Category Ownership Rule

No component is category-less.

Universal components and adapters must still have a primary functional home.

Examples:

| Component | Primary Category | Layer Type | Borrowed By | Built Judgment Basis |
|---|---|---|---|---|
| C2-A Parent Data Sync Router | Category 2 | CORE_COMPONENT | Cat 1, Cat 3, Cat 4, Cat 6 | Data routing job is 80 percent implemented. |
| ADP-REST Generic REST API Adapter | Universal adapter layer / Category 2 support | UNIVERSAL_ADAPTER | Cat 1, Cat 2, Cat 3, Cat 4, Cat 6 | Generic REST execution job is production-usable with config-level customization. |
| ADP-WEBHOOK-SEND Generic Webhook Sender | Universal adapter layer / Category 2 support | UNIVERSAL_ADAPTER | Cat 1, Cat 2, Cat 3, Cat 4, Cat 6 | Outbound webhook delivery is production-usable with URL/header/payload customization. |
| Credential / API Access Diagnostic Core | Category 6 | DIAGNOSTIC_CORE | Cat 1, Cat 2, Cat 3, Cat 4, Cat 5 | Credential/API failure detection is the primary production job. |

## Do-Not-Deviate Rule

Do not mark demo workflows as BUILT.

Do not let a universal adapter pretend to be a provider adapter.

Do not let a diagnostic utility pretend to be a delivery workflow.

Do not build category-less components.

Do not continue a build if the component cannot meet the 80-20 production assembly-ready rule for its own primary category.




