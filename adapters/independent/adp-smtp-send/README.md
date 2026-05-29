# ADP-SMTP-SEND - Generic SMTP Send Adapter

## Status
Built v1.0.

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

## Relationship to C2-I
C2-I is the notification orchestration component. ADP-SMTP-SEND is the lower-level universal SMTP provider execution adapter. C2-I may call ADP-SMTP-SEND when the selected notification channel is SMTP email.

## 80/20 Build Standard
This adapter passes the 80/20 build standard for generic SMTP outbound sending. It validates a standardized email-send request, sends through SMTP using manually configured n8n Send Email credentials, normalizes the provider result, returns a stable output contract, and fails safely into manual review/error handling.

## Credential Rule
Credentials are added manually by the user inside n8n. No real credential IDs, SMTP usernames, passwords, hostnames, or secrets are embedded in the workflow JSON.

## n8n Import Note
SMTP/email credentials must be configured manually in n8n after import. Confirm that Validation Switch fallback/extra output is connected to Return SMTP Send Result.

## Supported v1 Operations
- Send plain text email
- Send HTML email
- CC and BCC
- Reply-to field where supported by n8n Email Send node
- Sender name/from field where supported by n8n Email Send node
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

## Workflow Artifact
- workflows/adp-smtp-send-adapter-v1.json

## Test Payloads
- send-text.valid.json
- send-html.valid.json
- send-with-cc-bcc.valid.json
- missing-from.invalid.json
- missing-to.invalid.json
- missing-subject.invalid.json
- missing-body.invalid.json
- invalid-send-format.invalid.json

## Output Samples
- success-send-text.json
- success-send-html.json
- success-send-cc-bcc.json
- error-missing-from.json
- error-missing-to.json
- error-missing-subject.json
- error-missing-body.json
- error-invalid-send-format.json

## Tested
- Invalid validation tests passed.
- Text send test passed.
- HTML send test passed.
- CC/BCC send test passed.
- SMTP credential configured manually in n8n.

## Version
v1.0
