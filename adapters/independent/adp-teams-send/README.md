# ADP-TEAMS-SEND - Microsoft Teams Channel Message Adapter

**Status:** Implemented; local import and Microsoft Graph provider verification pending.

## Job
Send a human-readable message to a Microsoft Teams channel.

## Input
`request_id`, `team_id`, `channel_id`, `content`, optional `content_type` (`text|html`).

## Provider contract
Uses Microsoft Graph `POST /teams/{team-id}/channels/{channel-id}/messages`. Delegated work/school permission `ChannelMessage.Send` is the least-privileged permission documented for normal channel-message creation; personal Microsoft accounts are not supported for this operation.

## Boundary
Teams must not be used as a log sink. This adapter is for messages people are expected to read; machine error logs belong in C6-G and can optionally trigger a concise human alert.
