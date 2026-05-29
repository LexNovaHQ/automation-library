# ADP-SLACK-SEND - Slack Send Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-TEAM-NOTIFY - Team Notifications

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Sends standardized workflow notifications into Slack channels or users.

## Why This Exists
ADP-SLACK-SEND is the first high-ROI platform adapter in the Team Notifications family. Slack is a common destination for alerts, approvals, status updates, error notifications, lead notifications, and daily workflow digests.

## Provider Rule
Use Slack app credentials or bot token through n8n Slack node. Do not hardcode webhook URLs, bot tokens, channel IDs, or secrets in workflow JSON.

## Credential Rule
Credentials are added manually by the user inside n8n. No real Slack bot token, webhook URL, signing secret, client secret, workspace ID, or channel ID is embedded in the workflow JSON.

## n8n Import Note
Slack credentials and channel selection must be configured manually in n8n after import. If a Switch node is used, fallback/extra output must be confirmed manually in n8n.

## Supported v1 Operations
- Send plain Slack message to configured channel
- Send structured alert text from standardized input
- Include priority/status/source component/request ID
- Optional thread timestamp passthrough if supported/configured
- Safe validation failure output
- Safe provider failure output

## Not Included in v1
- Slack slash commands
- Interactive buttons/modals
- File uploads
- Channel creation
- User lookup
- OAuth app creation automation
- Incoming webhook-only variant

## Input Contract

`json
{
  "request_id": "req_slack_send_001",
  "source_component": "C2-I",
  "slack": {
    "channel": "#alerts",
    "message": "Workflow completed successfully.",
    "title": "Automation Alert",
    "priority": "normal",
    "thread_ts": null
  },
  "routing_options": {
    "on_success": "log_status",
    "on_failure": "manual_review"
  },
  "metadata": {
    "environment": "n8n-test"
  }
}
`",
",


`json
{
  "adapter_status": "success",
  "component_id": "ADP-SLACK-SEND",
  "component_version": "v1",
  "request_id": "req_slack_send_001",
  "provider": "slack",
  "operation": "send_message",
  "validation_status": "valid",
  "channel": "#alerts",
  "message_ts": "provider_message_ts_or_null",
  "manual_review_required": false,
  "error_code": null,
  "error_message": null,
  "next_action": "log_status",
  "downstream_components": ["C5-W"],
  "source_result": {}
}
`",
",

- send-basic.valid.json
- send-alert.valid.json
- send-priority-error.valid.json
- missing-channel.invalid.json
- missing-message.invalid.json
- invalid-priority.invalid.json

## Version
v1.0 draft
