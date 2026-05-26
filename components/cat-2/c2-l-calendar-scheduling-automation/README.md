# C2-L - Calendar / Scheduling Automation

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Prepares provider-agnostic scheduling handoffs for booking links, calendar event creation, manual scheduling, and scheduling-related messages.

C2-L v1 does not directly send messages, book meetings, create Google Calendar events, or call Calendly/Cal.com APIs. It prepares structured scheduling objects and downstream handoffs.

## Architecture
C2-L contains one n8n workflow:

1. `C2-L_CORE_Calendar_Scheduling_Automation_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `prepare_scheduling`.
   - Requires provider, mode, meeting type, and meeting title.
   - Supports provider-agnostic scheduling modes.
   - Supports Calendly booking link handoff.
   - Supports Cal.com booking link handoff.
   - Supports Google Calendar event creation handoff.
   - Supports manual scheduling review handoff.
   - Creates C4-E message handoff when booking-link scheduling requires a scheduling message.
   - Creates calendar adapter handoff for Google Calendar event creation.
   - Creates C5-E manual review handoff for manual scheduling.

## Workflow Files
- `workflows/c2-l-core-calendar-scheduling-automation-v1.json`

## Tool Bindings
- n8n
- Execute Sub-workflow Trigger
- Code node
- Edit Fields / Set node

## Input Contract

```json
{
  "input": {
    "success": true,
    "component_id": "",
    "component_version": "",
    "event_id": "",
    "event_type": "",
    "payload": {
      "name": "",
      "email": "",
      "company": "",
      "message": ""
    },
    "lead_qualification": {},
    "approved_action": {},
    "metadata": {},
    "error": null,
    "next_action": "prepare_scheduling"
  },
  "config": {
    "provider": "calendly",
    "mode": "booking_link",
    "meeting_type": "discovery_call",
    "meeting_title": "Discovery call",
    "duration_minutes": 30,
    "timezone": "Asia/Kolkata",
    "booking_url": "",
    "event_time": {
      "start_time": "",
      "end_time": ""
    },
    "calendar": {
      "calendar_id": "primary",
      "add_google_meet": true,
      "reminders": {
        "use_default": true
      }
    },
    "scheduling_goal": "",
    "message_policy": {
      "create_message_handoff": true,
      "message_type": "scheduling_email",
      "approval_required": true
    },
    "default_next_action": "send_scheduling_message_for_approval"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-L",
  "component_version": "v1",
  "event_id": "",
  "event_type": "",
  "scheduling": {
    "provider": "calendly",
    "mode": "booking_link",
    "status": "ready",
    "meeting_type": "discovery_call",
    "meeting_title": "Discovery call",
    "duration_minutes": 30,
    "timezone": "Asia/Kolkata",
    "booking_url": "",
    "attendee": {
      "name": "",
      "email": "",
      "company": ""
    },
    "scheduling_goal": "",
    "manual_review_required": false,
    "prepared_at": ""
  },
  "calendar_event_handoff": {
    "next_component": "google_calendar_adapter",
    "input": {},
    "config": {}
  },
  "message_handoff": {
    "next_component": "C4-E",
    "input": {},
    "config": {}
  },
  "manual_review_handoff": {
    "next_component": "C5-E",
    "input": {},
    "config": {}
  },
  "source_result": {},
  "error": null,
  "next_action": "send_scheduling_message_for_approval"
}
Providers Supported in v1
calendly
cal_com
google_calendar
manual
Modes Supported in v1
booking_link
event_handoff
manual_scheduling
Provider / Mode Rules
Provider    Supported Mode    Output
calendly    booking_link    booking-link scheduling object + optional C4-E message handoff
cal_com    booking_link    booking-link scheduling object + optional C4-E message handoff
google_calendar    event_handoff    Google Calendar adapter handoff
manual    manual_scheduling    C5-E manual review handoff
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
SCHEDULING_NOT_REQUESTED
MISSING_PROVIDER
MISSING_MODE
MISSING_MEETING_TYPE
MISSING_MEETING_TITLE
UNSUPPORTED_PROVIDER
UNSUPPORTED_MODE
INVALID_PROVIDER_MODE
MISSING_BOOKING_URL
MISSING_EVENT_TIME
MISSING_ATTENDEE_EMAIL
Test Payloads
test-payloads/calendly-link.valid.json
test-payloads/cal-com-link.valid.json
test-payloads/google-calendar-event.valid.json
test-payloads/manual-scheduling.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/scheduling-not-requested.invalid.json
test-payloads/missing-provider.invalid.json
test-payloads/missing-booking-url.invalid.json
test-payloads/missing-event-time.invalid.json
Output Samples
output-samples/success-calendly-link.json
output-samples/success-cal-com-link.json
output-samples/success-google-calendar-event.json
output-samples/success-manual-scheduling.json
output-samples/error-upstream-action-failed.json
output-samples/error-scheduling-not-requested.json
output-samples/error-missing-provider.json
output-samples/error-missing-booking-url.json
output-samples/error-missing-event-time.json
Passed Tests
Calendly link
Cal.com link
Google Calendar event
Manual scheduling
Upstream failed
Scheduling not requested
Missing provider
Missing booking URL
Missing event time
80/20 Interoperability Rule

The reusable 80% layer is the scheduling preparation engine: input validation, provider/mode validation, booking link handling, event handoff creation, scheduling message handoff creation, manual review handoff creation, and metadata preservation. The configurable 20% layer is provider, mode, booking URL, meeting type, meeting title, duration, timezone, event time, calendar options, message policy, reviewer, and next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic scheduling handoff preparation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using routers, filters, calendar modules, email modules, and manual approval paths.

Zapier

Can be rebuilt using Paths, Calendar actions, Email actions, and approval/manual review steps.

Not Included

These are intentionally excluded from C2-L v1 and belong to other components/adapters:

Email draft generation -> C4-E
Draft approval packaging -> C4-M
Human approval request -> C2-O
Approval response capture -> C2-O2
Actual Google Calendar event creation -> future Google Calendar adapter
Calendly webhook intake -> C2-C + future Calendly adapter/runtime
Cal.com webhook/API booking -> future Cal.com adapter/runtime
Notifications -> C2-I
Status tracking -> C5-W
Error logging -> C6-G
Version

v1.0

Last Tested

2026-05-25
