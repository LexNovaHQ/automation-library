# Lex Nova HQ — Automation Library Component Catalog

**Version:** v1.0  
**Last updated:** 2026-05-24  
**Total unique components:** 80 across 6 categories  
**Locked decisions referenced:** D65-A (initial 71-component map), D-PHASE2-004 (Offering #6 standalone), D-PHASE2-005-A (8-component addition + C2-N CSV Parser)

---

## Purpose

This catalog is the canonical index of every reusable component in the Lex Nova HQ automation library. Every template build and every paid client engagement is assembled from this catalog via the 7-step Assembly Pipeline (see `assembly-pipeline.md`).

**Discipline rule:** every reusable pattern is captured here as a component. Templates and client deliveries do NOT contain bespoke logic — they assemble pre-built components from this catalog. New patterns get added as components first, then assembled.

---

## Status Legend

- ✅ **Done** — fully built, tested, documented, ready to assemble
- 🟡 **Partial** — built for a specific context, needs generalization to be assembly-ready
- ❌ **Not done** — design locked, build pending

---

## Schema for New Entries

Every component is recorded with:
- **ID** — `Cn-Letter` format (e.g., `C2-A`)
- **Name** — terse descriptor
- **Description** — what it does, 1-2 sentences
- **Category** — 1 through 6
- **Status** — Done / Partial / Not done
- **Backing offering(s)** — which catalogue offering(s) it powers
- **Backing template(s)** — which of the 5 demand-backed templates use it
- **Dependencies** — other components it relies on
- **Borrowed by** — which other categories borrow this component
- **Last tested** — date last validated end-to-end
- **Location in repo** — path under `components/`

---

## Status Summary

| Category | Total | ✅ Done | 🟡 Partial | ❌ Not done |
|---|---|---|---|---|
| C1 Cold Outbound | 5 | 2 | 2 | 1 |
| C2 Make.com/n8n | 14 | 8 | 3 | 3 |
| C3 Onboarding | 13 | 3 | 5 | 5 |
| C4 AI Agents & RAG | 20 | 7 | 8 | 5 |
| C5 Dashboards & Portals | 22 | 8 | 8 | 6 |
| C6 Diagnostic & Repair | 6 | 0 | 0 | 6 |
| **TOTAL** | **80** | **28** | **26** | **26** |

---

# Category 1 — Cold Outbound Infrastructure

**Powers:** Catalogue Offering #1 — Cold Outbound Infrastructure ($497-$1,247)  
**Backing portfolio item:** Hunter Engine (repackaged)

| ID | Component | Description | Status |
|---|---|---|---|
| **C1-A** | Deliverability Stack Configurator | SPF/DKIM/DMARC + domain warming protocol + inbox rotation | ✅ Done |
| **C1-B** | Send Platform Deployer | Instantly / Smartlead / GMass setup as repeatable build pattern | 🟡 Partial (GMass done) |
| **C1-C** | Reply Detection & Routing Engine | Classify replies (positive/OOO/negative/unsubscribe) and route | 🟡 Partial |
| **C1-D** | AI Personalization Engine | LLM-driven dynamic copy referencing company-level intent data | ✅ Done |
| **C1-E** | Multi-Step Sequence Engine | Branching, delays, A/B logic for cold sequences | 🟡 Partial |

**Borrowed from other categories:** C2-A, C2-B, C2-C, C2-D, C4-L, C5-E (KPI dashboard for sequence metrics)

---

# Category 2 — Custom Automation Workflows (Make.com / n8n)

**Powers:** Catalogue Offering #2 — Custom Automation Workflows ($147 single workflow / $497 multi-step)  
**Backing portfolio item:** TBD (built during Phase 2)

| ID | Component | Description | Status |
|---|---|---|---|
| **C2-A** | Data Sync Pipeline | Bidirectional sync between any two apps (CRM↔Sheets, Airtable↔Notion, etc.) | ✅ Done |
| **C2-B** | Conditional Routing Engine | If/then/else logic for routing records, leads, events | ✅ Done |
| **C2-C** | Webhook Trigger System | Event in App A triggers action in App B via webhook | ✅ Done |
| **C2-D** | Deduplication & Merge Engine | Collapse duplicate records across systems | 🟡 Partial |
| **C2-E** | Form Intake Pipeline | Form submission → enrichment → CRM → notification | ✅ Done |
| **C2-F** | Conditional Form Logic | Branching forms, qualifying paths | ✅ Done |
| **C2-G** | File Upload Routing | Form upload → cloud storage → metadata to CRM | 🟡 Partial |
| **C2-H** | Payment-on-Intake Flow | Qualify → payment link → CRM update | ✅ Done |
| **C2-I** | Notification & Alert Engine | Slack/email/SMS triggers from app events with conditional logic | ✅ Done |
| **C2-J** | Digest/Summary Notification Builder | Scheduled rollups (daily/weekly) | ❌ Not done |
| **C2-K** | LLM-in-Workflow Adapter | Call Claude/GPT inside Make.com/n8n for transformation | ✅ Done |
| **C2-L** | Calendar/Scheduling Automation | Booking, availability, reminders, round-robin | ❌ Not done |
| **C2-M** | **WhatsApp Integration Adapter** *(NEW per D-PHASE2-005)* | WhatsApp Business API / Twilio / WATI: webhook receive, template send, media handling, session routing | ❌ Not done |
| **C2-N** | **Spreadsheet/CSV Parser** *(NEW per D-PHASE2-005)* | In-workflow CSV/Excel parsing for line items, bulk lists, bank statements (distinct from C5-S which is dashboard UI upload) | 🟡 Partial |

**Borrowed from other categories:** C4-A (classification), C4-B (extraction), C4-D (content gen), C4-E (multi-agent), C5-A (auth for protected webhooks)

## C2-O Build Record - Human Approval Gate

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-o-human-approval-gate`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-o-core-human-approval-gate-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-O_CORE_Human_Approval_Gate_v1`
- Creates approval request object
- Extracts configured approval context
- Generates notification payload for downstream notification adapter

**Passed tests:**
- Content approval request
- Campaign approval request
- Upstream failed
- Missing reviewer
- Approval not requested

**Implementation note:**  
C2-O v1 is built as the reusable approval-object generator for high-risk workflow actions. It creates pending approval requests and notification payloads but does not capture approval responses yet.

**Excluded by design:**  
Approval response capture belongs to C2-O2. Reviewer notification belongs to C2-I. Approval status storage belongs to C5-W / C2-A. Publishing belongs to C2-Q.

## C2-B Build Record - Conditional Routing Engine

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-b-conditional-routing-engine`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-b-core-conditional-routing-engine-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-B_CORE_Conditional_Routing_Engine_v1`
- Evaluates configurable route rules in priority order
- Returns matched route, fallback route, or config failure

**Passed tests:**
- Write success notify route
- Validation failed to error queue route
- HubSpot contact to sales follow-up route
- Fallback manual review route
- Missing route rules failure

**Implementation note:**  
C2-B is built as the reusable conditional routing layer for standardized automation outputs. It does not execute downstream workflows; it returns route metadata for parent orchestration workflows to use.

**Excluded by design:**  
Execution of downstream workflows belongs to parent orchestration workflows. Notifications belong to C2-I. Human approvals belong to C2-O. Error logging/retry belongs to C6-G.
## C2-C Build Record — Webhook Trigger System

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-c-webhook-trigger-system`  
**Last tested:** 2026-05-24  

**Workflow files:**
- `workflows/c2-c-core-event-normalizer-v1.json`
- `workflows/c2-c-webhook-receiver-wrapper-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-C_CORE_Event_Normalizer_v1`
- External webhook wrapper: `C2-C_WEBHOOK_Receiver_Wrapper_v1`

**Passed tests:**
- Lead intake success
- Payment success
- WhatsApp-style message success
- Missing event_type failure
- Missing payload failure
- Empty input failure

**Implementation note:**  
C2-C is built as a reusable webhook entry layer. The core normalizer accepts `{ data, config }`, returns a normalized success/error object, and remains reusable across templates. The wrapper handles external POST requests and converts raw webhook input into the core contract.

**Excluded by design:**  
Business-specific validation belongs to C2-F. Database writes belong to C2-A. Alerts belong to C2-I. AI classification belongs to C2-K / C4-A. Deduplication belongs to C2-D.

**High-leverage components in this category** (borrowed by 3+ other categories): C2-A, C2-B, C2-C, C2-I, C2-L

## C2-F Build Record — Payload Validation Layer

## C2-A1 Build Record - Google Sheets Write Adapter

## C2-A2 Build Record - Airtable Write Adapter
## C2-A3 Build Record - HubSpot Contact Write Adapter

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-a3-hubspot-contact-write-adapter`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-a3-core-hubspot-contact-write-adapter-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-A3_CORE_HubSpot_Contact_Write_Adapter_v1`
- Uses HTTP Request with HubSpot Service Key
- Writes through HubSpot CRM Contacts API create-contact endpoint

**Passed tests:**
- Valid HubSpot contact write
- Upstream validation failed
- Missing field map
- HubSpot Service Key read/write confirmed

**Implementation note:**  
C2-A3 is built as the third destination adapter in the C2-A Data Sync Pipeline family. It accepts validated C2-F output, maps payload fields to HubSpot contact properties, creates a contact, and returns a standard write result object.

**Excluded by design:**  
Google Sheets writes belong to C2-A1. Airtable writes belong to C2-A2. Deduplication/update belongs to C2-D. Alerts belong to C2-I. Conditional routing belongs to C2-B.
**Status:** Built v1.0  
**Location:** `components/cat-2/c2-a2-airtable-write-adapter`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-a2-core-airtable-write-adapter-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-A2_CORE_Airtable_Write_Adapter_v1`
- Uses HTTP Request with Airtable Personal Access Token
- Writes through Airtable API create-record endpoint

**Passed tests:**
- Valid Airtable write
- Upstream validation failed
- Missing base ID
- Airtable PAT write confirmed

**Implementation note:**  
C2-A2 is built as the second destination adapter in the C2-A Data Sync Pipeline family. It accepts validated C2-F output, maps payload fields to Airtable fields, creates a record, and returns a standard write result object.

**Excluded by design:**  
Google Sheets writes belong to C2-A1. HubSpot writes belong to C2-A3. Deduplication belongs to C2-D. Alerts belong to C2-I. Conditional routing belongs to C2-B.

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-a1-google-sheets-write-adapter`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-a1-core-google-sheets-write-adapter-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-A1_CORE_Google_Sheets_Write_Adapter_v1`
- Uses HTTP Request with Google Service Account API credential
- Writes through Google Sheets API append endpoint

**Passed tests:**
- Valid lead write
- Upstream validation failed
- Missing spreadsheet ID
- Google Sheets service account read/write confirmed

**Implementation note:**  
C2-A1 is built as the first destination adapter in the C2-A Data Sync Pipeline family. It accepts validated C2-F output, maps payload fields to Google Sheets columns, appends a row, and returns a standard write result object.

**Excluded by design:**  
Airtable writes belong to C2-A2. HubSpot writes belong to C2-A3. Deduplication belongs to C2-D. Alerts belong to C2-I. Conditional routing belongs to C2-B.

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-f-payload-validation-layer`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-f-core-payload-validator-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-F_CORE_Payload_Validator_v1`

**Passed tests:**
- Valid lead intake
- Valid payment success
- Missing email failure
- Invalid email failure
- Short message failure
- Empty payload failure

**Implementation note:**  
C2-F is built as a reusable validation layer for normalized C2-C events. It accepts `{ event, config }`, validates payload fields against configurable rules, and returns a standard success/failure validation object.

**Excluded by design:**  
External webhook receiving belongs to C2-C. Database writes belong to C2-A. Conditional routing belongs to C2-B. Alerts belong to C2-I. AI classification belongs to C2-K / C4-A.

## C2-I1 Build Record - Email Notification Adapter

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-i-notification-alert-engine`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-i1-core-email-notification-adapter-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-I1_CORE_Email_Notification_Adapter_v1`
- Uses Send Email node with SMTP credential
- Microsoft 365 SMTP tested using STARTTLS on port 587

**Passed tests:**
- Valid email notification
- Email received
- Upstream write failed
- Missing recipient
- Failure cases did not send email

**Implementation note:**  
C2-I1 is built as the first adapter in the C2-I Notification & Alert Engine family. It accepts standardized upstream component output, sends an email alert only when notification is requested, and returns a standard notification result object.

**Excluded by design:**  
Slack notifications belong to C2-I2. WhatsApp/SMS notifications belong to C2-I3 / C2-M. Digest summaries belong to C2-J. Approval workflows belong to C2-O. Error retry queues belong to C6-G.
---

# Category 3 — Client Onboarding System (GHL + Make.com)

**Powers:** Catalogue Offering #3 — Client Onboarding System ($497-$1,500)  
**Backing portfolio item:** GHL Onboarding Build + Client Intake Portal (anonymized Lex Nova client portal)

| ID | Component | Description | Status |
|---|---|---|---|
| **C3-A** | GHL Pipeline & Workflow Configurator | Custom GHL stages, fields, opportunity routing | ❌ Not done (GHL ramp pending) |
| **C3-B** | GHL Snapshot Builder | Reusable cloneable template across sub-accounts | ❌ Not done |
| **C3-C** | GHL ↔ Make.com Bridge | Connect GHL native to external Make.com automations | 🟡 Partial |
| **C3-D** | E-Signature Integration | DocuSign / HelloSign / native GHL signing embedded in flow | ❌ Not done |
| **C3-E** | Document Generation Pipeline | Data → template → PDF/Doc → delivery (engagement letters, proposals) | ✅ Done |
| **C3-F** | Document Delivery & Tracking | Sent → opened → signed → received status sync | ✅ Done |
| **C3-G** | Subscription Billing Engine | Recurring payments, plan tiers, dunning logic | 🟡 Partial |
| **C3-H** | Payment-to-Onboarding Bridge | Payment confirmed → trigger onboarding + portal creation | ✅ Done |
| **C3-I** | Welcome Sequence Engine (multi-path) | Different sequences for different client tiers/services | 🟡 Partial |
| **C3-J** | SMS Reminder Cascade | Twilio-based SMS layer alongside email | ❌ Not done |
| **C3-K** | Onboarding Funnel Dashboard | Drop-off by stage, time-to-onboard, conversion metrics | 🟡 Partial |
| **C3-L** | Client Health Scoring | Active vs. stalled vs. completed onboarding classification | ❌ Not done |
| **C3-M** | Proposal/SOW Auto-Generator | Qualified lead → personalized proposal/SOW | 🟡 Partial |

**Borrowed from other categories:** C1-D, C2-E, C2-F, C2-G, C2-H, C2-I, C2-L, C4-A, C5-B, C5-C, C5-D

**Note:** Highest cross-category overlap. ~60% of Category 3 is recombination of components from Categories 1, 2, 4, 5.

---

# Category 4 — AI Agents & RAG Systems

**Powers:** Catalogue Offering #4 — AI Agents & RAG Systems ($497-$2,500)  
**Backing portfolio item:** Copywriter (Architect → Claude) + AI Contract Q&A System + Hunter Engine + AI Lead Qualification Agent

| ID | Component | Description | Status |
|---|---|---|---|
| **C4-A** | AI Classification Agent | Input → category → routing | ✅ Done |
| **C4-B** | AI Extraction Agent (text-based) | Unstructured text input → structured output (JSON/fields). Excludes image OCR (see C4-T) | ✅ Done |
| **C4-C** | AI Summarization Agent | Long text → controllable-length summary | ✅ Done |
| **C4-D** | AI Content Generation Pipeline | Template + variables + LLM → output at scale | ✅ Done |
| **C4-E** | Multi-Agent Pipeline / Orchestration | Agent 1 → Agent 2 → Agent 3 with deterministic translation between | ✅ Done |
| **C4-F** | Document Ingestion Pipeline (RAG) | PDFs/docs → chunking → embedding → vector store | 🟡 Partial |
| **C4-G** | Semantic Retrieval Engine | Query → top-K + reranking + filtering | 🟡 Partial |
| **C4-H** | Q&A Interface with Source Citations | Query → retrieval → LLM answer with citations | 🟡 Partial |
| **C4-I** | Knowledge Base Auto-Updater | Google Drive/Notion/Confluence → vector store sync | 🟡 Partial |
| **C4-J** | Domain-Tuned RAG | Legal/medical/accounting domain prompts + retrieval filters | ✅ Done |
| **C4-K** | Email-Triage Agent | Incoming emails → categorize → route → suggest response | 🟡 Partial |
| **C4-L** | Lead Qualification Agent | Inbound form/lead → score → enrich → categorize | ✅ Done |
| **C4-M** | Agent Memory Layer | Persistent conversation history, context recall | 🟡 Partial |
| **C4-N** | Tool-Use Agent | LLM calls APIs/databases, takes real-world actions | 🟡 Partial |
| **C4-O** | Human-in-the-Loop Checkpoint | Agent proposes → human approves → action executes | ❌ Not done |
| **C4-P** | Internal AI Copilot / Knowledge Assistant | Team-facing AI trained on company SOPs | 🟡 Partial |
| **C4-Q** | Prompt Template Library | Curated prompts for specific tasks, team-facing | ❌ Not done |
| **C4-R** | AI Output QA / Filtering Layer | Quality check → human review if low confidence | ❌ Not done |
| **C4-S** | AI Content Variation A/B Testing | Multiple outputs per input → compare | ❌ Not done |
| **C4-T** | **Document OCR Pipeline (image-based)** *(NEW per D-PHASE2-005)* | Image upload → OCR (Tesseract / Google Document AI / AWS Textract) → text → handoff to C4-B for structured extraction | 🟡 Partial |

**Borrowed from other categories:** C2-A (sync), C2-C (webhook), C2-I (notifications), C5-E (KPI dashboard)

**Deferred (out of catalogue scope):** ~~C4-U Inbound Voice Agent~~, ~~C4-V Outbound Voice Agent~~, ~~C4-W Voice Transcript-to-Action~~ (Voice AI per D63 — revisit Month 3+)

---

# Category 5 — Custom Internal Dashboards & Client Portals

**Powers:** Catalogue Offering #5 — Custom Dashboards & Client Portals ($797-$3,000)  
**Backing portfolio item:** Lex Nova Admin Panel (anonymized as Practice Management Dashboard) + Client Intake Portal  
**Forward-looking seed:** Custom CRM build alternative (Month 4+ play per D60)

| ID | Component | Description | Status |
|---|---|---|---|
| **C5-A** | Authentication & Session Engine | Email/password, magic-link, OAuth, session management, password reset | ✅ Done (magic-link) / 🟡 (full session UX) |
| **C5-B** | Magic-Link Portal Engine | Passwordless client portal access | ✅ Done |
| **C5-C** | Client Document Vault | Per-client folder, version history, access controls | ✅ Done |
| **C5-D** | Project Status Visibility | Stage tracker, timeline, deliverable preview | ✅ Done |
| **C5-E** | KPI Dashboard | Configurable metrics, time-window selectors, drill-down | ✅ Done |
| **C5-F** | Multi-Tenant Admin Panel | Superadmin view across all clients, RBAC-ready | ✅ Done |
| **C5-G** | CRUD Table Builder | Add/edit/delete records with validation | ✅ Done |
| **C5-H** | Filterable Data Grid | Search, sort, filter, paginate across thousands of rows | ✅ Done |
| **C5-I** | Pipeline/Funnel View | Drag-and-drop or list-based stage progression | 🟡 Partial |
| **C5-J** | Real-Time Notification Center | In-app notifications with read/unread, action links | 🟡 Partial |
| **C5-K** | Calendar Embed | Native calendar view inside dashboard | ❌ Not done |
| **C5-L** | File Upload + Preview | Drag-drop upload, in-browser preview for PDFs/images | 🟡 Partial |
| **C5-M** | Form Builder (Admin-Side) | Admin builds intake forms; clients fill via portal | 🟡 Partial |
| **C5-N** | Audit Log / Activity Stream | Who did what, when, with diffs | 🟡 Partial |
| **C5-O** | Settings / Configuration Panel | Per-tenant config, feature flags, branding | ✅ Done |
| **C5-P** | Stripe/Razorpay Payment Embed | In-dashboard payment processing | 🟡 Partial |
| **C5-Q** | Webhook Endpoint Builder | Client configures their own webhooks via UI | ❌ Not done |
| **C5-R** | Task/Checklist Engine | Assign tasks to user, due dates, status | ❌ Not done |
| **C5-S** | Data Import Flow (UI-based) | CSV/Excel upload via dashboard → parse → map → import | 🟡 Partial |
| **C5-T** | Data Export Flow | Generate CSV/Excel/PDF from dashboard data | 🟡 Partial |
| **C5-U** | API Endpoint Layer | REST endpoints for client's external systems | ✅ Done |
| **C5-V** | Mobile-Responsive UI Pattern | Works on phone/tablet without native app | ✅ Done |

**Borrowed from other categories:** C2-A, C2-C, C2-I, C2-L, C4-D

**Out of scope:** Native mobile app (iOS/Android), Offline-first / PWA — outside solo stack

---

# Category 6 — Diagnostic & Repair (NEW per D-PHASE2-004)

**Powers:** Catalogue Offering #6 — Fix Broken Make.com / Zapier / n8n Automations ($97 diagnostic + $150-800 repair)  
**Backing portfolio item:** TBD — built after first 2-3 diagnostic engagements

| ID | Component | Description | Status |
|---|---|---|---|
| **C6-A** | Workflow Diagnostic Checklist (SOP) | 30-50 point checklist covering common failure modes: webhook timeouts, rate limits, schema mismatches, OAuth expiry, malformed payloads, missing error handlers, retry storms | ❌ Not done |
| **C6-B** | Error Pattern Library / Failure Mode Taxonomy | Catalog of common Make.com/Zapier/n8n failure patterns with root causes and fixes. Lives as Markdown reference in repo. Grows with every engagement. | ❌ Not done |
| **C6-C** | Webhook Health Tester | n8n workflow that pings client endpoints, captures response times, status codes, timeouts. Output: structured health report. | ❌ Not done |
| **C6-D** | Schema/Payload Validator | Validates JSON payloads flowing through client's broken workflows against expected schemas. Catches malformed data — the #1 silent killer. | ❌ Not done |
| **C6-E** | Diagnostic Report Template | Standardized output format: 1-page summary + detailed findings + recommended repair scope + estimated repair cost. Anchors the upsell from $97 → $200-800. | ❌ Not done |
| **C6-F** | Make-to-n8n Migration Toolkit | Common-case migration patterns (Make.com scenarios → equivalent n8n workflows). Upsell engine: Offering #6 → Offering #2. | ❌ Not done |

**Borrowed from other categories:** C2-C (webhook), C2-I (notification for client comms), C4-A (classification of error patterns), C5-N (audit log diffing)

---

# Cross-Category Borrowing Map

**The high-leverage components** (borrowed by 3+ other categories — these are your highest-priority builds):

| Component | Borrowed by |
|---|---|
| C2-A Data Sync Pipeline | C1, C3, C5 |
| C2-B Conditional Routing Engine | C1, C3, C4 |
| C2-C Webhook Trigger System | C1, C3, C4, C5, C6 |
| C2-I Notification & Alert Engine | C1, C3, C4, C5, C6 |
| C2-L Calendar/Scheduling Automation | C3, C5 |
| C4-D AI Content Generation Pipeline | C1, C2, C3, C5 |
| C4-A AI Classification Agent | C2, C3, C6 |
| C4-B AI Extraction Agent | C2, C3, C5 |
| C5-E KPI Dashboard | C1, C4 |

**Strategic note:** Strengthen these first. Every hour invested in a high-leverage component returns across multiple offerings.

---

# Backing the 5 Demand-Backed Templates

Maps each Phase 2 template to its required components.

## Template #1 — Lead Capture → CRM → AI Follow-up

**Components used:** C2-C (webhook for form), C2-E (form intake), C2-K (LLM in workflow), C2-B (conditional routing), C2-A (CRM write), C2-I (notification), C4-L (lead qualification), C2-M (WhatsApp if channel selected), C1-E (sequence engine for follow-up)

## Template #2 — Client Onboarding System

**Components used:** C2-E (form intake), C2-G (file upload), C2-H (payment-on-intake), C3-E (doc generation), C3-F (delivery tracking), C3-H (payment-to-onboarding), C3-I (welcome sequence), C5-B (magic-link portal), C5-C (document vault), C3-D (e-signature if needed), C2-M (WhatsApp if channel selected)

## Template #3 — AI Document Processing

**Components used:** C2-G (file upload), C4-T (OCR for scanned), C4-B (text extraction), C4-A (classification), C2-B (conditional routing), C2-I (notification), C5-L (file preview if portal-delivered), C2-N (if processing CSV/Excel)

## Template #4 — Sales Pipeline Automation

**Components used:** C2-A (CRM sync), C2-B (conditional routing for stage transitions), C5-I (pipeline view), C2-I (notification for stage changes), C2-L (calendar for follow-up booking), C5-E (KPI dashboard for pipeline metrics), C3-L (health scoring adapted for deal aging)

## Template #5 — Invoice & Billing Automation

**Components used:** C2-C (event webhook), C3-E (invoice doc generation), C3-G (subscription billing engine if recurring), C2-I (reminder notifications), C2-A (reconciliation sync), C2-N (CSV parser for bank statements / line items), C5-T (export reports)

---

# Component Build Priority for Phase 2

The 26 "Not done" components ranked by leverage. Priority order = build sequence when gap-closing in Phase 2.

**Tier 1 — Build first (unlock multiple templates):**
1. C2-L Calendar/Scheduling Automation — used in Templates #2, #4; cross-borrowed by C3, C5
2. C2-M WhatsApp Integration Adapter — used in Templates #1, #2, #3; high market demand
3. C2-J Digest/Summary Notification Builder — cross-cutting

**Tier 2 — Build for specific template (Cat 2 sprint Days 2-10):**
4. C2-N Spreadsheet/CSV Parser (currently 🟡, finish) — Templates #3, #5
5. C4-O Human-in-the-Loop Checkpoint — Template #3 (document approval), Offering #4
6. C4-Q Prompt Template Library — Offering #4 polish
7. C4-R AI Output QA / Filtering Layer — Template #3 quality gate
8. C4-S AI Content Variation A/B Testing — Offering #1 polish

**Tier 3 — Build for Offering #6 (after first 2-3 paid diagnostics):**
9. C6-A through C6-F (all six) — needed in priority order: C6-A → C6-E → C6-B → C6-C → C6-D → C6-F

**Tier 4 — Build for Cat 3 (GHL ramp, on schedule):**
10. C3-A, C3-B, C3-D, C3-J, C3-L

**Tier 5 — Build for Cat 5 (Dashboards demand-led):**
11. C5-K, C5-Q, C5-R — build when a paid Offering #5 job demands them

---

# Out-of-Scope (Declared Not Deliverable)

| Item | Why |
|---|---|
| Native Mobile App (iOS/Android) | Outside solo stack |
| Offline-first / PWA | Not in current stack |
| Voice AI (C4-U, C4-V, C4-W) | Deferred per D63 — revisit Month 3+ |
| Enterprise multi-agent orchestration (12+ agents, cross-agent memory, master controller) | Out of target buyer scope per Phase 2 D-discussion. Watch list, not target. |

---

# Appendix A — Demo Toolkit Bindings (per Category)

**Purpose:** Each category's components bind to a specific demo toolkit. Portfolio templates inherit these bindings — they do NOT pick their own tools. This enforces the architectural rule that **tools bind to components, not to templates.** When a real paying client engages, components re-bind to the client's tools (their CRM, their form provider, their email service). Component logic stays identical — only the connection/auth config changes.

**Why this matters:** Without category-level toolkit locks, each template would have bespoke tool integrations, violating the "components are atomic" principle. Demo consistency = portfolio coherence + faster assembly + cleaner generalization to client work.

---

## A.1 — Category 2 Demo Toolkit v1.0 (locked per D-DAY2-003)

All Category 2 portfolio templates (Templates #1-#5) assemble against this binding table.

| Function | Tool | Used By Components | Notes |
|---|---|---|---|
| Workflow engine | n8n self-hosted (Docker) | All | Per Day 1 infrastructure lock |
| AI/LLM | Groq + Llama 3.3 70B (free tier) | C2-K, C4-* | Per D-DAY2-002. Backup: Gemini 2.5 Flash-Lite. |
| Form intake | Tally (free) | C2-E, C2-F, C2-G | Modern UX, generous free tier, recognized on Upwork |
| CRM destination | HubSpot free tier | C2-A, C2-B, C2-D (when CRM-bound) | Most-requested CRM signal on Upwork |
| Flexible database | Airtable free tier | C2-A, C2-D, C2-N (table-shaped data) | "Database for non-techies" |
| File storage | Google Drive | C2-G | Universal file destination |
| Spreadsheet destination | Google Sheets | C2-A, C2-N (tabular logs/exports) | Default for tabular automation |
| Email send | Gmail (App Password) | C2-I, C2-J | Sufficient for demo volume |
| Team notification | Slack free workspace | C2-I, C2-J | Default B2B alert tool |
| Customer messaging | WhatsApp Cloud API (Meta direct, free tier) | C2-M (when built) | Free Meta tier, no Twilio markup |
| Payment | Stripe test mode | C2-H | Test transactions are free |
| Calendar/scheduling | Calendly free tier | C2-L (when built) | Most recognized. Cal.com = self-host upgrade path. |
| Webhook testing | webhook.site + n8n native | C2-C | Zero signup |

---

### A.1.1 — Role separation within the toolkit

To prevent the wrong tool being used for the wrong job, the following destination roles are fixed:

| Use case | Destination |
|---|---|
| CRM-shaped data (leads, contacts, deals, opportunities) | **HubSpot** |
| Arbitrary records / project tracking / inventory / content | **Airtable** |
| Simple tabular logs, exports, line items, financial records | **Google Sheets** |
| File payloads (PDFs, images, attachments) | **Google Drive** |
| Document generation outputs (PDFs/Docs from data) | **Google Drive** |

C2-A (Data Sync Pipeline) supports all three (HubSpot, Airtable, Sheets) as destinations from Day 1 — implemented via n8n's native nodes for each.

---

### A.1.2 — Client-engagement re-binding

When a paying client engages, the Cat 2 components re-bind to their tools. The toolkit is the **demo default**, not the only supported configuration. Examples:

| Demo Default | Common Client Substitutes |
|---|---|
| Tally | Typeform, Jotform, Webflow forms, native HTML forms, Google Forms |
| HubSpot | Pipedrive, Salesforce, Zoho CRM, GoHighLevel, Close.com, custom DB |
| Airtable | Notion databases, monday.com, Smartsheet, Coda |
| Gmail | Mailgun, SendGrid, Postmark, Resend, Microsoft 365 SMTP |
| Slack | Microsoft Teams, Discord, Telegram, email-only |
| Stripe | Razorpay (India), PayPal, LemonSqueezy, Paddle, Square |
| Calendly | Cal.com, Acuity, SavvyCal, native CRM scheduling |
| Groq + Llama 3.3 70B | Claude (any version), GPT-4/4o/5, Gemini 2.5 Flash/Pro, self-hosted Ollama |

The C2-K LLM-in-Workflow Adapter is explicitly model-agnostic — uses n8n's OpenAI node with swappable base URL. Same logic, any provider.

---

### A.1.3 — Cat 2 demo account prerequisites

The accounts created ONCE for the entire Cat 2 sprint (no credit cards required):

1. Groq API key — console.groq.com
2. Tally account — tally.so
3. HubSpot free CRM — hubspot.com (real workspace, demo company)
4. Airtable workspace — airtable.com
5. Slack demo workspace — slack.com/create
6. Gmail App Password — myaccount.google.com → Security (2FA required first)
7. Stripe test mode account — dashboard.stripe.com/register (switch Live → Test in dashboard)
8. Calendly free account — calendly.com/signup (defer until Template #4)

Credentials stored locally in `D:\Code\lexnova-secrets.txt` — NEVER committed to GitHub.

---

## A.2 — Category 1 Demo Toolkit (TBD)

Will be locked when Category 1 sprint begins. Expected anchor tools: Apollo (free), Instantly OR Smartlead (trial), GMass (already configured), domain warming via existing setup.

## A.3 — Category 3 Demo Toolkit (TBD)

Will be locked when Category 3 sprint begins. Anchor tools likely: GHL trial OR HubSpot (depending on offering positioning), Tally, Stripe, e-signature (DocuSign free OR HelloSign trial).

## A.4 — Category 4 Demo Toolkit (TBD)

Will be locked when Category 4 sprint begins. Anchor tools likely: Groq + Llama 3.3 70B (continued), vector DB (Pinecone free OR Supabase pgvector), document sources (Google Drive, Notion).

## A.5 — Category 5 Demo Toolkit (TBD)

Will be locked when Category 5 sprint begins. Anchor tools likely: Firebase + Cloudflare Pages (existing Lex Nova stack), magic-link auth, custom HTML/CSS.

## A.6 — Category 6 Demo Toolkit (TBD)

Will be locked when Category 6 sprint begins. Mostly soft tooling (checklists, SOPs, report templates) + the underlying tools clients are using (Make.com, Zapier, n8n logs).

---

# Version History

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-05-24 | Initial catalog. 80 components across 6 categories. Locks: D65-A, D-PHASE2-004, D-PHASE2-005-A. |
| v1.1 | 2026-05-24 | Added Appendix A — Demo Toolkit Bindings. Cat 2 toolkit locked per D-DAY2-003. Cat 1, 3, 4, 5, 6 toolkits marked TBD pending their sprints. |

---

**This document is the canonical source of truth for the component library. Every change to component definitions, status, or scope is recorded here first, before code changes.**

## C6-G Build Record - Error Log + Retry Queue

**Status:** Built v1.0  
**Location:** `components/cat-6/c6-g-error-log-retry-queue`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c6-g-core-error-log-retry-queue-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C6-G_CORE_Error_Log_Retry_Queue_v1`
- Creates standardized error log objects
- Classifies severity using configurable severity rules
- Creates retry/manual-resolution status fields
- Generates owner notification payload

**Passed tests:**
- Validation failed log
- Write failed log
- Notification failed log
- Success input invalid
- Missing error object invalid

**Implementation note:**  
C6-G v1 is built as the reusable error-log and retry-queue object generator. It does not store the record or execute retries. Storage belongs to C5-W / C2-A. Notification belongs to C2-I. Retry execution belongs to C6-G2.

**Excluded by design:**  
Database/status-table write belongs to C5-W / C2-A. Error owner notification belongs to C2-I. Actual retry execution belongs to C6-G2. Diagnostic auto-fix belongs to later C6 components.

## C5-W Build Record - Automation Status Control Table

**Status:** Built v1.0  
**Location:** `components/cat-5/c5-w-automation-status-control-table`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c5-w-core-automation-status-control-table-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C5-W_CORE_Automation_Status_Control_Table_v1`
- Creates standardized automation status/control records
- Classifies workflow status and stage from upstream component outputs
- Extracts destination, approval, error, retry, routing, and notification fields
- Prepares a control record for Airtable/Sheets/Supabase/dashboard storage

**Passed tests:**
- Completed lead status
- Pending approval status
- Error logged status
- Manual review status
- Missing input

**Implementation note:**  
C5-W v1 is built as the reusable automation control-record generator. It does not store the record itself. Storage belongs to C2-A adapters or later dashboard/database components.

**Excluded by design:**  
Database writes belong to C2-A1/C2-A2 or later storage adapters. Error log creation belongs to C6-G. Human approval creation belongs to C2-O. Notifications belong to C2-I. KPI monitoring belongs to C5-X.

## C2-K Build Record - Groq/OpenAI-Compatible LLM Adapter

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-k-llm-in-workflow-adapter`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-k-core-groq-openai-compatible-llm-adapter-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-K_CORE_Groq_OpenAI_Compatible_LLM_Adapter_v1`
- Uses Groq through OpenAI-compatible chat completions endpoint
- Demo model: `llama-3.3-70b-versatile`
- Prepares LLM request from standardized upstream input
- Parses JSON response content into `ai_result.parsed_json`
- Preserves raw LLM output in `ai_result.content`
- Blocks failed upstream inputs and non-AI-requested inputs

**Passed tests:**
- Lead summary
- Content classification
- Upstream failed
- Missing model
- AI not requested

**Implementation note:**  
C2-K is built as a safe LLM-in-workflow adapter, not an autonomous AI agent. It calls a configured LLM provider, returns a standardized AI result object, and leaves routing, approval, writing, notifications, and execution to other components.

**Excluded by design:**  
AI draft approval pipeline belongs to C4-M. Human approval belongs to C2-O. Routing belongs to C2-B. Writing belongs to C2-A. Notifications belong to C2-I. Status tracking belongs to C5-W. Error logging belongs to C6-G. Autonomous agent execution belongs to a later C4 agent component.

## C4-M Build Record - AI Draft Approval Pipeline

**Status:** Built v1.0  
**Location:** `components/cat-4/c4-m-ai-draft-approval-pipeline`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c4-m-core-ai-draft-approval-pipeline-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C4-M_CORE_AI_Draft_Approval_Pipeline_v1`
- Converts completed C2-K AI output into a standardized draft package
- Creates draft metadata, status, owner, priority, and AI metadata
- Creates C2-O-compatible approval handoff payload
- Does not call the LLM directly and does not publish content

**Passed tests:**
- Blog draft approval
- Email draft approval
- AI failed
- Missing AI result
- Missing reviewer

**Implementation note:**  
C4-M v1 is built as the higher-level AI draft workflow layer above C2-K. It packages AI output into a review-ready draft and prepares the handoff to C2-O for human approval.

**Excluded by design:**  
Direct LLM calls belong to C2-K. Human approval creation belongs to C2-O. Approval response capture belongs to C2-O2. Reviewer notification belongs to C2-I. Draft/database storage belongs to C2-A / C5-W. Publishing belongs to C2-Q.

## C2-D Build Record - Deduplication & Merge Engine

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-d-deduplication-merge-engine`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-d-core-deduplication-merge-engine-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-D_CORE_Deduplication_Merge_Engine_v1`
- Evaluates incoming validated records against provided candidate records
- Scores exact email, phone, domain, company, and name matches
- Returns dedupe decision: `new_record`, `possible_duplicate`, or `duplicate`
- Returns downstream recommended action: `create_record`, `manual_review`, or `update_existing_record`

**Passed tests:**
- New record
- Exact email duplicate
- Possible duplicate
- Upstream failed
- Dedupe not requested

**Implementation note:**  
C2-D v1 is built as the reusable dedupe decision layer. It does not perform live lookup and does not mutate records. Candidate lookup and actual write/update/merge actions belong to downstream or platform-specific components.

**Excluded by design:**  
Live Airtable/Sheets/HubSpot lookup belongs to C2-D2 or platform lookup adapters. Record creation/update/merge belongs to C2-A adapters. Manual review belongs to C5-E / C5-W. Error logging belongs to C6-G.

## C2-P Build Record - Suppression / Opt-Out Guard

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-p-suppression-opt-out-guard`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-p-core-suppression-opt-out-guard-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-P_CORE_Suppression_Opt_Out_Guard_v1`
- Evaluates incoming records against suppression records, blocked emails, blocked phones, blocked domains, and consent rules
- Returns suppression decision: `allowed`, `blocked`, or `manual_review`
- Returns downstream recommended action: `write_record`, `do_not_contact`, or `manual_review`

**Passed tests:**
- Allowed contact
- Blocked suppression email
- Blocked domain
- Manual review unknown consent
- Upstream failed
- Suppression not requested

**Implementation note:**  
C2-P v1 is built as the reusable suppression/opt-out decision layer. It does not perform live lookup and does not mutate records. Suppression lookup, unsubscribe writeback, and platform-specific consent sync belong to downstream or platform-specific components.

**Excluded by design:**  
Live suppression lookup belongs to C2-P2 or platform lookup adapters. Record writeback belongs to C2-A adapters. Notifications belong to C2-I / C2-M. Manual review belongs to C5-E / C5-W. Error logging belongs to C6-G.

## C2-J Build Record - Digest / Summary Notification Builder

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-j-digest-summary-notification-builder`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-j-core-digest-summary-notification-builder-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-J_CORE_Digest_Summary_Notification_Builder_v1`
- Builds daily/error/approval/custom digest objects from a records array
- Counts records by status, event type, owner, priority, and record type
- Extracts attention items requiring approval, retry, error handling, or manual review
- Generates email-ready notification payload for C2-I

**Passed tests:**
- Daily digest
- Error digest
- Approval digest
- Upstream failed
- Digest not requested
- Missing records

**Implementation note:**  
C2-J v1 is built as the reusable digest/summary builder. It does not fetch records or send notifications. Record fetching belongs to storage/query components. Notification sending belongs to C2-I.

**Excluded by design:**  
Email sending belongs to C2-I. Status record creation belongs to C5-W. Error log creation belongs to C6-G. Approval response handling belongs to C2-O2. Dashboard rendering belongs to C5-A / C5-E.

## C5-E Build Record - Manual Review Queue

**Status:** Built v1.0  
**Location:** `components/cat-5/c5-e-manual-review-queue`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c5-e-core-manual-review-queue-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C5-E_CORE_Manual_Review_Queue_v1`
- Creates standardized manual review queue items from workflow outputs
- Supports review items for dedupe, suppression/consent, approval, routing fallback, and error/retry workflows
- Creates reviewer notification payload for C2-I
- Does not store queue item directly

**Passed tests:**
- Possible duplicate review
- Consent review
- Approval review
- Error retry review
- Upstream failed
- Review not requested

**Implementation note:**  
C5-E v1 is built as the reusable manual review queue object generator. It does not write queue items or capture decisions. Storage belongs to C2-A/C5-W. Review decision capture belongs to C2-O2 or a future C5-E2.

**Excluded by design:**  
Database/storage writes belong to C2-A/C5-W. Notification sending belongs to C2-I. Review/approval decision capture belongs to C2-O2. Retry execution belongs to C6-G2. Dashboard rendering belongs to C5-A/C5-B.

## C5-E Build Record - Manual Review Queue

**Status:** Built v1.0  
**Location:** `components/cat-5/c5-e-manual-review-queue`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c5-e-core-manual-review-queue-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C5-E_CORE_Manual_Review_Queue_v1`
- Creates standardized manual review queue items from workflow outputs
- Supports review items for dedupe, suppression/consent, approval, routing fallback, and error/retry workflows
- Creates reviewer notification payload for C2-I
- Does not store queue item directly

**Passed tests:**
- Possible duplicate review
- Consent review
- Approval review
- Error retry review
- Upstream failed
- Review not requested

**Implementation note:**  
C5-E v1 is built as the reusable manual review queue object generator. It does not write queue items or capture decisions. Storage belongs to C2-A/C5-W. Review decision capture belongs to C2-O2 or a future C5-E2.

**Excluded by design:**  
Database/storage writes belong to C2-A/C5-W. Notification sending belongs to C2-I. Review/approval decision capture belongs to C2-O2. Retry execution belongs to C6-G2. Dashboard rendering belongs to C5-A/C5-B.

## C5-E Build Record - Manual Review Queue

**Status:** Built v1.0  
**Location:** `components/cat-5/c5-e-manual-review-queue`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c5-e-core-manual-review-queue-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C5-E_CORE_Manual_Review_Queue_v1`
- Creates standardized manual review queue items from workflow outputs
- Supports review items for dedupe, suppression/consent, approval, routing fallback, and error/retry workflows
- Creates reviewer notification payload for C2-I
- Does not store queue item directly

**Passed tests:**
- Possible duplicate review
- Consent review
- Approval review
- Error retry review
- Upstream failed
- Review not requested

**Implementation note:**  
C5-E v1 is built as the reusable manual review queue object generator. It does not write queue items or capture decisions. Storage belongs to C2-A/C5-W. Review decision capture belongs to C2-O2 or a future C5-E2.

**Excluded by design:**  
Database/storage writes belong to C2-A/C5-W. Notification sending belongs to C2-I. Review/approval decision capture belongs to C2-O2. Retry execution belongs to C6-G2. Dashboard rendering belongs to C5-A/C5-B.

## C2-O2 Build Record - Approval Response Capture

**Status:** Built v1.0  
**Location:** `components/cat-2/c2-o2-approval-response-capture`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c2-o2-core-approval-response-capture-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C2-O2_CORE_Approval_Response_Capture_v1`
- Captures approval reviewer decisions from approval response payloads
- Validates approval object, response object, approval ID, decision, and reviewer email
- Enforces decision against allowed approval actions
- Maps decision to approval status and decision action
- Returns standardized approval response object

**Passed tests:**
- Approve response
- Reject response
- Revise response
- Upstream failed
- Missing response
- Invalid decision
- Approval response not requested

**Implementation note:**  
C2-O2 v1 is built as the reusable approval response capture layer. It does not update storage, execute publishing/sending, or revise AI content. Those actions belong to downstream components.

**Excluded by design:**  
Approval request creation belongs to C2-O. Review queue creation belongs to C5-E. Notifications belong to C2-I. Status/storage updates belong to C2-A/C5-W. Publishing/sending belongs to C2-Q/C2-I. Error logging belongs to C6-G.

## C4-E Build Record - AI Email Draft Generator

**Status:** Built v1.0  
**Location:** `components/cat-4/c4-e-ai-email-draft-generator`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c4-e-core-ai-email-draft-generator-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C4-E_CORE_AI_Email_Draft_Generator_v1`
- Generates client-configured email draft objects from lead/source context
- Uses `client_ai_profile`, email rules, voice rules, offer rules, and risk boundaries
- Calls Groq through OpenAI-compatible chat completions
- Returns structured `email_draft`
- Creates C4-M-compatible handoff for approval packaging
- Does not send emails or act autonomously

**Passed tests:**
- First response email
- Follow-up email
- Upstream failed
- Email draft not requested
- Missing client profile
- Missing LLM config

**Implementation note:**  
C4-E v1 is built as a client-configurable AI email draft processor, not a generic AI writer and not an autonomous agent. It produces draft objects only. Sending, approval, status tracking, and storage belong to downstream components.

**Excluded by design:**  
Generic LLM call belongs to C2-K. Draft approval packaging belongs to C4-M. Human approval belongs to C2-O. Approval response capture belongs to C2-O2. Email sending belongs to C2-I/future sender adapters. Status tracking belongs to C5-W. Error logging belongs to C6-G.

## C4-L Build Record - Lead Qualification Pipeline

**Status:** Built v1.0  
**Location:** `components/cat-4/c4-l-lead-qualification-pipeline`  
**Last tested:** 2026-05-25  

**Workflow files:**
- `workflows/c4-l-core-lead-qualification-pipeline-v1.json`

**Test payloads:** Present  
**Output samples:** Present  

**Implemented architecture:**
- Core reusable workflow: `C4-L_CORE_Lead_Qualification_Pipeline_v1`
- Qualifies leads using client profile, audience profile, qualification rules, risk rules, and lead/source payload
- Calls Groq through OpenAI-compatible chat completions
- Returns structured `lead_qualification`
- Creates C4-E handoff for qualified leads
- Creates C5-E handoff for manual review leads
- Does not email leads, update CRM records, or act autonomously

**Passed tests:**
- Qualified lead
- Possible fit lead
- Unqualified lead
- Manual review duplicate
- Upstream failed
- Qualification not requested
- Missing client profile

**Implementation note:**  
C4-L v1 is built as a client-configurable lead qualification processor, not an autonomous sales agent. It produces structured qualification decisions and handoff objects only. Email drafting, approval, writing, notification, and status tracking belong to downstream components.

**Excluded by design:**  
Generic LLM call belongs to C2-K. Email draft generation belongs to C4-E. Manual review queue creation belongs to C5-E. CRM/database writes belong to C2-A. Email sending belongs to C2-I. Status tracking belongs to C5-W. Error logging belongs to C6-G.
