# ADP-GMAIL-SEND - Gmail Send Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Sends an email through Gmail from a standardized workflow input.

## 80/20 Build Standard
This adapter counts as built only if it can validate a standardized email-send request, send through Gmail using configured n8n Gmail credentials, normalize the provider result, return a stable output contract, and fail safely into manual review/error handling.

## Supported v1 Operations
- Send plain text email
- Send HTML email
- CC and BCC
- Reply-to field if supported/configurable
- Subject/body validation
- Safe failure output

## Not Included in v1
- Attachments
- Thread replies
- Draft creation
- Gmail label management
- Bulk sends
- OAuth setup automation

## Input Contract

`json
{
  "request_id": "req_gmail_send_001",
  "source_component": "C4-E",
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
  "component_id": "ADP-GMAIL-SEND",
  "request_id": "req_gmail_send_001",
  "provider": "gmail",
  "operation": "send_email",
  "message_id": "provider_message_id_or_null",
  "thread_id": "provider_thread_id_or_null",
  "manual_review_required": false,
  "error_code": null,
  "error_message": null,
  "next_action": "log_status",
  "downstream_components": ["C5-W"],
  "source_result": {}
}
`",
",

- send-html.valid.json
- send-text.valid.json
- send-with-cc-bcc.valid.json
- missing-to.invalid.json
- missing-subject.invalid.json
- missing-body.invalid.json
- invalid-send-format.invalid.json

## Version
v1.0 draft
