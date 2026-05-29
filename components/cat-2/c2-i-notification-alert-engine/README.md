# C2-I1 - Email Notification Adapter

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Sends email notifications from standardized upstream automation outputs, especially C2-A write results.

C2-I1 is the first adapter in the C2-I Notification & Alert Engine family. It sends success notifications only when upstream action succeeded and `next_action` requests `notify_team`.

## Architecture
C2-I1 contains one n8n workflow:

1. `C2-I1_CORE_Email_Notification_Adapter_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses notifications when `next_action` is not `notify_team`.
   - Prepares subject/body from source result and payload.
   - Sends email through SMTP.
   - Returns a standard notification success/failure object.

## Workflow Files
- `workflows/c2-i1-core-email-notification-adapter-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- IF node
- Send Email node
- SMTP credential
- Microsoft 365 SMTP tested with STARTTLS on port 587

## Input Contract

```json
{
  "input": {
    "success": true,
    "component_id": "C2-A1",
    "component_version": "v1",
    "event_id": "",
    "event_type": "",
    "destination": {},
    "write": {
      "status": "created",
      "fields_written": []
    },
    "payload": {},
    "metadata": {},
    "error": null,
    "next_action": "notify_team"
  },
  "config": {
    "channel": "email",
    "to": "",
    "from": "",
    "subject_template": "New {{event_type}} record created",
    "default_next_action": "end"
  }
}

Output Contract
{
  "success": true,
  "component_id": "C2-I1",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "notification": {
    "channel": "email",
    "status": "sent",
    "to": "",
    "subject": "",
    "provider_message_id": null
  },
  "source_result": {
    "component_id": "",
    "destination": {},
    "write": {}
  },
  "payload": {},
  "metadata": {},
  "error": null,
  "next_action": "end"
}
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
NOTIFICATION_NOT_REQUESTED
MISSING_RECIPIENT
MISSING_FROM_EMAIL
UNSUPPORTED_CHANNEL
Test Payloads
test-payloads/email-notify.valid.json
test-payloads/upstream-write-failed.invalid.json
test-payloads/missing-recipient.invalid.json
Output Samples
output-samples/success-output.json
output-samples/error-upstream-action-failed.json
output-samples/error-missing-recipient.json
Passed Tests
Valid email notification
Email received
Upstream write failed
Missing recipient
Failure cases did not send email
80/20 Interoperability Rule

The reusable 80% layer is the email notification adapter: read upstream output, prepare alert, block failed/non-requested notifications, send email, normalize notification result. The configurable 20% layer is recipient, sender, subject template, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses Send Email node with SMTP credential.

Make.com

Can be rebuilt using Make Email / SMTP / Microsoft 365 email modules after receiving standardized upstream output. The same input contract and output samples should be used.

Zapier

Can be rebuilt for simple cases using Email by Zapier, Gmail, Outlook, or SMTP by Zapier.

Not Included

These are intentionally excluded from C2-I1 and belong to later components:

Slack notification adapter -> C2-I2
WhatsApp/SMS notification adapter -> C2-I3 / C2-M
Digest/summary builder -> C2-J
Approval gate -> C2-O
Error logging/retry queue -> C6-G
Dashboard/status table -> C5-W
Version

v1.0

Last Tested

2026-05-25

## Relationship to Email Send Adapters

C2-I is a notification orchestration component, not the universal email-send adapter.

C2-I decides whether a notification should be sent, prepares the notification subject/body from upstream automation output, blocks failed/non-requested notifications, and then sends through a configured provider execution layer.

Provider execution adapters include:

- ADP-SMTP-SEND - universal SMTP send fallback
- ADP-GMAIL-SEND - Gmail send adapter
- ADP-OUTLOOK-SEND - Outlook/M365 send adapter

The existing C2-I1 workflow uses n8n Send Email with SMTP credentials and remains valid as the built email-notification implementation. ADP-SMTP-SEND is separately built as a lower-level reusable SMTP adapter for arbitrary standardized email-send requests.

