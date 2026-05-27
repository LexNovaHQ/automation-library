# Universal Automation Roadmap

## Purpose

This roadmap defines the build path from the current component library into a universal automation platform for client delivery, Upwork/Fiverr work, and reusable templates.

The repo is currently a clean component library. The next platform stage requires:

```text
template glue
live adapters
client configuration assets
monitoring/reliability controls
deployment/credential discipline
Current Baseline

Audit v1.1 confirmed:

Built components: 30
Scaffold-only placeholders: 23
Broken builds: 0
Catalog mismatches: 0
Invalid JSON files: 0
Duplicate component IDs: 0
Duplicate catalog records: 0

Current strength:

intake
→ validate
→ dedupe
→ route
→ classify/extract/generate
→ approve
→ notify
→ write
→ status/error/manual-review

Current gap:

live provider adapters
template glue workflows
client config generator
deployment/security layer
Phase 0 — Architecture Lock

Status: In progress.

Deliverables:

docs/architecture/platform-architecture-classification.md
docs/catalog/component-readiness-matrix.md
docs/roadmap/universal-automation-roadmap.md

Goal:

Create a stable classification model before restructuring folders or building new platform layers.
Phase 1 — Documentation + Audit Upgrade
Objective

Make the repo self-explanatory and audit-safe.

Tasks
1. Create architecture classification docs
2. Create component readiness matrix
3. Update component catalog with classification metadata
4. Patch audit script to read/report classification
5. Commit documentation and audit baseline
Exit Criteria
Audit can report:
- built core components
- built adapters
- handoff-only cores
- scaffold-only components
- deferred adapters
- template glue not built
- broken builds
- catalog mismatches
Phase 2 — Repo Restructure
Objective

Restructure safely around the new architecture without breaking references.

Target structure
components/
  core/
  component-adapters/

adapters/
  independent/

templates/
  p0/
  p1/
  p2/

client-config/
  schemas/
  questionnaires/
  examples/

docs/
  platform-architecture-classification.md
  component-readiness-matrix.md
  universal-automation-roadmap.md

audit/
  scripts/
  reports/
  config/
Rule

Do not move all folders in one step.

Move in controlled batches:

1. docs and matrix
2. audit script support
3. templates folder
4. adapters folder
5. one category of components at a time
Exit Criteria
Audit passes after every move.
No duplicate component IDs.
No catalog mismatches for built items.
No invalid JSON.
Phase 3 — P0 Build Set

P0 is the highest ROI / highest demand layer.

P0 Template Glue
ID    Template    Demand
P0-001    Lead Intake to Qualification to Follow-up Glue    Very High
P0-002    Form Submission to CRM Update to Team Alert Glue    Very High
P0-003    CSV/Excel Cleanup to CRM Import Glue    Very High
P0-004    Webhook to Normalize to API Sync Glue    Very High
P0-005    AI Email Draft to Approval to Send Glue    Very High
P0-006    Inbound Email to Extract to CRM Update Glue    Very High
P0 Independent Adapters
ID    Adapter    Demand
P0-007    Generic REST API Adapter    Very High
P0-008    Generic Webhook Sender    Very High
P0-009    OAuth Credential Test Adapter    Very High
P0-010    Gmail Send Adapter    Very High
P0-011    Gmail Inbox Trigger Adapter    Very High
P0-012    Slack Send Adapter    Very High
P0-013    Google Drive File Adapter    Very High
P0-014    Notion Database Adapter    Very High
P0-015    Pipedrive or GoHighLevel Adapter    Very High
P0-016    PDF Text Extraction Adapter    Very High
P0 Core/Router Builds
ID    Build    Demand
P0-017    C2-A Parent Data Sync Router    Very High
P0 Client Config Assets
ID    Asset    Demand
P0-018    Client Profile Schema    Very High
P0-019    Workflow Discovery Questionnaire    Very High
P0-020    Tool Stack Questionnaire    Very High
P0-021    AI Customization Questionnaire    Very High
P0-022    Credential Collection Checklist    Very High
P0-023    Template Config Generator    Very High
Phase 4 — P1 Build Set

P1 expands production readiness.

P1 Template Glue
Support Ticket Triage
Document Intake to OCR to Field Extraction
Daily Digest / Management Report
Error Monitoring + Retry Workflow
Payment-on-Intake Automation
Appointment Booking Follow-up
Invoice/Receipt Processing
P1 Adapters
Google Calendar Create Event Adapter
Outlook/M365 Send Adapter
Outlook Inbox Trigger Adapter
Stripe Payment Link Adapter
Razorpay Payment Link Adapter
OCR.space Adapter
DOCX Parser Adapter
ClickUp Adapter
Supabase/Postgres Adapter
Airtable Generic Adapter
n8n Workflow Control Adapter
P1 Client/Platform Assets
Client Config Validator
Client Handoff Pack Generator
Approval Audit Trail
Retry Policy Engine
Global Run Log
Dead Letter Queue
Phase 5 — P2 Build Set

P2 expands platform coverage.

P2 Adapters
WhatsApp Cloud API Send Adapter
Twilio WhatsApp Adapter
WATI Adapter
Calendly Webhook Adapter
PayPal Invoice Adapter
Webflow CMS Adapter
WordPress Publish Adapter
Microsoft Teams Send Adapter
Payment Status Webhook Adapter
Google Vision OCR Adapter
AWS Textract Adapter
P2 Workflows
Content Draft to Approval to Publish Handoff
Approval-Based WhatsApp Follow-up
No-show Reminder / Meeting Reminder
Payment Reminder Engine
Client Onboarding Intake
Phase 6 — P3 Build Set

P3 is expansion and long-tail coverage.

LinkedIn Publish Adapter
X/Twitter Publish Adapter
Instagram/Facebook Adapter
Buffer/SocialBee Adapter
Salesforce Adapter
Zoho Adapter
YouTube Adapter
Advanced RAG Layer
Full client dashboard
Advanced usage/cost monitoring
Commercial Build Rule

Do not build adapters randomly.

Build order should be:

1. P0 template glue
2. adapters required by P0 templates
3. client config assets
4. P1 reliability layer
5. P1/P2 adapters based on actual job demand
Upwork/Fiverr Selling Rule
Safe to sell immediately
BUILT_CORE + BUILT_ADAPTER workflows

Examples:

Form intake to Sheets/Airtable/HubSpot
CSV cleanup to CRM import
Webhook intake to validation/routing
Email notification workflows
Approval workflow packaging
Sell with custom integration scope
HANDOFF_ONLY_CORE + DEFERRED_ADAPTER workflows

Examples:

Live Stripe/Razorpay payment link creation
Live WhatsApp sending
Live Google Calendar event creation
Live WordPress/Webflow publishing
OCR execution
Do not sell as already built
SCAFFOLD_ONLY components
Immediate Next Step After Phase 1

After committing the three docs, update:

docs/catalog/component-catalog.md

Add classification metadata to each built component record.

Then update audit to optionally read:

docs/catalog/component-readiness-matrix.md

or a future structured version:

audit/config/component-classification.csv


