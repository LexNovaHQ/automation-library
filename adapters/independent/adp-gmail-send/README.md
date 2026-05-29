# ADP-GMAIL-SEND - Gmail Send Adapter

## Status
Built v1.0.

## Primary Category
Category 2 - Automation Workflows

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Sends an email through Gmail from a standardized workflow input.

## 80/20 Build Standard
This adapter passes the 80/20 build standard for Gmail outbound sending. It validates a standardized email-send request, sends through Gmail using a manually configured n8n Gmail credential, normalizes the provider result, returns a stable output contract, and fails safely into manual review/error handling.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs or secrets are embedded in the workflow JSON.

## n8n Import Note
Switch fallback/extra output may not import correctly from JSON. In n8n, confirm that Validation Switch fallback/extra output is connected to Return Gmail Send Result.

## Supported v1 Operations
- Send plain text email
- Send HTML email
- CC and BCC
- Reply-to field where supported by n8n Gmail node
- Sender name where supported by n8n Gmail node
- Subject/body validation
- Safe failure output

## Not Included in v1
- Attachments
- Thread replies
- Draft creation
- Gmail label management
- Bulk sends
- OAuth setup automation

## Workflow Artifact
- workflows/adp-gmail-send-adapter-v1.json

## Test Payloads
- send-html.valid.json
- send-text.valid.json
- send-with-cc-bcc.valid.json
- missing-to.invalid.json
- missing-subject.invalid.json
- missing-body.invalid.json
- invalid-send-format.invalid.json

## Output Samples
- success-send-text.json
- success-send-html.json
- success-send-cc-bcc.json
- error-missing-to.json
- error-missing-subject.json
- error-missing-body.json
- error-invalid-send-format.json

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
  "component_version": "v1",
  "request_id": "req_gmail_send_001",
  "provider": "gmail",
  "operation": "send_email",
  "validation_status": "valid",
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

- Invalid validation tests passed.
- Text send test passed.
- HTML send test passed.
- CC/BCC send test passed.

## Version
v1.0
