# ADP-OUTLOOK-INBOX - Outlook/M365 Inbox Trigger Adapter

## Status
Built v1.0.

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
Use n8n Microsoft Outlook OAuth2 credentials and Microsoft Outlook trigger behavior. Do not use IMAP/basic auth for Microsoft 365 inboxes.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs, tenant IDs, client IDs, client secrets, or Microsoft account details are embedded in the workflow JSON.

## Platform Setup
Microsoft Entra app and Microsoft Outlook OAuth2 credential are reused from ADP-OUTLOOK-SEND. Inbox/read access may require Microsoft Graph delegated Mail.Read permission and credential reconnection.

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

## Workflow Artifact
- workflows/adp-outlook-inbox-adapter-v1.json

## Test Payloads
- outlook-basic.valid.json
- outlook-with-cc.valid.json
- outlook-html.valid.json
- outlook-empty-subject.valid.json
- outlook-no-body.valid.json
- outlook-missing-from.invalid.json
- outlook-missing-message-id.invalid.json

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
- Live Outlook trigger branch confirmed where credential/folder access is available.

## Version
v1.0
