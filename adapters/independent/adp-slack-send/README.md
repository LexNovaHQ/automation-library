# ADP-SLACK-SEND - Slack Send Adapter

## Status
Built v1.0.

## Primary Category
Category 2 - Automation Workflows

## Adapter Family
FAM-C2-TEAM-NOTIFY - Team Notifications

## Layer Type
INDEPENDENT_ADAPTER

## Purpose
Sends standardized workflow notifications into Slack channels.

## Why This Exists
ADP-SLACK-SEND is the first high-ROI platform adapter in the Team Notifications family. Slack is a common destination for alerts, approvals, status updates, error notifications, lead notifications, and daily workflow digests.

## Provider Rule
Use Slack app credentials or bot token through the n8n Slack node. Do not hardcode webhook URLs, bot tokens, channel IDs, or secrets in workflow JSON.

## Credential Rule
Credentials are added manually by the user inside n8n. No real Slack bot token, webhook URL, signing secret, client secret, workspace ID, or channel ID is embedded in the workflow JSON.

## Platform Setup Required
Create a Slack app, add bot token scopes such as chat:write and channels:read, install the app to the workspace, copy the bot token into n8n credentials, and invite the bot/app to the target channel before testing.

## n8n Import Note
Slack credentials and channel selection must be configured manually in n8n after import. Confirm that Validation Switch fallback/extra output is connected to Return Slack Send Result.

## Slack Channel Membership Note
If Slack returns not_in_channel, invite the bot/app into the target channel or use a channel ID that the bot can access.

## Supported v1 Operations
- Send plain Slack message to configured channel
- Send structured alert text from standardized input
- Include priority/status/source component/request ID
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
- Thread replies unless manually configured with thread_ts support

## Workflow Artifact
- workflows/adp-slack-send-adapter-v1.json

## Test Payloads
- send-basic.valid.json
- send-alert.valid.json
- send-priority-error.valid.json
- missing-channel.invalid.json
- missing-message.invalid.json
- invalid-priority.invalid.json

## Output Samples
- success-basic-message.json
- success-high-priority-alert.json
- success-critical-manual-review.json
- error-missing-channel.json
- error-missing-message.json
- error-invalid-priority.json
- error-provider-not-in-channel.json

## Tested
- Invalid validation tests passed.
- Basic Slack send test passed.
- High-priority alert send test passed.
- Critical/manual-review send test passed.
- Slack not_in_channel provider failure identified and handled safely.
- Bot/app channel membership confirmed during testing.

## Version
v1.0
