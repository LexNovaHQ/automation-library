# ADP-OUTLOOK-SEND - Outlook/M365 Send Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-EMAIL - Email Send and Inbox

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Sends outbound email through Outlook/Microsoft 365 from a standardized workflow input.

## Why This Exists
ADP-OUTLOOK-SEND is the second high-ROI platform email send adapter after Gmail. It covers clients using Outlook.com or Microsoft 365 mailboxes.

## Provider Rule
Use n8n Microsoft Outlook node with Microsoft Outlook OAuth2 credentials. Do not use SMTP/basic auth for Outlook/M365.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs, tenant IDs, client IDs, client secrets, or Microsoft account details are embedded in the workflow JSON.

## n8n Import Note
Microsoft Outlook OAuth2 credentials must be configured manually in n8n after import. If a Switch node is used, fallback/extra output must be confirmed manually in n8n.

## Supported v1 Operations
- Send plain text email where supported by Outlook node
- Send HTML email where supported by Outlook node
- CC and BCC where supported by Outlook node
- Subject/body validation
- Safe failure output

## Not Included in v1
- Attachments
- Thread replies
- Draft creation
- Label/folder management
- Bulk email campaign sending
- OAuth app registration automation
- Shared mailbox support beyond credential-level configuration

## Input Contract

`json
{
  "request_id": "req_outlook_send_001",
  "source_component": "C2-I",
  "email": {
    "to": ["recipient@example.com"],
    "cc": [],
    "bcc": [],
    "subject": "Subject line",
    "body_text": "Plain text body",
    "body_html": "<p>HTML body</p>",
    "send_format": "html"
  },
  "routing_options": {
    "on_success": "log_status",
    "on_failure": "manual_review"
  }
}
`",
",


`json
{
  "adapter_status": "success",
  "component_id": "ADP-OUTLOOK-SEND",
  "component_version": "v1",
  "request_id": "req_outlook_send_001",
  "provider": "outlook_m365",
  "operation": "send_email",
  "validation_status": "valid",
  "message_id": "provider_message_id_or_null",
  "manual_review_required": false,
  "error_code": null,
  "error_message": null,
  "next_action": "log_status",
  "downstream_components": ["C5-W"],
  "source_result": {}
}
`",
",

- send-text.valid.json
- send-html.valid.json
- send-with-cc-bcc.valid.json
- missing-to.invalid.json
- missing-subject.invalid.json
- missing-body.invalid.json
- invalid-send-format.invalid.json

## Version
v1.0 draft
