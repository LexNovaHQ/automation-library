# ADP-GMAIL-INBOX - Gmail Inbox Trigger Adapter

## Status
Built v1.0.

## Primary Category
Category 2 - Automation Workflows

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Triggers from new Gmail messages and normalizes inbound email data into a stable automation input contract.

## 80/20 Build Standard
This adapter passes the 80/20 build standard for Gmail inbound trigger normalization. It triggers from Gmail using a manually configured n8n Gmail credential, normalizes core email fields, preserves Gmail source metadata, returns a stable output contract, and routes malformed/unusable messages into manual review/error handling.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs or secrets are embedded in the workflow JSON.

## n8n Import Note
Gmail Trigger credentials, event, filter, and poll settings must be configured manually in n8n after import.

## Supported v1 Operations
- Trigger on newly received Gmail messages
- Normalize sender, recipients, subject, snippet/body, message ID, thread ID, labels, and timestamp
- Test branch via webhook for payload-based testing
- Emit stable downstream object for C4-B extraction, C4-A classification, C2-D dedupe, C2-B routing, and CRM write workflows
- Safe error/manual-review output for malformed messages

## Not Included in v1
- Sending replies
- Marking messages read/unread
- Applying/removing Gmail labels
- Attachments extraction
- Thread history expansion
- Bulk mailbox sync

## Workflow Artifact
- workflows/adp-gmail-inbox-trigger-adapter-v1.json

## Test Payloads
- gmail-trigger-basic.valid.json
- gmail-trigger-with-cc.valid.json
- gmail-trigger-missing-from.invalid.json
- gmail-trigger-missing-message-id.invalid.json
- gmail-trigger-empty-subject.valid.json
- gmail-trigger-no-body.valid.json

## Output Samples
- success-basic-message.json
- success-with-cc.json
- success-empty-subject.json
- success-no-body.json
- error-missing-from.json
- error-missing-message-id.json

## Normalized Output Contract

`json
{
  "adapter_status": "success",
  "component_id": "ADP-GMAIL-INBOX",
  "component_version": "v1",
  "provider": "gmail",
  "operation": "inbound_email_trigger",
  "validation_status": "valid",
  "message_id": "gmail_message_id",
  "thread_id": "gmail_thread_id",
  "from": { "email": "sender@example.com", "name": "Sender Name" },
  "to": ["recipient@example.com"],
  "cc": [],
  "bcc": [],
  "subject": "Email subject",
  "snippet": "Email snippet",
  "body_text": "Normalized body text or snippet fallback",
  "received_at": "provider_timestamp_or_null",
  "labels": ["INBOX"],
  "manual_review_required": false,
  "error_code": null,
  "error_message": null,
  "next_action": "route_to_email_processing",
  "downstream_components": ["C4-B", "C4-A", "C2-D", "C2-B", "C5-W"],
  "source_result": {}
}
`",
",

- Webhook test branch passed.
- Valid payload normalization passed.
- Invalid payload/manual-review outputs passed.
- Live Gmail Trigger branch confirmed working after workflow activation.

## Version
v1.0
