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
