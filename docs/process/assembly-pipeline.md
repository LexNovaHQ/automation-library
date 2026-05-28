# Assembly Pipeline

## Purpose

This document defines how to assemble reusable components, adapters, client configuration, and dashboard/error controls into a real client workflow or template.

This is not the build roadmap.

The roadmap is controlled by:

`docs/roadmap/universal-automation-roadmap.md`

The assembly pipeline applies after the required core components and adapters are available.

---

## Core Rule

Do not build missing core logic inside a client workflow or template.

If a required component or adapter is missing, build it as a reusable component/adapter first, then return to assembly.

Templates and client deliveries should be assemblies of reusable parts, not bespoke one-off workflows.

---

## Assembly Inputs

A real assembly should use:

- client profile
- workflow discovery response
- tool stack response
- AI profile / compatibility map
- credential readiness response
- component classification CSV
- component catalog
- roadmap
- available components/adapters
- dashboard/status/error requirements

Primary config assets:

- CFG-001 Client Profile Schema
- CFG-002 Workflow Discovery Questionnaire
- CFG-003 Tool Stack Questionnaire
- CFG-004 AI Profile Compatibility Pack
- CFG-005 Credential Collection Checklist
- CFG-006 Template Config Generator Spec

---

## Assembly Outputs

Each assembly should produce:

- selected template or custom workflow type
- required components
- required adapters
- deferred/missing adapters
- manual handoffs
- credential blockers
- dashboard/status requirements
- AI add-ons, if any
- test plan
- implementation steps
- client handoff notes

---

## Step 1 - Capture Buyer Outcome

Write the buyer outcome in plain language before technical mapping.

Examples:

- When a lead fills out my form, add them to my CRM and notify my team.
- When a client pays, start onboarding and send the welcome pack.
- When an n8n workflow fails, identify what broke and document the fix.
- When an email arrives, extract the useful details and update the CRM.

Output:

- buyer outcome list
- success definition
- failure definition

Do not start from tools. Start from outcome.

---

## Step 2 - Convert Outcome Into Workflow Shape

Map the outcome into a workflow shape.

Common shapes:

| Workflow Shape | Typical Category |
|---|---|
| Form / webhook to CRM / sheet | Cat 2 |
| Lead intake to qualification to follow-up | Cat 2 / Cat 1 |
| Outreach sequence with approval and suppression | Cat 1 |
| Payment to onboarding | Cat 3 |
| File/document to extraction | Cat 3 / Cat 4 |
| Broken workflow diagnosis and fix report | Cat 6 |
| AI draft to approval | Cat 4 / Cat 2 |
| Status/error monitoring | Cat 5 / Cat 6 |

Output:

- workflow shape
- primary category
- secondary categories
- likely dashboard add-on

---

## Step 3 - Select Components

For each workflow step, select reusable components.

Examples:

| Need | Component |
|---|---|
| Form intake | C2-E |
| Webhook trigger | C2-C |
| Validation | C2-F |
| Dedupe | C2-D |
| Conditional routing | C2-B |
| Suppression / opt-out | C2-P |
| AI classification | C4-A |
| AI extraction | C4-B |
| AI email draft | C4-E |
| Lead qualification | C4-L |
| Human approval | C2-O |
| Approval response capture | C2-O2 |
| Manual review | C5-E |
| Status tracking | C5-W |
| Error logging / retry | C6-G |

Output:

- component dependency list
- built/not-built status
- missing component list

---

## Step 4 - Select Adapters

Select adapters only after the core workflow logic is mapped.

Examples:

| Need | Adapter |
|---|---|
| Google Sheets write | C2-A1 |
| Airtable write | C2-A2 |
| HubSpot contact write | C2-A3 |
| LLM call | C2-K |
| Email notification | C2-I |
| Gmail send | ADP-GMAIL-SEND |
| Gmail inbox | ADP-GMAIL-INBOX |
| Slack send | ADP-SLACK-SEND |
| Generic REST API | ADP-REST |
| Generic webhook send | ADP-WEBHOOK-SEND |
| Google Drive file access | ADP-GDRIVE |
| PDF text extraction | ADP-PDF |

If an adapter does not exist, do not fake it.

Choose one:

- build adapter first
- use manual handoff
- use generic REST adapter
- defer live execution
- reject template fit

Output:

