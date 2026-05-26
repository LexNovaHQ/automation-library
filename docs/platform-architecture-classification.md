# Platform Architecture Classification

## Purpose

This document defines the operating classification for the automation-library repository.

The old view treated every folder as a "component." The new platform view separates reusable workflow logic, tool-specific execution, independent connectors, sellable template glue, and client configuration assets.

This prevents numbering confusion and makes the repo usable for real client automation work.

---

## Master Classification

| Layer Type | Meaning | Example |
|---|---|---|
| `CORE_COMPONENT` | Tool-agnostic reusable workflow logic engine | Form Intake, Validation, Dedupe, Classification |
| `COMPONENT_ADAPTER` | Provider/tool-specific adapter attached to a core component | Google Calendar adapter for Scheduling |
| `INDEPENDENT_ADAPTER` | Reusable connector used across many components/templates | Generic REST, Gmail Send, Slack Send |
| `TEMPLATE_GLUE` | Sellable workflow assembly connecting multiple components/adapters | Lead Intake to Qualification to Follow-up |
| `CLIENT_CONFIG_ASSET` | Questionnaire/schema/config used to customize workflows per client | Client profile schema, workflow questionnaire |
| `SCAFFOLD_ONLY` | Folder exists but component is not built | README-only scaffold |
| `DEFERRED_ADAPTER` | Adapter intentionally not built yet but expected later | Stripe live adapter, WhatsApp Cloud API send adapter |
| `HANDOFF_ONLY_CORE` | Built core that prepares handoff objects but does not execute provider API calls | Payment, Scheduling, WhatsApp, Publishing handoff routers |

---

## 1. Core Component

A `CORE_COMPONENT` is a reusable workflow logic engine.

It answers:

