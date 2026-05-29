# ADP-SMTP-SEND - Generic SMTP Send Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-EMAIL - Email Send and Inbox

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Sends outbound email through a manually configured SMTP credential from a standardized workflow input.

## Why This Exists
ADP-SMTP-SEND is the universal email-send fallback for clients who do not use Gmail or Outlook/M365, but can provide SMTP credentials.

## 80/20 Build Standard
This adapter counts as built only if it can validate a standardized email-send request, send through SMTP using manually configured n8n SMTP/email credentials, normalize the provider result, return a stable output contract, and fail safely into manual review/error handling.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs, SMTP usernames, passwords, hostnames, or secrets are embedded in the workflow JSON.

## n8n Import Note
SMTP/email credentials must be configured manually in n8n after import. If a Switch node is used, fallback/extra output must be confirmed manually in n8n.

## Supported v1 Operations
- Send plain text email
- Send HTML email
- CC and BCC
- Reply-to field where supported by n8n email node
- Sender name/from field where supported by n8n email node
- Subject/body validation
- Safe failure output

## Not Included in v1
- Attachments
- Email inbox polling
- Thread replies
- Draft creation
- Bulk email campaign sending
- SMTP credential creation or testing
- Deliverability checks

## Input Contract

`json
{
  "request_id": "req_smtp_send_001",
  "source_component": "C2-I",
  "email": {
    "from": "sender@example.com",
    "from_name": "Sender Name",
    "to": ["recipient@example.com"],
    "cc": [],
    "bcc": [],
    "reply_to": "reply@example.com",
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
  "component_id": "ADP-SMTP-SEND",
  "component_version": "v1",
  "request_id": "req_smtp_send_001",
  "provider": "smtp",
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
- missing-from.invalid.json
- missing-to.invalid.json
- missing-subject.invalid.json
- missing-body.invalid.json
- invalid-send-format.invalid.json

## Version
v1.0 draft
