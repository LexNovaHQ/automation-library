# Classification Summary

Generated: 2026-05-27 11:55:45

## Layer Type Counts

| Layer Type | Count |
|---|---:|
| CLIENT_CONFIG_ASSET | 10 |
| COMPONENT_ADAPTER | 5 |
| CORE_COMPONENT | 20 |
| HANDOFF_ONLY_CORE | 5 |
| INDEPENDENT_ADAPTER | 11 |
| SCAFFOLD_ONLY | 23 |
| TEMPLATE_GLUE | 6 |

## Readiness Counts

| Readiness | Count |
|---|---:|
| BUILT | 40 |
| DEFERRED_ADAPTER | 11 |
| NOT_BUILT | 29 |

## Priority Counts

| Priority | Count |
|---|---:|
| P0 | 50 |
| P1 | 13 |
| P2 | 11 |
| P3 | 6 |

## P0 Items

| ID | Name | Layer Type | Readiness |
|---|---|---|---|
| CFG-001 | Client Profile Schema | CLIENT_CONFIG_ASSET | BUILT |
| CFG-002 | Workflow Discovery Questionnaire | CLIENT_CONFIG_ASSET | BUILT |
| CFG-002A | Client-Facing Workflow Discovery Form | CLIENT_CONFIG_ASSET | BUILT |
| CFG-003 | Tool Stack Questionnaire | CLIENT_CONFIG_ASSET | BUILT |
| CFG-003A | Client-Facing Tool Stack Form | CLIENT_CONFIG_ASSET | BUILT |
| CFG-004 | AI Profile Compatibility Pack | CLIENT_CONFIG_ASSET | BUILT |
| CFG-004A | Client-Facing AI Customization Form | CLIENT_CONFIG_ASSET | BUILT |
| CFG-005 | Credential Collection Checklist | CLIENT_CONFIG_ASSET | BUILT |
| CFG-005A | Client-Facing Credential Checklist | CLIENT_CONFIG_ASSET | BUILT |
| CFG-006 | Template Config Generator | CLIENT_CONFIG_ASSET | BUILT |
| C2-A1 | Google Sheets Write Adapter | COMPONENT_ADAPTER | BUILT |
| C2-A2 | Airtable Write Adapter | COMPONENT_ADAPTER | BUILT |
| C2-A3 | HubSpot Contact Write Adapter | COMPONENT_ADAPTER | BUILT |
| C2-I | Notification / Alert Engine | COMPONENT_ADAPTER | BUILT |
| C2-K | LLM in Workflow Adapter | COMPONENT_ADAPTER | BUILT |
| C2-B | Conditional Routing Engine | CORE_COMPONENT | BUILT |
| C2-C | Webhook Trigger System | CORE_COMPONENT | BUILT |
| C2-D | Deduplication / Merge Engine | CORE_COMPONENT | BUILT |
| C2-E | Form Intake Pipeline | CORE_COMPONENT | BUILT |
| C2-F | Payload Validation Layer | CORE_COMPONENT | BUILT |
| C2-N | CSV / Excel Parser | CORE_COMPONENT | BUILT |
| C2-O | Human Approval Gate | CORE_COMPONENT | BUILT |
| C2-O2 | Approval Response Capture | CORE_COMPONENT | BUILT |
| C2-P | Suppression / Opt-Out Guard | CORE_COMPONENT | BUILT |
| C4-A | AI Classification Pipeline | CORE_COMPONENT | BUILT |
| C4-B | AI Extraction Parser | CORE_COMPONENT | BUILT |
| C4-E | AI Email Draft Generator | CORE_COMPONENT | BUILT |
| C4-L | Lead Qualification Pipeline | CORE_COMPONENT | BUILT |
| C4-M | AI Draft Approval Pipeline | CORE_COMPONENT | BUILT |
| C5-E | Manual Review Queue | CORE_COMPONENT | BUILT |
| C5-W | Automation Status Control Table | CORE_COMPONENT | BUILT |
| C6-G | Error Log / Retry Queue | CORE_COMPONENT | BUILT |
| ADP-GDRIVE | Google Drive File Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-GHL | GoHighLevel Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-GMAIL-INBOX | Gmail Inbox Trigger Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-GMAIL-SEND | Gmail Send Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-NOTION-DB | Notion Database Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-OAUTH-TEST | OAuth Credential Test Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-PDF | PDF Text Extraction Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-PIPEDRIVE | Pipedrive Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-REST | Generic REST API Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-SLACK-SEND | Slack Send Adapter | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| ADP-WEBHOOK-SEND | Generic Webhook Sender | INDEPENDENT_ADAPTER | DEFERRED_ADAPTER |
| C2-A | Data Sync Pipeline Parent | SCAFFOLD_ONLY | NOT_BUILT |
| TPL-P0-001 | Lead Intake to Qualification to Follow-up | TEMPLATE_GLUE | NOT_BUILT |
| TPL-P0-002 | Form Submission to CRM Update to Team Alert | TEMPLATE_GLUE | NOT_BUILT |
| TPL-P0-003 | CSV/Excel Cleanup to CRM Import | TEMPLATE_GLUE | NOT_BUILT |
| TPL-P0-004 | Webhook to Normalize to API Sync | TEMPLATE_GLUE | NOT_BUILT |
| TPL-P0-005 | AI Email Draft to Approval to Send | TEMPLATE_GLUE | NOT_BUILT |
| TPL-P0-006 | Inbound Email to Extract to CRM Update | TEMPLATE_GLUE | NOT_BUILT |

