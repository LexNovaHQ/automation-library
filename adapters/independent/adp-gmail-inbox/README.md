# ADP-GMAIL-INBOX - Gmail Inbox Trigger Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Triggers from new Gmail messages and normalizes inbound email data into a stable automation input contract.

## 80/20 Build Standard
This adapter counts as built only if it can trigger on a new Gmail message, normalize core email fields, preserve Gmail source metadata, return a stable output contract, and route malformed/unusable messages into manual review/error handling.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs or secrets are embedded in the workflow JSON.

## n8n Import Note
Gmail Trigger credentials and poll settings must be configured manually in n8n after import.

## Supported v1 Operations
- Trigger on newly received Gmail messages
- Normalize sender, recipients, subject, snippet/body, message ID, thread ID, labels, and timestamp
- Emit stable downstream object for C4-B extraction, C4-A classification, C2-D dedupe, C2-B routing, and CRM write workflows
- Safe error/manual-review output for malformed messages

## Not Included in v1
- Sending replies
- Marking messages read/unread
- Applying/removing Gmail labels
- Attachments extraction
- Thread history expansion
- Bulk mailbox sync

## Input Source
n8n Gmail Trigger node using Message Received event.

## Normalized Output Contract

`json
{
  "adapter_status": "success",
  "component_id": "ADP-GMAIL-INBOX",
  "component_version": "v1",
  "provider": "gmail",
  "operation": "inbound_email_trigger",
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
  "next_action": "route_to_email_processing",
  "downstream_components": ["C4-B", "C4-A", "C2-D", "C2-B", "C5-W"],
  "source_result": {}
}
`",
",

- gmail-trigger-basic.valid.json
- gmail-trigger-with-cc.valid.json
- gmail-trigger-missing-from.invalid.json
- gmail-trigger-missing-message-id.invalid.json
- gmail-trigger-empty-subject.valid.json
- gmail-trigger-no-body.valid.json

## Version
v1.0 draft
