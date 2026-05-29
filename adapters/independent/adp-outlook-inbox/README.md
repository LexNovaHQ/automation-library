# ADP-OUTLOOK-INBOX - Outlook/M365 Inbox Trigger Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-EMAIL - Email Send and Inbox

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Triggers from Outlook/Microsoft 365 inbound email and normalizes message data into a stable automation input contract.

## Why This Exists
ADP-OUTLOOK-INBOX completes Microsoft email coverage for the Email family. It is the Outlook/M365 counterpart to ADP-GMAIL-INBOX and the platform-specific alternative to ADP-IMAP-INBOX.

## Provider Rule
Use n8n Microsoft Outlook OAuth2 credentials and Microsoft Outlook node/trigger behavior. Do not use IMAP/basic auth for Microsoft 365 inboxes.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs, tenant IDs, client IDs, client secrets, or Microsoft account details are embedded in the workflow JSON.

## Platform Setup
Microsoft Entra app and Microsoft Outlook OAuth2 credential are already available from ADP-OUTLOOK-SEND. Reuse the existing credential where possible.

## n8n Import Note
Microsoft Outlook OAuth2 credentials must be selected manually in n8n after import. Trigger/poll/folder settings must be confirmed manually.

## Supported v1 Operations
- Trigger on newly received Outlook/M365 messages where supported by n8n
- Normalize sender, recipients, subject, body/snippet, message ID, received date, and folder/mailbox metadata where available
- Webhook test branch for payload-based testing
- Emit stable downstream object for extraction, classification, dedupe, routing, and CRM write workflows
- Safe error/manual-review output for malformed messages

## Not Included in v1
- Sending replies
- Moving messages between folders
- Applying categories
- Attachments extraction
- Thread expansion
- Bulk mailbox sync
- Shared mailbox support beyond credential-level configuration

## Input Source
n8n Microsoft Outlook trigger/message output using manually configured Microsoft Outlook OAuth2 credentials.

## Normalized Output Contract

`json
{
  "adapter_status": "success",
  "component_id": "ADP-OUTLOOK-INBOX",
  "component_version": "v1",
  "provider": "outlook_m365",
  "operation": "inbound_email_trigger",
  "validation_status": "valid",
  "message_id": "outlook_message_id",
  "thread_id": "conversation_id_or_null",
  "from": { "email": "sender@example.com", "name": "Sender Name" },
  "to": ["recipient@example.com"],
  "cc": [],
  "bcc": [],
  "subject": "Email subject",
  "snippet": "Short preview text",
  "body_text": "Normalized text body or preview fallback",
  "body_html": "<p>HTML body</p>",
  "received_at": "provider_received_datetime_or_null",
  "folder": "Inbox",
  "manual_review_required": false,
  "next_action": "route_to_email_processing",
  "downstream_components": ["C4-B", "C4-A", "C2-D", "C2-B", "C5-W"],
  "source_result": {}
}
`",
",

- outlook-basic.valid.json
- outlook-with-cc.valid.json
- outlook-html.valid.json
- outlook-empty-subject.valid.json
- outlook-no-body.valid.json
- outlook-missing-from.invalid.json
- outlook-missing-message-id.invalid.json

## Version
v1.0 draft