```text
What job does this workflow part perform?
It must be:

provider-neutral
client-configurable
reusable across templates
deterministic where possible
tested with payloads and output samples

Examples:

C2-E Form Intake Pipeline
C2-F Payload Validation Layer
C2-D Deduplication / Merge Engine
C2-B Conditional Routing Engine
C4-A AI Classification Pipeline
C4-B AI Extraction Parser
C5-W Automation Status Control Table
C6-G Error Log / Retry Queue

A core component should not be named after a single vendor unless its core job is specifically vendor execution.

2. Component Adapter

A COMPONENT_ADAPTER is a provider/tool-specific execution adapter attached to a core component.

It answers:

Which tool/provider performs this core action?

Example:

Core: C2-L Calendar / Scheduling Automation

Attached adapters:
- Google Calendar Create Event Adapter
- Outlook Calendar Adapter
- Calendly Webhook Adapter
- Cal.com Adapter

Another example:

Core: C2-H Payment-on-Intake Flow

Attached adapters:
- Stripe Payment Link Adapter
- Razorpay Payment Link Adapter
- PayPal Invoice Adapter
- Wise Manual Payment Adapter

Adapters should:

accept standardized handoff objects from the core component
execute the provider-specific action
return a standard result object
preserve source metadata
fail safely into error/retry/manual-review paths
3. Independent Adapter

An INDEPENDENT_ADAPTER is a reusable connector not owned by one core component.

It answers:

What external system connector can be reused across many workflows?

Examples:

Generic REST API Adapter
Gmail Send Adapter
Gmail Inbox Trigger Adapter
Slack Send Adapter
Google Drive File Adapter
Notion Database Adapter
OAuth Credential Test Adapter

Why independent?

Because a Slack send adapter can be used by:

C2-I Notification
C2-O Approval Gate
C2-J Digest Builder
C6-G Error Alerting
C5-W Status Alerting

Therefore it should not be trapped under only one component.

4. Template Glue

A TEMPLATE_GLUE workflow connects multiple core components and adapters into a client-ready automation.

It answers:

How do the reusable parts connect for a real business use case?

Example:

Lead Intake to Qualification to Follow-up

C2-E Form Intake
→ C2-F Validation
→ C2-D Dedupe
→ C4-L Lead Qualification
→ C2-A1 Google Sheets Write
→ C4-E Email Draft
→ C4-M Draft Approval Package
→ C2-O Approval Gate
→ C2-I Notification
→ C5-W Status
→ C6-G Error/Retry

Template glue is the commercial layer. It is what becomes:

Upwork portfolio item
Fiverr package
client demo workflow
reusable deployment template

Template glue should not duplicate core component logic. It should orchestrate existing components.

5. Client Config Asset

A CLIENT_CONFIG_ASSET captures client-specific variables.

Examples:

Client profile schema
Workflow discovery questionnaire
Tool stack questionnaire
Credential checklist
Template config generator
Client config validator
AI customization questionnaire

Client config assets let one template work across many clients without rewriting the workflow.

6. Handoff-Only Core

A HANDOFF_ONLY_CORE is a built core component that prepares a clean provider handoff but does not execute the external provider API.

Examples:

C2-H Payment-on-Intake Flow
C2-L Calendar / Scheduling Automation
C2-M WhatsApp Message Automation
C2-Q Publishing Adapter Family
C4-T OCR / Document Processing Pipeline

These are valid built components. They are not broken.

They return objects like:

provider_handoff
calendar_event_handoff
ocr_handoff
platform_handoff
manual_review_handoff

Live provider execution belongs to attached adapters.

7. Scaffold-Only

A SCAFFOLD_ONLY folder exists but is not built.

Typical signs:

README present
0 workflow JSON files
0 test payload JSON files
0 output sample JSON files

Scaffold-only folders are not broken builds. They are placeholders.

They must not be sold as built components.

8. Deferred Adapter

A DEFERRED_ADAPTER is an adapter intentionally postponed until required by a template or client job.

Examples:

Google Calendar Create Event Adapter
WhatsApp Cloud API Send Adapter
Stripe Payment Link Adapter
Razorpay Payment Link Adapter
LinkedIn Publishing Adapter
OCR.space Adapter
PDF Parser Adapter

Deferred adapters may be built during template phase or client delivery.

Naming Rules Going Forward
Core components
C2-L Calendar / Scheduling Automation
C4-B AI Extraction Parser
C6-G Error Log / Retry Queue
Component adapters

Use parent core ID plus adapter suffix when tightly attached:

C2-L1 Google Calendar Create Event Adapter
C2-L2 Calendly Webhook Adapter
C2-H1 Stripe Payment Link Adapter
C2-H2 Razorpay Payment Link Adapter
Independent adapters

Use a non-core namespace:

ADP-REST Generic REST API Adapter
ADP-GMAIL-SEND Gmail Send Adapter
ADP-SLACK-SEND Slack Send Adapter
ADP-NOTION-DB Notion Database Adapter
Template glue

Use a template namespace:

TPL-P0-001 Lead Intake Qualification Follow-up
TPL-P0-002 Form CRM Alert
TPL-P0-003 CSV CRM Import
Client config assets

Use a config namespace:

CFG-001 Client Profile Schema
CFG-002 Workflow Discovery Questionnaire
CFG-003 Template Config Generator
Build Decision Rule

Before building anything, classify it:

Is it a CORE_COMPONENT?
Is it a COMPONENT_ADAPTER?
Is it an INDEPENDENT_ADAPTER?
Is it TEMPLATE_GLUE?
Is it CLIENT_CONFIG_ASSET?
Is it SCAFFOLD_ONLY / DEFERRED_ADAPTER?

If classification is unclear, do not build until the architecture is clarified.

Commercial Rule

For Upwork/Fiverr:

BUILT_CORE + BUILT_ADAPTER
= safest to sell immediately

HANDOFF_ONLY_CORE + DEFERRED_ADAPTER
= sell only with custom adapter scope

SCAFFOLD_ONLY
= do not sell as built

TEMPLATE_GLUE
= portfolio/demo/sellable workflow layer

CLIENT_CONFIG_ASSET
= makes templates reusable across clients
Current Repo Baseline

As of Audit v1.1:

Built components: 30
Scaffold-only components: 23
Broken builds: 0
Catalog mismatches for built components: 0
Invalid JSON files: 0
Duplicate active component IDs: 0
Duplicate catalog records: 0

The active built component library is clean.
