# C2-Q - Publishing Adapter Family

## Status
Built v1.0

## Category
C2 - Automation Workflows

## Purpose
Prepares platform-agnostic publishing handoffs for approved content drafts across LinkedIn, WordPress, Webflow, X/Twitter, and manual publishing workflows.

C2-Q v1 does not directly publish content. It prepares structured publishing request objects and downstream platform/manual handoff objects.

## Architecture
C2-Q contains one n8n workflow:

1. `C2-Q_CORE_Publishing_Adapter_Family_v1`
   - Triggered by another workflow.
   - Accepts `{ input, config }`.
   - Refuses failed upstream outputs.
   - Refuses requests where `next_action` is not `prepare_publish`.
   - Requires platform, mode, and publish type.
   - Requires content body.
   - Supports approval-required gating.
   - Supports allowed platform gating.
   - Supports allowed publish type gating.
   - Prevents direct publishing in v1.
   - Supports LinkedIn publishing handoff.
   - Supports WordPress publishing handoff.
   - Supports Webflow publishing handoff.
   - Supports X/Twitter publishing handoff.
   - Supports manual publishing review handoff.
   - Does not call platform APIs directly.

## Workflow Files
- `workflows/c2-q-core-publishing-adapter-family-v1.json`

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
    "event_type": "approved_content",
    "payload": {
      "title": "",
      "body": "",
      "content_type": "",
      "platform": "",
      "slug": "",
      "excerpt": "",
      "summary": "",
      "tags": [],
      "cta": ""
    },
    "approved_action": {
      "approved": true,
      "action": "prepare_publish"
    },
    "metadata": {},
    "error": null,
    "next_action": "prepare_publish"
  },
  "config": {
    "platform": "linkedin",
    "mode": "platform_handoff",
    "publish_type": "social_post",
    "requires_approval": true,
    "approval_status_required": true,
    "allowed_platforms": [],
    "allowed_publish_types": [],
    "publishing_rules": {
      "allow_direct_publish": false,
      "default_status": "draft_ready",
      "require_human_publish_review": true,
      "max_character_count": 280
    },
    "linkedin": {},
    "wordpress": {},
    "webflow": {},
    "reviewer_email": "",
    "default_next_action": "create_publish_handoff"
  }
}
Output Contract
{
  "success": true,
  "component_id": "C2-Q",
  "component_version": "v1",
  "event_id": "",
  "event_type": "approved_content",
  "publish_request": {
    "platform": "",
    "mode": "",
    "status": "",
    "publish_type": "",
    "content_type": "",
    "title": "",
    "body": "",
    "slug": "",
    "excerpt": "",
    "tags": [],
    "cta": "",
    "source_platform": "",
    "requires_approval": true,
    "approval_status_required": true,
    "human_publish_review_required": true,
    "prepared_at": ""
  },
  "platform_handoff": {
    "next_component": "",
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
  "next_action": "create_publish_handoff"
}
Platforms Supported in v1
linkedin
wordpress
webflow
x_twitter
manual
Modes Supported in v1
platform_handoff
manual_publish_handoff
Publish Types Supported in v1
social_post
blog_post
cms_page
short_post
manual_publish
Platform / Mode Rules
Platform    Supported Mode    Output
linkedin    platform_handoff    LinkedIn publishing adapter handoff
wordpress    platform_handoff    WordPress publishing adapter handoff
webflow    platform_handoff    Webflow publishing adapter handoff
x_twitter    platform_handoff    X/Twitter publishing adapter handoff
manual    manual_publish_handoff    C5-E manual publishing review handoff
Failure States Covered in v1
EMPTY_INPUT
MISSING_INPUT_OBJECT
UPSTREAM_ACTION_FAILED
PUBLISHING_NOT_REQUESTED
MISSING_PLATFORM
MISSING_MODE
MISSING_PUBLISH_TYPE
UNSUPPORTED_PLATFORM
UNSUPPORTED_MODE
UNSUPPORTED_PUBLISH_TYPE
PLATFORM_NOT_ALLOWED
PUBLISH_TYPE_NOT_ALLOWED
PUBLISH_NOT_APPROVED
MISSING_BODY
INVALID_PLATFORM_MODE
DIRECT_PUBLISH_NOT_ALLOWED_IN_V1
BODY_EXCEEDS_CHARACTER_LIMIT
Test Payloads
test-payloads/linkedin-post.valid.json
test-payloads/wordpress-blog.valid.json
test-payloads/webflow-cms.valid.json
test-payloads/x-twitter-post.valid.json
test-payloads/manual-publish.valid.json
test-payloads/upstream-failed.invalid.json
test-payloads/publishing-not-requested.invalid.json
test-payloads/missing-platform.invalid.json
test-payloads/missing-body.invalid.json
test-payloads/not-approved.invalid.json
test-payloads/platform-not-allowed.invalid.json
Output Samples
output-samples/success-linkedin-post.json
output-samples/success-wordpress-blog.json
output-samples/success-webflow-cms.json
output-samples/success-x-twitter-post.json
output-samples/success-manual-publish.json
output-samples/error-upstream-action-failed.json
output-samples/error-publishing-not-requested.json
output-samples/error-missing-platform.json
output-samples/error-missing-body.json
output-samples/error-not-approved.json
output-samples/error-platform-not-allowed.json
Passed Tests
LinkedIn post
WordPress blog
Webflow CMS
X/Twitter post
Manual publish
Upstream failed
Publishing not requested
Missing platform
Missing body
Not approved
Platform not allowed
80/20 Interoperability Rule

The reusable 80% layer is the publishing handoff engine: input validation, platform/mode validation, approval gating, body validation, allowed platform enforcement, publish type enforcement, direct-publish blocking, platform payload construction, platform handoff creation, and manual review handoff creation. The configurable 20% layer is platform, mode, publish type, platform-specific settings, character limits, publishing status, reviewer, and default next action.

Platform Implementation Notes
n8n

Canonical implementation uses a Code node for deterministic publishing handoff preparation and an Edit Fields / Set node for final output.

Make.com

Can be rebuilt using routers, filters, CMS/social modules, HTTP modules, and manual approval paths.

Zapier

Can be rebuilt using Paths, Webhooks, WordPress actions, social publishing actions, and manual review steps.

Not Included

These are intentionally excluded from C2-Q v1 and belong to other components/adapters:

AI content generation -> C4-D
Draft approval packaging -> C4-M
Human approval request -> C2-O
Approval response capture -> C2-O2
Actual LinkedIn publishing -> future LinkedIn publishing adapter
Actual WordPress post creation -> future WordPress adapter
Actual Webflow CMS creation -> future Webflow adapter
Actual X/Twitter publishing -> future X/Twitter adapter
Publish status tracking -> C5-W or future publish status component
Error logging -> C6-G
Version

v1.0

Last Tested

2026-05-26
