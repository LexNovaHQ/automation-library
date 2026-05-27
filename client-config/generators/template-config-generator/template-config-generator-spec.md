# Template Config Generator Spec

## ID
CFG-006

## Name
Template Config Generator

## Version
v1.0 spec

---

# 1. Purpose

The Template Config Generator converts discovery inputs into a template-ready implementation config.

It is the deterministic bridge between:

```text
client answers
        ↓
structured profiles
        ↓
template/component/adapter selection
        ↓
implementation plan

CFG-006 does not execute workflows. It produces the configuration and recommendation package required to assemble workflows.

2. Input Objects

CFG-006 expects these inputs.

2.1 Client Profile

Source:

CFG-001 Client Profile Schema

Expected file:

client-config/examples/client-profile.example.json

Primary sections used:

client_identity
business_context
tool_stack
workflow_preferences
approval_rules
communication
ai_profile
data_rules
deployment
assembly_preferences
2.2 Workflow Discovery Response

Source:

CFG-002 Workflow Discovery Questionnaire

Primary sections used:

workflow_identity
trigger_source
input_data
processing_logic
outputs_actions
approval_review
error_handling
ai_requirements
success_metrics
assembly_engine_notes
2.3 Tool Stack Response

Source:

CFG-003 Tool Stack Questionnaire

Primary sections used:

tool_stack_overview
source_systems
destination_systems
crm_database_stack
communication_tools
calendar_scheduling_tools
payment_invoice_tools
file_document_tools
publishing_marketing_tools
access_credentials
adapter_mapping
assembly_engine_output
2.4 AI Profile Response

Source:

CFG-004 AI Profile Compatibility Pack

Primary sections used:

ai_use_cases
voice
business_context
output_rules
risk_boundaries
examples
approval_preferences
2.5 Credential Readiness Response

Source:

CFG-005 Credential Collection Checklist

Primary sections used:

credential_overview
tool_access_inventory
oauth_api_security
test_sandbox_readiness
webhooks
data_privacy_security
blocker_assessment
2.6 Component Classification Matrix

Source:

audit/config/component-classification.csv

Used to identify:

built core components
built component adapters
built handoff-only cores
deferred independent adapters
template glues
client config assets
P0/P1/P2 priorities
3. Output Objects

CFG-006 produces three primary outputs.

template_config.json
adapter_gap_report.json
assembly_recommendation.json
4. Template Selection Rules
4.1 Use explicit preferred template first

If workflow discovery contains:

assembly_engine_notes.preferred_template

and the template exists in classification matrix, select it unless contradicted by workflow facts.

4.2 Otherwise infer template from trigger + action pattern
Workflow Pattern    Recommended Template
form/webhook lead input + qualification + follow-up    TPL-P0-001 Lead Intake to Qualification to Follow-up
form submission + CRM/sheet update + alert    TPL-P0-002 Form Submission to CRM Update to Team Alert
CSV/Excel upload + cleanup + CRM import    TPL-P0-003 CSV/Excel Cleanup to CRM Import
webhook/API event + normalize + external API sync    TPL-P0-004 Webhook to Normalize to API Sync
AI email draft + approval + send    TPL-P0-005 AI Email Draft to Approval to Send
inbound email + extract + CRM update    TPL-P0-006 Inbound Email to Extract to CRM Update
support message + classify + route    P1 Support Ticket Triage
document/file + extraction/OCR    P1 Document Intake to OCR to Field Extraction
status/error summary    P1 Daily Digest / Management Report
error handling/retry    P1 Error Monitoring + Retry Workflow
payment intake/link/invoice    P1 Payment-on-Intake Automation
calendar booking/follow-up    P1 Appointment Booking Follow-up
invoice/receipt extraction    P1 Invoice/Receipt Processing
4.3 If no template fits

Return:

{
  "template_fit": "no_clear_fit",
  "recommendation": "custom_glue_required"
}
5. Component Selection Rules
5.1 Always include reliability components for real templates

Unless explicitly excluded, include:

C5-W Automation Status Control Table
C6-G Error Log / Retry Queue
5.2 Trigger/source mapping
Source Need    Component
form intake    C2-E
webhook trigger    C2-C
file upload    C2-G
CSV/Excel import    C2-N
email inbox    ADP-GMAIL-INBOX or Outlook inbox adapter
scheduled run    future scheduler/manual n8n trigger
5.3 Validation/data quality mapping
Need    Component
required field checks    C2-F
duplicate detection    C2-D
suppression/opt-out    C2-P
routing/branching    C2-B
5.4 AI task mapping
AI Need    Component
classify    C4-A
extract    C4-B
generate content    C4-D
draft email    C4-E
qualify lead    C4-L
approval package for AI draft    C4-M
LLM call    C2-K
5.5 Output/action mapping
Output Need    Component / Adapter
Google Sheets write    C2-A1
Airtable write    C2-A2
HubSpot contact write    C2-A3
notification email    C2-I or ADP-GMAIL-SEND
human approval    C2-O
approval response    C2-O2
manual review    C5-E
scheduling handoff    C2-L
payment handoff    C2-H
WhatsApp handoff    C2-M
publishing handoff    C2-Q
document/OCR routing    C4-T
6. Adapter Selection Rules
6.1 Prefer built component adapters first

If a required tool maps to a built adapter, use it.

Built adapters include:

C2-A1 Google Sheets Write Adapter
C2-A2 Airtable Write Adapter
C2-A3 HubSpot Contact Write Adapter
C2-I Notification / Alert Engine
C2-K LLM in Workflow Adapter
6.2 Use independent adapters when provider-specific live execution is needed

Examples:

Gmail send -> ADP-GMAIL-SEND
Gmail inbox -> ADP-GMAIL-INBOX
Slack send -> ADP-SLACK-SEND
Generic API write -> ADP-REST
Google Drive file access -> ADP-GDRIVE
Notion database -> ADP-NOTION-DB
Pipedrive CRM -> ADP-PIPEDRIVE
GoHighLevel CRM -> ADP-GHL
PDF extraction -> ADP-PDF
6.3 If adapter is deferred

Add it to:

adapter_gap_report.deferred_adapters_required

Then decide action using:

client_profile.assembly_preferences.adapter_gap_action

Allowed actions:

flag_and_scope_custom_build
manual_handoff
reject_template_fit
use_generic_rest_adapter
6.4 If live execution is not required

Use a handoff-only core where available:

C2-H Payment-on-Intake Flow
C2-L Calendar / Scheduling Automation
C2-M WhatsApp Message Automation
C2-Q Publishing Adapter Family
C4-T OCR / Document Processing Pipeline
7. Credential Readiness Rules
7.1 If required credential is not ready

Mark the related adapter as blocked.

Output:

credential_blockers
build_readiness = demo_only / blocked / partial
7.2 Build readiness levels
Status    Meaning
ready_for_production_build    all required adapters and credentials ready
ready_for_demo_build    can build with dummy/manual/mock data
ready_with_manual_handoffs    live adapters unavailable but handoffs acceptable
blocked_by_credentials    required access missing
blocked_by_adapter_gap    required adapter not built and no acceptable fallback
needs_more_information    discovery is incomplete
7.3 Production access rule

If production access is restricted, mark:

production_test_allowed = false

and require dummy or sandbox test plan.

8. AI Profile Mapping Rules

Use CFG-004 to assemble C4-specific client_ai_profile blocks.

8.1 C4-A

Needs:

classification_rules
risk_boundaries
approval_rules
8.2 C4-B

Needs:

extraction_rules
risk_boundaries
approval_rules
8.3 C4-D

Needs:

voice_profile
offer_profile
content_rules
risk_boundaries
approval_rules
8.4 C4-E

Needs:

audience_profile
voice_profile
offer_profile
email_rules
risk_boundaries
approval_rules
8.5 C4-L

Needs:

audience_profile
lead_qualification_rules
risk_boundaries
approval_rules
8.6 C4-M

Needs:

approval rules
reviewer metadata
risk flags
manual review instructions
9. Missing Information Rules

If required inputs are missing, add to:

missing_client_information

Common missing items:

sample input missing
required fields unclear
destination tool unknown
credential owner unknown
approval owner missing
AI restrictions missing
dedupe key missing
test cases missing

If critical missing information exists, set:

build_readiness = needs_more_information
10. Test Plan Generation Rules

Every generated config must include test cases.

Minimum test cases:

valid input
missing required field
duplicate record
low confidence AI result
tool/API failure
manual review path
success notification
status/error logging

Template-specific additional tests:

Template    Additional Tests
Lead Intake    qualified/unqualified/manual review lead
CSV Import    malformed row, duplicate row, invalid file
Email Draft    approval required, rejected draft, edited draft
Inbound Email    email without sender, attachment present
Payment    failed payment, paid event, missing amount
Document OCR    unsupported file, OCR failure, low confidence extraction
11. Output Schema: template_config.json

Required top-level sections:

config_version
generated_for
selected_template
template_fit
build_readiness
required_components
required_adapters
manual_handoffs
client_config
workflow_config
ai_config
approval_config
status_error_config
test_plan
missing_client_information
notes
12. Output Schema: adapter_gap_report.json

Required top-level sections:

config_version
selected_template
built_adapters_available
deferred_adapters_required
missing_adapters
credential_blockers
manual_handoff_options
recommended_adapter_actions
risk_level
notes
13. Output Schema: assembly_recommendation.json

Required top-level sections:

config_version
recommended_action
build_readiness
selected_template
why_this_template
can_start_now
blocking_items
next_steps
implementation_mode
test_strategy
handoff_notes
14. Assembly Engine Instruction

When used inside a ChatGPT Project/GPT, the Assembly Engine should:

1. Load client profile.
2. Load workflow discovery response.
3. Load tool stack response.
4. Load AI profile response.
5. Load credential readiness response.
6. Load component classification CSV.
7. Select best-fit template.
8. Select components.
9. Select adapters.
10. Identify adapter gaps.
11. Identify credential blockers.
12. Generate template_config.json.
13. Generate adapter_gap_report.json.
14. Generate assembly_recommendation.json.
15. Produce implementation steps only after gaps/blockers are clearly labelled.

The Assembly Engine must not pretend a deferred adapter is built.

The Assembly Engine must not auto-approve external actions when approval is required.

The Assembly Engine must prefer existing built components before suggesting custom builds.

The Assembly Engine must flag missing information instead of inventing client facts.
