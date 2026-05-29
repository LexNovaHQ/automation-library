# ADP-IMAP-INBOX - Generic IMAP Inbox Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-EMAIL - Email Send and Inbox

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Receives inbound email through a manually configured IMAP credential and normalizes the message into a stable automation input contract.

## Why This Exists
ADP-IMAP-INBOX is the universal inbox fallback for clients who do not use Gmail or Outlook/M365 native nodes, but can provide IMAP credentials.

## 80/20 Build Standard
This adapter counts as built only if it can trigger on newly received IMAP email, normalize core email fields, preserve source metadata, return a stable output contract, and route malformed/unusable messages into manual review/error handling.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs, email usernames, passwords, hostnames, or secrets are embedded in the workflow JSON.

## n8n Import Note
IMAP credentials, mailbox name, mark-read behavior, attachment toggle, and output format must be configured manually in n8n after import.

## Supported v1 Operations
- Trigger on newly received IMAP messages
- Normalize sender, recipients, subject, text/html body, message ID, date, and mailbox metadata where available
- Webhook test branch for payload-based testing
- Emit stable downstream object for extraction, classification, dedupe, routing, and CRM write workflows
- Safe error/manual-review output for malformed messages

## Not Included in v1
- SMTP sending
- Applying provider-specific labels
- Thread expansion
- Attachment parsing
- Bulk mailbox sync
- IMAP credential creation

## Input Source
n8n Email Trigger (IMAP) node using manually configured IMAP credentials.

## Normalized Output Contract

`json
{
  "adapter_status": "success",
  "component_id": "ADP-IMAP-INBOX",
  "component_version": "v1",
  "provider": "imap",
  "operation": "inbound_email_trigger",
  "validation_status": "valid",
  "message_id": "message_id_or_uid",
  "thread_id": null,
  "from": { "email": "sender@example.com", "name": "Sender Name" },
  "to": ["recipient@example.com"],
  "cc": [],
  "bcc": [],
  "subject": "Email subject",
  "snippet": "Short text snippet",
  "body_text": "Normalized text body",
  "body_html": "<p>HTML body</p>",
  "received_at": "provider_date_or_null",
  "mailbox": "INBOX",
  "manual_review_required": false,
  "next_action": "route_to_email_processing",
  "downstream_components": ["C4-B", "C4-A", "C2-D", "C2-B", "C5-W"],
  "source_result": {}
}
`",
",

- imap-basic.valid.json
- imap-with-cc.valid.json
- imap-html.valid.json
- imap-empty-subject.valid.json
- imap-no-body.valid.json
- imap-missing-from.invalid.json
- imap-missing-message-id.invalid.json

## Version
v1.0 draft