- built adapters
- missing/deferred adapters
- adapter gap report
- manual handoff list

---

## Step 5 - Check Credentials and Access

Before implementation, check credential readiness.

Use:

- CFG-003 Tool Stack Questionnaire
- CFG-005 Credential Collection Checklist

Check:

- API key availability
- OAuth connection availability
- workspace invite status
- admin permission needs
- test/sandbox access
- production restrictions
- logging/privacy constraints

Output:

- credential blockers
- demo readiness
- production readiness
- test-data readiness

Readiness statuses:

| Status | Meaning |
|---|---|
| Ready for production build | Components, adapters, and credentials ready |
| Ready for demo build | Can build with mock/dummy/manual data |
| Ready with handoffs | Live adapters unavailable but handoffs acceptable |
| Blocked by credentials | Required access missing |
| Blocked by adapter gap | Required adapter missing and no fallback |
| Needs more information | Discovery incomplete |

---

## Step 6 - Add Dashboard / Visibility Layer

Every serious workflow should include basic visibility.

Default visibility pack:

- C5-W Automation Status Control Table
- C5-E Manual Review Queue, if review is possible
- C6-G Error Log / Retry Queue

Category-specific dashboard add-ons:

| Category | Dashboard Add-On |
|---|---|
| Cat 1 | Sequence Performance Tracker |
| Cat 2 | Workflow Status Table |
| Cat 3 | Onboarding / Delivery Tracker |
| Cat 6 | Fix Report / Error Dashboard |
| AI add-ons | Approval queue + run log |

Output:

- status fields
- dashboard fields
- manual review fields
- error/retry fields

---

## Step 7 - Apply AI Profile and Approval Rules

If the workflow uses AI, apply CFG-004.

AI outputs must be:

- client-profile aware
- constrained by output rules
- constrained by risk boundaries
- confidence-aware
- manual-review friendly
- approval-first where external action is involved

Do not allow AI to:

- invent missing contact details
- override opt-outs
- auto-send externally without approval
- make legal/medical/financial claims unless specifically allowed and reviewed
- change payment, CRM, publishing, or email actions without permission

Output:

- AI profile mapping
- confidence thresholds
- never-infer fields
- approval triggers
- manual review triggers

---

## Step 8 - Generate Test Plan

Every assembly needs tests.

Minimum tests:

- valid input
- missing required field
- duplicate record
- low-confidence AI result
- manual review path
- tool/API failure
- notification/status logging
- error/retry logging

Template-specific tests:

| Workflow Type | Additional Tests |
|---|---|
| Outreach sequence | opt-out, reply detected, follow-up stopped |
| Payment onboarding | payment failed, payment confirmed, onboarding started |
| Document extraction | unsupported file, unreadable PDF, low-confidence extraction |
| Fixing/debugging | known auth error, mapping error, webhook failure |
| AI draft approval | approved, rejected, revised, low-confidence |

Output:

- test payload list
- expected output list
- failure cases
- acceptance criteria

---

## Step 9 - Produce Build Plan

The build plan should be implementation-ready.

Include:

- selected workflow shape/template
- components used
- adapters used
- config inputs required
- manual handoffs
- build steps
- test steps
- known blockers
- client handoff notes

Do not claim production readiness if credentials or adapters are missing.

---

## Step 10 - Handoff and Documentation

For client delivery, provide:

- what was built
- tools connected
- how to test it
- how to operate it
- where errors go
- where manual review items go
- how to retry or escalate
- what is intentionally manual/deferred
- what can be upgraded later

For fixing jobs, provide:

- what was broken
- root cause
- what was changed
- what was tested
- what to monitor
- remaining risks

---

## Assembly Discipline

The Assembly Engine / operator must not:

- invent client facts
- pretend a deferred adapter is built
- bypass approval rules
- hardcode provider logic into templates when an adapter should exist
- skip status/error logging
- skip manual review paths for low confidence
- mark a workflow production-ready without credential readiness

---

## Relationship to Roadmap

The roadmap controls build order.

This document controls assembly discipline.

Current roadmap priority:

1. Finish Cat 2 universal core/adapters
2. Build Cat 1
3. Build Cat 3
4. Finish Cat 6
5. Use Cat 5 dashboards as add-ons
6. Build controlled AI add-ons
7. Build templates later
8. Restructure repo later

So assembly should not pull the repo back into template-first mode.

