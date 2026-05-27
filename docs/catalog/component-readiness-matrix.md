# Component Readiness Matrix

## Purpose

This matrix maps the current built repository into the new architecture classification.

It separates:

```text
CORE_COMPONENT
COMPONENT_ADAPTER
HANDOFF_ONLY_CORE
SCAFFOLD_ONLY
DEFERRED_ADAPTER
TEMPLATE_GLUE
CLIENT_CONFIG_ASSET

This file is the working roadmap for deciding what can be sold now, what needs an adapter, and what belongs in template phase.

Current Built Component Baseline

Audit v1.1 confirmed:

Metric    Count
Built components    30
Scaffold-only placeholders    23
Broken builds    0
Catalog mismatches    0
Invalid JSON files    0
Duplicate component IDs    0
1. Built Core Components
Component    Name    Layer Type    Readiness    Notes
C2-B    Conditional Routing Engine    CORE_COMPONENT    BUILT    Reusable branching/routing engine
C2-C    Webhook Trigger System    CORE_COMPONENT    BUILT    Webhook intake foundation
C2-D    Deduplication / Merge Engine    CORE_COMPONENT    BUILT    Duplicate detection and merge preparation
C2-E    Form Intake Pipeline    CORE_COMPONENT    BUILT    Form intake normalization
C2-F    Payload Validation Layer    CORE_COMPONENT    BUILT    Required field/schema validation
C2-G    File Upload Routing    CORE_COMPONENT    BUILT    Routes files by type/category
C2-J    Digest Summary Notification Builder    CORE_COMPONENT    BUILT    Builds digest objects
C2-N    CSV / Excel Parser    CORE_COMPONENT    BUILT    Parses tabular imports
C2-O    Human Approval Gate    CORE_COMPONENT    BUILT    Approval request creation
C2-O2    Approval Response Capture    CORE_COMPONENT    BUILT    Approval/decline response capture
C2-P    Suppression / Opt-Out Guard    CORE_COMPONENT    BUILT    Consent/suppression guard
C4-A    AI Classification Pipeline    CORE_COMPONENT    BUILT    AI classification of records/messages
C4-B    AI Extraction Parser    CORE_COMPONENT    BUILT    Structured extraction from text
C4-D    AI Content Generation Pipeline    CORE_COMPONENT    BUILT    General AI content generation
C4-E    AI Email Draft Generator    CORE_COMPONENT    BUILT    AI email draft generation
C4-L    Lead Qualification Pipeline    CORE_COMPONENT    BUILT    Lead scoring/qualification
C4-M    AI Draft Approval Pipeline    CORE_COMPONENT    BUILT    Packages drafts for approval
C5-E    Manual Review Queue    CORE_COMPONENT    BUILT    Manual review handoff queue
C5-W    Automation Status Control Table    CORE_COMPONENT    BUILT    Workflow status tracking
C6-G    Error Log / Retry Queue    CORE_COMPONENT    BUILT    Error capture and retry preparation
2. Built Component Adapters
Component    Name    Layer Type    Readiness    Adapter For    Provider
C2-A1    Google Sheets Write Adapter    COMPONENT_ADAPTER    BUILT    Data write/sync    Google Sheets
C2-A2    Airtable Write Adapter    COMPONENT_ADAPTER    BUILT    Data write/sync    Airtable
C2-A3    HubSpot Contact Write Adapter    COMPONENT_ADAPTER    BUILT    CRM write/sync    HubSpot
C2-I    Notification / Alert Engine    COMPONENT_ADAPTER    BUILT    Notification    Email/SMTP
C2-K    LLM in Workflow Adapter    COMPONENT_ADAPTER    BUILT    AI/LLM call    OpenAI-compatible/Groq-style
3. Built Handoff-Only Cores
Component    Name    Layer Type    Readiness    Needs Attached Adapters
C2-H    Payment-on-Intake Flow    HANDOFF_ONLY_CORE    BUILT    Stripe, Razorpay, PayPal, Wise/payment status adapters
C2-L    Calendar / Scheduling Automation    HANDOFF_ONLY_CORE    BUILT    Google Calendar, Outlook Calendar, Calendly, Cal.com adapters
C2-M    WhatsApp Message Automation    HANDOFF_ONLY_CORE    BUILT    WhatsApp Cloud API, Twilio, WATI adapters
C2-Q    Publishing Adapter Family    HANDOFF_ONLY_CORE    BUILT    LinkedIn, WordPress, Webflow, X/Twitter adapters
C4-T    OCR / Document Processing Pipeline    HANDOFF_ONLY_CORE    BUILT    OCR, PDF parser, DOCX parser adapters
4. Current Scaffold-Only Components

These folders exist but are not built. They are not broken builds.

Component    Name    Layer Type    Readiness
C1-E    Multi-Step Sequence Engine    SCAFFOLD_ONLY    NOT_BUILT
C2-A    Data Sync Pipeline Parent    SCAFFOLD_ONLY    NOT_BUILT
C3-D    E-Signature Flow    SCAFFOLD_ONLY    NOT_BUILT
C3-E    Document / Invoice Generation    SCAFFOLD_ONLY    NOT_BUILT
C3-F    Delivery Tracking    SCAFFOLD_ONLY    NOT_BUILT
C3-G    Subscription Billing Engine    SCAFFOLD_ONLY    NOT_BUILT
C3-H    Payment to Onboarding    SCAFFOLD_ONLY    NOT_BUILT
C3-I    Welcome Sequence    SCAFFOLD_ONLY    NOT_BUILT
C4-C    AI Summary Generator    SCAFFOLD_ONLY    NOT_BUILT
C4-F    AI Content Repurpose Engine    SCAFFOLD_ONLY    NOT_BUILT
C5-A    Basic Dashboard View    SCAFFOLD_ONLY    NOT_BUILT
C5-B    Client Portal Table    SCAFFOLD_ONLY    NOT_BUILT
C5-C    Reporting Data Model    SCAFFOLD_ONLY    NOT_BUILT
C5-D    KPI Summary Builder    SCAFFOLD_ONLY    NOT_BUILT
C5-L    File Preview    SCAFFOLD_ONLY    NOT_BUILT
C5-T    Export Reports    SCAFFOLD_ONLY    NOT_BUILT
C5-X    KPI Monitoring / Threshold Alert Engine    SCAFFOLD_ONLY    NOT_BUILT
C6-A    Workflow Audit Checker    SCAFFOLD_ONLY    NOT_BUILT
C6-B    Error Pattern Library    SCAFFOLD_ONLY    NOT_BUILT
C6-C    API Auth Debugger    SCAFFOLD_ONLY    NOT_BUILT
C6-D    Data Mapping Diagnostic    SCAFFOLD_ONLY    NOT_BUILT
C6-E    Integration Health Check    SCAFFOLD_ONLY    NOT_BUILT
C6-F    Handoff Documentation Pack    SCAFFOLD_ONLY    NOT_BUILT
5. Highest-ROI Deferred Attached Adapters
Adapter    Layer Type    Adapter For    ROI / Demand    Priority
Google Calendar Create Event Adapter    DEFERRED_ADAPTER    C2-L    Very High    P1
Outlook Calendar Adapter    DEFERRED_ADAPTER    C2-L    High    P1
Calendly Webhook Adapter    DEFERRED_ADAPTER    C2-L    High    P1
Cal.com Adapter    DEFERRED_ADAPTER    C2-L    Medium-High    P2
Stripe Payment Link Adapter    DEFERRED_ADAPTER    C2-H    Very High    P1
Razorpay Payment Link Adapter    DEFERRED_ADAPTER    C2-H    High    P1
PayPal Invoice Adapter    DEFERRED_ADAPTER    C2-H    High    P2
Payment Status Webhook Adapter    DEFERRED_ADAPTER    C2-H    Very High    P1
WhatsApp Cloud API Send Adapter    DEFERRED_ADAPTER    C2-M    Very High    P2
Twilio WhatsApp Adapter    DEFERRED_ADAPTER    C2-M    High    P2
WATI Adapter    DEFERRED_ADAPTER    C2-M    Medium-High    P2
LinkedIn Publishing Adapter    DEFERRED_ADAPTER    C2-Q    Medium-High    P3
WordPress Publishing Adapter    DEFERRED_ADAPTER    C2-Q    High    P2
Webflow CMS Adapter    DEFERRED_ADAPTER    C2-Q    High    P2
X/Twitter Publishing Adapter    DEFERRED_ADAPTER    C2-Q    Medium    P3
PDF Text Extraction Adapter    DEFERRED_ADAPTER    C4-T    Very High    P0
DOCX Text Extraction Adapter    DEFERRED_ADAPTER    C4-T    High    P1
OCR.space Adapter    DEFERRED_ADAPTER    C4-T    High    P1
Google Vision OCR Adapter    DEFERRED_ADAPTER    C4-T    High    P1
AWS Textract Adapter    DEFERRED_ADAPTER    C4-T    Medium-High    P2
6. Highest-ROI Independent Adapters
Adapter    Layer Type    Used By    ROI / Demand    Priority
Generic REST API Adapter    INDEPENDENT_ADAPTER    Most workflows    Very High    P0
Generic Webhook Sender    INDEPENDENT_ADAPTER    Notifications/API sync/custom tools    Very High    P0
OAuth Credential Test Adapter    INDEPENDENT_ADAPTER    OAuth tools    Very High    P0
Gmail Send Adapter    INDEPENDENT_ADAPTER    Notifications/email/approval/digest    Very High    P0
Gmail Inbox Trigger Adapter    INDEPENDENT_ADAPTER    Email intake/reply tracking    Very High    P0
Outlook/M365 Send Adapter    INDEPENDENT_ADAPTER    Corporate email clients    High    P1
Outlook Inbox Trigger Adapter    INDEPENDENT_ADAPTER    Corporate email intake    High    P1
Slack Send Adapter    INDEPENDENT_ADAPTER    Alerts/approvals/errors/digests    Very High    P0
Microsoft Teams Send Adapter    INDEPENDENT_ADAPTER    Corporate alerts    High    P2
Google Drive File Adapter    INDEPENDENT_ADAPTER    File upload/docs/OCR/storage    Very High    P0
Notion Database Adapter    INDEPENDENT_ADAPTER    CRM/config/status/tasks    Very High    P0
Pipedrive Adapter    INDEPENDENT_ADAPTER    Sales CRM    Very High    P0
GoHighLevel Adapter    INDEPENDENT_ADAPTER    Agency/SMB CRM    Very High    P0
ClickUp Adapter    INDEPENDENT_ADAPTER    Task/project automation    High    P1
Supabase/Postgres Adapter    INDEPENDENT_ADAPTER    Technical storage/status/logging    High    P1
Google Sheets Generic Adapter    INDEPENDENT_ADAPTER    Config/status/logs    Very High    P0
Airtable Generic Adapter    INDEPENDENT_ADAPTER    Config/status/manual queue    High    P1
n8n Workflow Control Adapter    INDEPENDENT_ADAPTER    Deploy/test/activate workflows    High    P1
7. Highest-ROI Template Glue Workflows
Template Glue    Layer Type    Components Used    Required Adapters    Demand    Priority
Lead Intake to Qualification to Follow-up    TEMPLATE_GLUE    C2-E/C2-C, C2-F, C2-D, C4-L, C4-E, C4-M, C2-O, C2-I, C5-W, C6-G    Sheets/Airtable/HubSpot, Gmail/SMTP, Calendar optional    Very High    P0
Form Submission to CRM Update to Team Alert    TEMPLATE_GLUE    C2-E, C2-F, C2-D, C2-B, C2-A1/A2/A3, C2-I, C5-W    Sheets/Airtable/HubSpot, Email/Slack    Very High    P0
CSV/Excel Cleanup to CRM Import    TEMPLATE_GLUE    C2-N, C2-F, C2-D, C2-A1/A2/A3, C6-G    Sheets/Airtable/HubSpot    Very High    P0
Webhook to Normalize to API Sync    TEMPLATE_GLUE    C2-C, C2-F, C2-B, C6-G    Generic REST, target API    Very High    P0
AI Email Draft to Approval to Send    TEMPLATE_GLUE    C4-E, C4-M, C2-O, C2-O2, C2-I, C5-W, C6-G    Gmail/Outlook/SMTP    Very High    P0
Inbound Email to Extract to CRM Update    TEMPLATE_GLUE    Email Inbox, C4-B, C2-F, C2-D, CRM write, C2-I    Gmail/Outlook, HubSpot/Pipedrive/GHL    Very High    P0
Support Ticket Triage    TEMPLATE_GLUE    C2-C/E, C4-A, C4-B, C2-B, C2-I, C5-E, C5-W    Gmail/Slack/Helpdesk adapter    Very High    P1
Document Intake to OCR to Field Extraction    TEMPLATE_GLUE    C2-G, C4-T, C4-B, C2-F, C5-E, C5-W    PDF/DOCX/OCR adapter    High    P1
Daily Digest / Management Report    TEMPLATE_GLUE    C5-W, C6-G, C2-J, C2-I    Email/Slack/Sheets    High    P1
Error Monitoring + Retry Workflow    TEMPLATE_GLUE    C6-G, C2-B, C2-I, C5-E, C5-W    Slack/Email, Sheets/Supabase    High    P1
Payment-on-Intake Automation    TEMPLATE_GLUE    C2-E, C2-F, C2-H, C2-O, C2-I, C5-W    Stripe/Razorpay/PayPal    High    P1
Appointment Booking Follow-up    TEMPLATE_GLUE    C2-E, C4-L, C2-L, C4-E, C4-M, C2-O, C2-I    Calendly/Google Calendar/Gmail    High    P1
Invoice/Receipt Processing    TEMPLATE_GLUE    C2-G, C4-T, C4-B, C2-F, C2-A1/A2, C5-E    OCR/Textract/Mindee, Sheets/Airtable    High    P1
Content Draft to Approval to Publish Handoff    TEMPLATE_GLUE    C4-D, C4-M, C2-O, C2-O2, C2-Q, C5-W    LinkedIn/WordPress/Webflow optional    Medium-High    P2
Approval-Based WhatsApp Follow-up    TEMPLATE_GLUE    C4-E/C4-D, C4-M, C2-O, C2-M, C5-W    WhatsApp Cloud/Twilio/WATI    High    P2
8. Client Config Assets Needed
Asset    Layer Type    Purpose    Priority
Client Profile Schema    CLIENT_CONFIG_ASSET    Stores client identity, tools, tone, rules    P0
Workflow Discovery Questionnaire    CLIENT_CONFIG_ASSET    Captures trigger/source/action/error/approval logic    P0
Tool Stack Questionnaire    CLIENT_CONFIG_ASSET    Captures tools and integrations needed    P0
AI Customization Questionnaire    CLIENT_CONFIG_ASSET    Captures client voice/rules/examples/risk boundaries    P0
Credential Collection Checklist    CLIENT_CONFIG_ASSET    Lists access/API keys/OAuth needs    P0
Template Config Generator    CLIENT_CONFIG_ASSET    Converts questionnaire into config JSON    P0
Client Config Validator    CLIENT_CONFIG_ASSET    Checks missing/invalid client setup fields    P1
Client Handoff Pack Generator    CLIENT_CONFIG_ASSET    Produces delivery/maintenance docs    P1
9. P0 Build Set

The P0 build set should be:

P0-001 Lead Intake to Qualification to Follow-up Glue
P0-002 Form Submission to CRM Update to Team Alert Glue
P0-003 CSV/Excel Cleanup to CRM Import Glue
P0-004 Webhook to Normalize to API Sync Glue
P0-005 AI Email Draft to Approval to Send Glue
P0-006 Inbound Email to Extract to CRM Update Glue

P0-007 Generic REST API Adapter
P0-008 Generic Webhook Sender
P0-009 OAuth Credential Test Adapter
P0-010 Gmail Send Adapter
P0-011 Gmail Inbox Trigger Adapter
P0-012 Slack Send Adapter
P0-013 Google Drive File Adapter
P0-014 Notion Database Adapter
P0-015 Pipedrive or GoHighLevel Adapter
P0-016 PDF Text Extraction Adapter
P0-017 C2-A Parent Data Sync Router

P0-018 Client Profile Schema
P0-019 Workflow Discovery Questionnaire
P0-020 Tool Stack Questionnaire
P0-021 AI Customization Questionnaire
P0-022 Credential Collection Checklist
P0-023 Template Config Generator
10. Operating Rule

For every new build, decide the layer first:

CORE_COMPONENT
COMPONENT_ADAPTER
INDEPENDENT_ADAPTER
TEMPLATE_GLUE
CLIENT_CONFIG_ASSET
DEFERRED_ADAPTER
SCAFFOLD_ONLY

Then decide:

P0
P1
P2
P3

Then decide whether it belongs in:

components/
adapters/
templates/
client-config/
docs/
audit/

This prevents component sprawl and keeps the platform commercially aligned.
