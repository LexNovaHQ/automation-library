# C4 Client AI Customization Questionnaire

## Purpose

This questionnaire captures the client-specific configuration required for C4 AI workflow components.

It is used to configure AI components such as:

- C4-E - AI Email Draft Generator
- C4-D - AI Content Generation Pipeline
- C4-A - AI Classification Pipeline
- C4-B - AI Extraction Parser
- C4-L - Lead Qualification Pipeline

The goal is not to create a generic AI writer. The goal is to create a client-controlled AI drafting and classification system that follows the client's offer, voice, audience, risk boundaries, and approval rules.

---

# Operating Rule

All AI outputs are drafts or structured objects unless explicitly approved.

AI components must not:

- send emails automatically
- publish content automatically
- update CRM records without workflow approval
- make final business decisions
- invent facts about the client, lead, offer, pricing, case studies, guarantees, or outcomes

Human approval is required before sending, publishing, or executing high-risk actions.

---

# Section 1 - Client Profile

## 1.1 Basic business information

1. Business name:
2. Website:
3. Industry:
4. Business type:
5. Location / primary market:
6. Target geography:
7. Primary customer type:
8. Sales motion:
   - inbound
   - outbound
   - referral
   - ads
   - marketplace
   - other

## 1.2 What does the business sell?

1. Main offer:
2. Secondary offers:
3. One-line explanation of the business:
4. What problem do customers come to you with?
5. What result do you help customers achieve?
6. What is the usual price range or deal size, if relevant?
7. What is the usual buying trigger?
8. What makes a customer ready to buy?

## 1.3 Positioning

1. How do you want customers to describe you?
2. What makes you different from competitors?
3. What should the AI never say about your business?
4. Are there any claims you cannot legally or commercially make?
5. Are there any industries, customer types, or use cases you do not serve?

---

# Section 2 - Audience / ICP Profile

## 2.1 Ideal customer

1. Who is your ideal customer?
2. What job title or role usually buys from you?
3. What company size do you prefer?
4. What industries are best fit?
5. What regions are best fit?
6. What tools/platforms do your customers usually use?
7. What budget level is a good fit?
8. What urgency signs indicate a high-intent lead?

## 2.2 Bad-fit customer

1. Who is not a good fit?
2. What signs suggest the lead is low quality?
3. What signs suggest the lead is not ready?
4. What budget, timeline, or requirement should trigger rejection or manual review?
5. Are there any customers you do not want to work with?

## 2.3 Common pain points

List the top pain points your ideal customers usually have.

1. Pain point 1:
2. Pain point 2:
3. Pain point 3:
4. Pain point 4:
5. Pain point 5:

## 2.4 Common objections

List the most common objections leads raise.

1. Objection 1:
2. Objection 2:
3. Objection 3:
4. Objection 4:
5. Objection 5:

---

# Section 3 - Voice Profile

## 3.1 Tone

Select preferred tone:

- clear
- helpful
- direct
- warm
- formal
- casual
- premium
- technical
- consultative
- friendly
- no-nonsense
- other:

## 3.2 Writing style

1. Preferred sentence length:
   - short
   - medium
   - long
2. Paragraph style:
   - short paragraphs
   - detailed paragraphs
   - bullet-heavy
   - minimal bullets
3. Reading level:
   - simple business English
   - technical
   - executive
   - casual
4. Should the AI use humor?
5. Should the AI use emojis?
6. Should the AI use contractions like "we're" and "you'll"?
7. Should the AI sound more like a person or a company?

## 3.3 Words and phrases

Words/phrases to use:

1.
2.
3.
4.
5.

Words/phrases to avoid:

1.
2.
3.
4.
5.

Banned claims or phrases:

1.
2.
3.
4.
5.

---

# Section 4 - Offer Profile

## 4.1 Core offer

1. Offer name:
2. Who is it for?
3. What does it include?
4. What does it not include?
5. What outcome does it create?
6. What is the usual timeline?
7. What is the usual price or pricing model?
8. What proof points can be mentioned?
9. What proof points must not be mentioned?
10. What are the main objections?

## 4.2 Offer language

How should the AI describe the offer in one sentence?

Answer:

How should the AI describe the offer in 2-3 sentences?

Answer:

What should the AI avoid saying about the offer?

Answer:

---

# Section 5 - Email Drafting Rules

This section configures C4-E - AI Email Draft Generator.

## 5.1 Email types needed

Select all required email types:

- first response to inbound lead
- cold outreach email
- follow-up email
- meeting confirmation
- proposal follow-up
- abandoned checkout follow-up
- reactivation email
- support response
- approval request email
- other:

## 5.2 Standard email rules

1. Default max word count:
2. Preferred CTA:
3. Should emails include a question at the end?
4. Should emails mention pricing?
5. Should emails include scheduling links?
6. Should emails mention case studies?
7. Should emails mention urgency?
8. Should emails be plain text or formatted?
9. Should emails be signed by a person or brand?
10. Standard sign-off:

## 5.3 Personalization rules

What can the AI use for personalization?

- lead name
- company name
- role/title
- lead source
- form message
- website/domain
- product interest
- industry
- pain point
- prior interaction
- CRM status
- other:

What should the AI never pretend to know?

Answer:

## 5.4 Email must include

List items the AI should include when relevant.