## Built Items

| ID | Name | Layer Type | Execution Level |
|---|---|---|---|
| CFG-001 | Client Profile Schema | CLIENT_CONFIG_ASSET | config_asset |
| CFG-002 | Workflow Discovery Questionnaire | CLIENT_CONFIG_ASSET | config_asset |
| CFG-002A | Client-Facing Workflow Discovery Form | CLIENT_CONFIG_ASSET | config_asset |
| CFG-003 | Tool Stack Questionnaire | CLIENT_CONFIG_ASSET | config_asset |
| CFG-003A | Client-Facing Tool Stack Form | CLIENT_CONFIG_ASSET | config_asset |
| CFG-004 | AI Profile Compatibility Pack | CLIENT_CONFIG_ASSET | config_asset |
| CFG-004A | Client-Facing AI Customization Form | CLIENT_CONFIG_ASSET | config_asset |
| CFG-005 | Credential Collection Checklist | CLIENT_CONFIG_ASSET | config_asset |
| CFG-005A | Client-Facing Credential Checklist | CLIENT_CONFIG_ASSET | config_asset |
| CFG-006 | Template Config Generator | CLIENT_CONFIG_ASSET | config_asset |
| C2-A1 | Google Sheets Write Adapter | COMPONENT_ADAPTER | provider_execution |
| C2-A2 | Airtable Write Adapter | COMPONENT_ADAPTER | provider_execution |
| C2-A3 | HubSpot Contact Write Adapter | COMPONENT_ADAPTER | provider_execution |
| C2-I | Notification / Alert Engine | COMPONENT_ADAPTER | provider_execution |
| C2-K | LLM in Workflow Adapter | COMPONENT_ADAPTER | provider_execution |
| C2-B | Conditional Routing Engine | CORE_COMPONENT | core_logic |
| C2-C | Webhook Trigger System | CORE_COMPONENT | core_logic |
| C2-D | Deduplication / Merge Engine | CORE_COMPONENT | core_logic |
| C2-E | Form Intake Pipeline | CORE_COMPONENT | core_logic |
| C2-F | Payload Validation Layer | CORE_COMPONENT | core_logic |
| C2-G | File Upload Routing | CORE_COMPONENT | core_logic |
| C2-J | Digest Summary Notification Builder | CORE_COMPONENT | core_logic |
| C2-N | CSV / Excel Parser | CORE_COMPONENT | core_logic |
| C2-O | Human Approval Gate | CORE_COMPONENT | core_logic |
| C2-O2 | Approval Response Capture | CORE_COMPONENT | core_logic |
| C2-P | Suppression / Opt-Out Guard | CORE_COMPONENT | core_logic |
| C4-A | AI Classification Pipeline | CORE_COMPONENT | core_logic |
| C4-B | AI Extraction Parser | CORE_COMPONENT | core_logic |
| C4-D | AI Content Generation Pipeline | CORE_COMPONENT | core_logic |
| C4-E | AI Email Draft Generator | CORE_COMPONENT | core_logic |
| C4-L | Lead Qualification Pipeline | CORE_COMPONENT | core_logic |
| C4-M | AI Draft Approval Pipeline | CORE_COMPONENT | core_logic |
| C5-E | Manual Review Queue | CORE_COMPONENT | core_logic |
| C5-W | Automation Status Control Table | CORE_COMPONENT | core_logic |
| C6-G | Error Log / Retry Queue | CORE_COMPONENT | core_logic |
| C2-H | Payment-on-Intake Flow | HANDOFF_ONLY_CORE | handoff_only |
| C2-L | Calendar / Scheduling Automation | HANDOFF_ONLY_CORE | handoff_only |
| C2-M | WhatsApp Message Automation | HANDOFF_ONLY_CORE | handoff_only |
| C2-Q | Publishing Adapter Family | HANDOFF_ONLY_CORE | handoff_only |
| C4-T | OCR / Document Processing Pipeline | HANDOFF_ONLY_CORE | handoff_only |
