# CFG-004 - AI Profile Compatibility Pack

## Purpose

This document maps the master `CFG-001.ai_profile` into the existing `client_ai_profile` structures expected by C4 AI components.

CFG-004 does not create a new AI profile system.

It upgrades and standardizes the existing C4 client AI profile approach.

---

# 1. Source of Truth

The source of truth is:

```text
CFG-001 Client Profile Schema
→ ai_profile
The master AI profile contains:

ai_profile.voice
ai_profile.business_context
ai_profile.output_rules
ai_profile.risk_boundaries
ai_profile.examples

C4 components consume this through their runtime-specific object:

config.client_ai_profile
2. Compatibility Rule

Every C4 component should receive a client_ai_profile object assembled from:

CFG-001.client_identity
CFG-001.business_context
CFG-001.approval_rules
CFG-001.ai_profile
CFG-001.data_rules
CFG-002 workflow discovery response
CFG-003 tool stack response

The Assembly Engine or Template Config Generator should transform the master profile into the specific shape needed by each C4 component.

3. C4-A Compatibility — AI Classification Pipeline
Existing C4-A expected fields
client_ai_profile.client_profile
client_ai_profile.classification_rules.categories
client_ai_profile.classification_rules.priority_rules
client_ai_profile.classification_rules.routing_rules
client_ai_profile.classification_rules.manual_review_triggers
client_ai_profile.risk_boundaries.manual_review_triggers
client_ai_profile.approval_rules
Mapping
C4-A field    Source
client_profile    client_identity + business_context
classification_rules.categories    CFG-002 classification targets / template defaults
classification_rules.priority_rules    CFG-002 decision rules + workflow preferences
classification_rules.routing_rules    CFG-002 processing logic + output actions
classification_rules.manual_review_triggers    CFG-001 workflow preferences + CFG-002 error/manual-review triggers
risk_boundaries.manual_review_triggers    CFG-001.ai_profile.risk_boundaries + CFG-002 AI restrictions
approval_rules    CFG-001.approval_rules
Example assembled object
{
  "client_profile": {},
  "classification_rules": {
    "categories": ["qualified_lead", "support_request", "spam", "manual_review"],
    "priority_rules": {
      "high": ["urgent timeline", "high budget", "existing tool stack fit"],
      "medium": ["clear need but missing urgency"],
      "low": ["unclear fit", "low intent"]
    },
    "routing_rules": {
      "qualified_lead": "qualify_lead",
      "support_request": "route_to_support",
      "spam": "do_not_contact",
      "manual_review": "manual_review"
    },
    "manual_review_triggers": [
      "missing required field",
      "unclear intent",
      "low confidence",
      "sensitive topic"
    ]
  },
  "risk_boundaries": {
    "manual_review_triggers": ["legal claim", "payment dispute", "health data"]
  },
  "approval_rules": {}
}
4. C4-B Compatibility — AI Extraction Parser
Existing C4-B expected fields
client_ai_profile.client_profile
client_ai_profile.extraction_rules.required_fields
client_ai_profile.extraction_rules.optional_fields
client_ai_profile.extraction_rules.missing_required_field_action
client_ai_profile.extraction_rules.allow_inference
client_ai_profile.extraction_rules.never_infer_fields
client_ai_profile.extraction_rules.low_confidence_action
client_ai_profile.extraction_rules.manual_review_confidence_threshold
client_ai_profile.risk_boundaries.manual_review_triggers
client_ai_profile.approval_rules
Mapping
C4-B field    Source
client_profile    client_identity + business_context
extraction_rules.required_fields    CFG-001.data_rules.required_fields + CFG-002 required fields
extraction_rules.optional_fields    CFG-002 optional fields
extraction_rules.missing_required_field_action    CFG-001.data_rules.missing_required_field_action
extraction_rules.allow_inference    CFG-001.ai_profile.risk_boundaries.allow_inference
extraction_rules.never_infer_fields    CFG-001.data_rules.never_infer_fields + CFG-001.ai_profile.risk_boundaries.never_infer_fields
extraction_rules.low_confidence_action    CFG-001.workflow_preferences.default_failure_action / manual review default
extraction_rules.manual_review_confidence_threshold    CFG-001.ai_profile.risk_boundaries.manual_review_confidence_threshold
risk_boundaries.manual_review_triggers    CFG-002 manual review triggers + CFG-001.ai_profile.risk_boundaries.sensitive_topics
approval_rules    CFG-001.approval_rules
5. C4-D Compatibility — AI Content Generation Pipeline
Existing C4-D expected fields
client_ai_profile.client_profile
client_ai_profile.voice_profile
client_ai_profile.offer_profile
client_ai_profile.content_rules.enabled_content_types
client_ai_profile.content_rules.preferred_tone
client_ai_profile.content_rules.preferred_length
client_ai_profile.content_rules.preferred_structure
client_ai_profile.content_rules.topics_allowed
client_ai_profile.content_rules.topics_avoided
client_ai_profile.content_rules.cta_style
client_ai_profile.content_rules.external_claims_allowed
client_ai_profile.content_rules.approval_required
client_ai_profile.content_rules.platform_rules
client_ai_profile.risk_boundaries.forbidden_claims
client_ai_profile.risk_boundaries.manual_review_triggers
client_ai_profile.approval_rules
Mapping
C4-D field    Source
voice_profile    CFG-001.ai_profile.voice
offer_profile    CFG-001.business_context + CFG-001.ai_profile.business_context
content_rules.enabled_content_types    CFG-002 publishing/content requirements + template defaults
content_rules.preferred_tone    CFG-001.ai_profile.voice.tone
content_rules.preferred_length    CFG-001.ai_profile.voice.format_preferences
content_rules.preferred_structure    CFG-001.ai_profile.output_rules.default_output_format
content_rules.topics_allowed    CFG-001.ai_profile.output_rules.must_include
content_rules.topics_avoided    CFG-001.ai_profile.output_rules.must_avoid
content_rules.cta_style    CFG-001.ai_profile.output_rules.preferred_cta
content_rules.external_claims_allowed    inverse of forbidden/high-risk claims policy
content_rules.approval_required    CFG-001.approval_rules.publishing.required
risk_boundaries.forbidden_claims    CFG-001.ai_profile.output_rules.forbidden_claims
risk_boundaries.manual_review_triggers    CFG-001.ai_profile.risk_boundaries.sensitive_topics
approval_rules    CFG-001.approval_rules
6. C4-E Compatibility — AI Email Draft Generator
Existing C4-E expected fields
client_ai_profile.client_profile
client_ai_profile.audience_profile
client_ai_profile.voice_profile
client_ai_profile.offer_profile
client_ai_profile.email_rules
client_ai_profile.risk_boundaries
client_ai_profile.approval_rules
Mapping
C4-E field    Source
client_profile    CFG-001.client_identity + CFG-001.business_context
audience_profile    CFG-001.business_context.target_customers + CFG-001.ai_profile.business_context.target_customer
voice_profile    CFG-001.ai_profile.voice
offer_profile    CFG-001.business_context.offer + CFG-001.ai_profile.business_context.offer
email_rules.preferred_cta    CFG-001.ai_profile.output_rules.preferred_cta
email_rules.must_include    CFG-001.ai_profile.output_rules.must_include
email_rules.must_avoid    CFG-001.ai_profile.output_rules.must_avoid
email_rules.forbidden_claims    CFG-001.ai_profile.output_rules.forbidden_claims
risk_boundaries    CFG-001.ai_profile.risk_boundaries
approval_rules    CFG-001.approval_rules.email_drafts
7. C4-L Compatibility — Lead Qualification Pipeline
Existing C4-L expected fields
client_ai_profile.client_profile
client_ai_profile.audience_profile
client_ai_profile.lead_qualification_rules
client_ai_profile.risk_boundaries
client_ai_profile.approval_rules
Mapping
C4-L field    Source
client_profile    CFG-001.client_identity + CFG-001.business_context
audience_profile    CFG-001.business_context.target_customers + CFG-001.ai_profile.business_context.target_customer
lead_qualification_rules    CFG-002 scoring/qualification rules + workflow decision rules
risk_boundaries    CFG-001.ai_profile.risk_boundaries
approval_rules    CFG-001.approval_rules.ai_outputs
8. C4-M Compatibility — AI Draft Approval Pipeline
Expected role

C4-M packages completed AI draft outputs for human review.

It should receive approval-facing metadata from:

CFG-001.approval_rules
CFG-001.ai_profile.risk_boundaries
C4-D/C4-E draft output
C5-W status tracking requirements
Mapping
C4-M input    Source
reviewer_role    CFG-001.approval_rules.*.approver_role
reviewer_email    CFG-001.approval_rules.*.approver_email
approval_required    CFG-001.approval_rules.*.required
allowed_actions    CFG-001.approval_rules.*.allowed_actions
risk_flags    upstream C4 output + CFG-001.ai_profile.risk_boundaries
manual_review_reason    C4 output + C6-G/C5-E fallback
status_tracking_required    CFG-001.workflow_preferences.status_tracking_required
9. Client-Facing Intake Mapping

CFG-004A client-facing answers should populate:

CFG-001.ai_profile.voice
CFG-001.ai_profile.business_context
CFG-001.ai_profile.output_rules
CFG-001.ai_profile.risk_boundaries
CFG-001.ai_profile.examples

The Assembly Engine then transforms those into C4-specific client_ai_profile blocks.

10. Do Not Break Existing C4 Contracts

Until the C4 workflows are formally upgraded, preserve these runtime keys:

client_ai_profile
voice_profile
offer_profile
audience_profile
classification_rules
extraction_rules
content_rules
email_rules
lead_qualification_rules
risk_boundaries
approval_rules

Do not rename runtime keys inside C4 workflows without a separate migration.

11. Future Upgrade Path

Later, we can add:

client-config/schemas/ai-profile-schema.json
client-config/generators/ai-profile-to-c4-profile-mapper/

But for now:

CFG-001.ai_profile is the master profile.
CFG-004 defines compatibility mapping.
CFG-004A collects client-facing AI customization inputs.
C4 runtime contracts remain stable.