1.
2.
3.
4.
5.

## 5.5 Email must avoid

List items the AI should avoid.

1.
2.
3.
4.
5.

---

# Section 6 - Content Generation Rules

This section configures C4-D - AI Content Generation Pipeline.

## 6.1 Content types

Select required content types:

- blog draft
- LinkedIn post
- Facebook post
- TikTok caption
- video script
- newsletter
- ad copy
- landing page section
- product description
- other:

## 6.2 Content style

1. Preferred content tone:
2. Preferred content length:
3. Preferred structure:
4. Topics to write about:
5. Topics to avoid:
6. CTA style:
7. Should the AI use examples?
8. Should the AI use statistics?
9. Are external claims allowed?
10. Does every draft need approval?

## 6.3 Platform rules

LinkedIn rules:

Facebook rules:

TikTok rules:

Blog rules:

Ad copy rules:

---

# Section 7 - Classification Rules

This section configures C4-A - AI Classification Pipeline.

## 7.1 Classification categories

List the labels/categories the AI should classify records into.

Example:

- hot lead
- warm lead
- cold lead
- support request
- spam
- partnership
- existing customer
- manual review

Client categories:

1.
2.
3.
4.
5.
6.
7.
8.

## 7.2 Priority rules

What makes something high priority?

1.
2.
3.

What makes something medium priority?

1.
2.
3.

What makes something low priority?

1.
2.
3.

## 7.3 Routing rules

If category is high priority, next action should be:

If category is support request, next action should be:

If category is spam/bad fit, next action should be:

If category is unclear, next action should be:

---

# Section 8 - Extraction Rules

This section configures C4-B - AI Extraction Parser.

## 8.1 Fields to extract

List fields the AI should extract from text, emails, forms, documents, or transcripts.

Required fields:

1.
2.
3.
4.
5.

Optional fields:

1.
2.
3.
4.
5.

## 8.2 Extraction behavior

1. What should happen if a required field is missing?
2. Should the AI infer missing fields?
3. Which fields must never be inferred?
4. Should low-confidence extraction go to manual review?
5. What confidence threshold should trigger manual review?

---

# Section 9 - Lead Qualification Rules

This section configures C4-L - Lead Qualification Pipeline.

## 9.1 Qualification criteria

What makes a lead qualified?

1.
2.
3.
4.
5.

What makes a lead unqualified?

1.
2.
3.
4.
5.

## 9.2 Score rules

High score signals:

1.
2.
3.

Medium score signals:

1.
2.
3.

Low score signals:

1.
2.
3.

Automatic disqualifiers:

1.
2.
3.

Manual review triggers:

1.
2.
3.

---

# Section 10 - Examples

Examples are used to teach the AI style and boundaries.

## 10.1 Good examples

Provide 2-3 examples of good emails, posts, or responses.

Good example 1:

Good example 2:

Good example 3:

## 10.2 Bad examples

Provide 2-3 examples of outputs that are wrong, off-brand, risky, too salesy, or too generic.

Bad example 1:

Bad example 2:

Bad example 3:

## 10.3 Preferred phrases

Phrases you like:

1.
2.
3.
4.
5.

Phrases you dislike:

1.
2.
3.
4.
5.

---

# Section 11 - Risk Boundaries

## 11.1 Claims and compliance

1. Are there claims the AI must never make?
2. Are there regulated topics involved?
3. Are there legal, financial, health, or compliance-sensitive statements to avoid?
4. Are guarantees allowed?
5. Are revenue, ROI, or performance claims allowed?
6. Are testimonials/case studies allowed?
7. Are competitor comparisons allowed?
8. Are discounts/promotions allowed?
9. Are deadlines/urgency claims allowed?
10. Are refunds/cancellations allowed to be discussed?

## 11.2 Manual review triggers

AI output must go to manual review if it includes:

- pricing
- legal/compliance claims
- performance guarantees
- refund/cancellation language
- competitor comparisons
- negative statements about customer/client
- medical/financial/legal advice
- uncertain facts
- missing required context
- other:

---

# Section 12 - Approval Rules

## 12.1 Approval requirement

Default approval policy:

- AI output always requires approval
- Only high-risk outputs require approval
- Only outbound emails require approval
- Only publishing requires approval
- Other:

Recommended default:

AI output always requires approval before sending, publishing, or executing external actions.

## 12.2 Reviewer

1. Primary reviewer name:
2. Primary reviewer email:
3. Backup reviewer name:
4. Backup reviewer email:
5. Approval SLA:
6. What happens if approval is delayed?

## 12.3 Allowed approval actions

Allowed actions:

- approve
- reject
- revise
- request clarification
- escalate

Custom approval actions:

1.
2.
3.

---

# Section 13 - Final Configuration Notes

Anything else the AI system should know?

Answer:

Any special workflows?

Answer:

Any tools/platforms the AI output must integrate with?

Answer:

Any hard constraints?

Answer:

---

# Deliverable Created From This Questionnaire

The answers should be converted into a `client_ai_profile` object containing:

- client_profile
- audience_profile
- voice_profile
- offer_profile
- email_rules
- content_rules
- classification_rules
- extraction_rules
- lead_qualification_rules
- examples
- risk_boundaries
- approval_rules

This profile is then passed into C4 components as config.
