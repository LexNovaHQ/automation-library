# ADP-IMAP-INBOX - Generic IMAP Inbox Adapter

## Status
Built v1.0.

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
This adapter passes the 80/20 build standard for generic IMAP inbox intake. It triggers on newly received IMAP email, normalizes core email fields, preserves source metadata, returns a stable output contract, and routes malformed/unusable messages into manual review/error handling.

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

## Workflow Artifact
- workflows/adp-imap-inbox-adapter-v1.json

## Test Payloads
- imap-basic.valid.json
- imap-with-cc.valid.json
- imap-html.valid.json
- imap-empty-subject.valid.json
- imap-no-body.valid.json
- imap-missing-from.invalid.json
- imap-missing-message-id.invalid.json

## Output Samples
- success-basic-message.json
- success-with-cc.json
- success-html-message.json
- success-empty-subject.json
- success-no-body.json
- error-missing-from.json
- error-missing-message-id.json

## Tested
- Webhook test branch passed.
- Valid payload normalization passed.
- Invalid payload/manual-review outputs passed.
- Live IMAP trigger configured/tested where credential available.

## Version
v1.0
