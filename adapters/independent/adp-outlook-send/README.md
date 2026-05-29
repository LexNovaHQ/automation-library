# ADP-OUTLOOK-SEND - Outlook/M365 Send Adapter

## Status
Built v1.0.

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

## Platform Setup Required
Create a Microsoft Entra app registration, add Microsoft Graph delegated Mail.Send permission, configure the n8n OAuth callback URL as a Web redirect URI, create a client secret, then connect the Microsoft Outlook OAuth2 credential inside n8n.

## n8n Import Note
Microsoft Outlook OAuth2 credentials must be configured manually in n8n after import. Confirm that Validation Switch fallback/extra output is connected to Return Outlook Send Result.

## Outlook Recipient Handling Note
Do not pass empty optional recipient fields into the Microsoft Outlook node. In v1, CC/BCC are not mapped unless explicitly configured because Outlook may try to resolve blank recipients and fail with Recipient '' is not resolved.

## Supported v1 Operations
- Send plain text email
- Send HTML email
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
- CC/BCC execution unless manually configured with non-empty recipient handling

## Workflow Artifact
- workflows/adp-outlook-send-adapter-v1.json

## Test Payloads
- send-text.valid.json
- send-html.valid.json
- send-with-cc-bcc.valid.json
- missing-to.invalid.json
- missing-subject.invalid.json
- missing-body.invalid.json
- invalid-send-format.invalid.json

## Output Samples
- success-send-text.json
- success-send-html.json
- error-missing-to.json
- error-missing-subject.json
- error-missing-body.json
- error-invalid-send-format.json

## Tested
- Invalid validation tests passed.
- Text send test passed.
- HTML send test passed.
- Microsoft Outlook OAuth2 credential configured manually in n8n.
- Empty CC/BCC recipient issue identified and avoided in v1.

## Version
v1.0
