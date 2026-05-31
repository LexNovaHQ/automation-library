# ADP-TEAMS-SEND - Microsoft Teams Send Adapter

## Status
Phase 1 scaffold and test payloads.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-TEAM-NOTIFY - Team Notifications

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Sends standardized workflow notifications into Microsoft Teams channels.

## Why This Exists
ADP-TEAMS-SEND is the second high-ROI platform adapter in the Team Notifications family. It covers Microsoft-heavy clients where Teams is the default destination for alerts, approvals, workflow status updates, lead notifications, and error notifications.

## Provider Rule
Use Microsoft Teams/Microsoft Graph-compatible credentials or webhook configuration through n8n. Do not hardcode webhook URLs, tenant IDs, client secrets, channel IDs, team IDs, or tokens in workflow JSON.

## Credential Rule
Credentials are added manually by the user inside n8n. No real Microsoft tenant ID, client ID, client secret, Teams webhook URL, team ID, channel ID, or token is embedded in workflow JSON.

## n8n Import Note
Teams credentials, team/channel selection, or webhook destination must be configured manually in n8n after import. If a Switch node is used, fallback/extra output must be confirmed manually in n8n.

## Supported v1 Operations
- Send plain Teams message to configured channel
- Send structured alert text from standardized input
- Include priority/status/source component/request ID
- Safe validation failure output
- Safe provider failure output

## Not Included in v1
- Teams slash commands
- Interactive cards/actions
- File uploads
- Team/channel creation
- User lookup
- OAuth app creation automation
- Chat/DM support
- Adaptive Card v2 formatting

## Input Contract

`json
{
  "request_id": "req_teams_send_001",
  "source_component": "C2-I",
  "teams": {
    "team": "Automation Team",
    "channel": "Alerts",
    "message": "Workflow completed successfully.",
    "title": "Automation Alert",
    "priority": "normal"
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
  "component_id": "ADP-TEAMS-SEND",
  "component_version": "v1",
  "request_id": "req_teams_send_001",
  "provider": "microsoft_teams",
  "operation": "send_message",
  "validation_status": "valid",
  "team": "Automation Team",
  "channel": "Alerts",
  "message_id": "provider_message_id_or_null",
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
