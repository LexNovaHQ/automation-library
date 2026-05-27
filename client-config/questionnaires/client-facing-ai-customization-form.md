# CFG-004A - Client-Facing AI Customization Form

## Purpose

This form captures how the client wants AI outputs to sound, behave, and stay within safe boundaries.

It is client-facing and intentionally avoids internal terms like:

- C4 components
- client_ai_profile
- prompt contract
- risk boundary object
- Assembly Engine

---

# 1. AI Use Cases

## 1.1 What should AI help with?

Choose any:

- classify incoming leads/messages
- extract details from emails/messages/documents
- qualify leads
- draft follow-up emails
- draft content
- summarize information
- detect urgency/risk
- prepare approval-ready drafts
- other

## 1.2 What should AI not do?

Choose any:

- send messages automatically
- make final business decisions
- change CRM records without approval
- create payment links without approval
- publish content automatically
- make legal/medical/financial claims
- infer missing contact details
- override opt-outs
- other

---

# 2. Voice and Tone

## 2.1 What tone should AI use?

Examples:

- clear and concise
- warm and helpful
- direct and practical
- premium and polished
- friendly and casual
- expert but simple
- formal and professional

## 2.2 What style should AI avoid?

Examples:

- hype
- pushy sales language
- long paragraphs
- jargon
- overpromising
- generic AI-sounding text
- emojis
- exaggerated claims

## 2.3 Reading level

Choose one:

- very simple
- simple business English
- professional
- technical
- executive-level

## 2.4 Formatting preferences

Choose any:

- short paragraphs
- bullet points
- numbered steps
- JSON/structured output
- short email format
- detailed explanation
- table format
- no emojis
- other

---

# 3. Business Context

## 3.1 What does your business offer?

Describe the product/service.

## 3.2 Who is your ideal customer?

Describe the target customer.

## 3.3 What problem do you solve?

List the main pain points.

## 3.4 How should AI position your offer?

Example:

```text
Practical automation partner for lean ecommerce teams.
3.5 What should AI never claim about your offer?

Examples:

guaranteed revenue
guaranteed results
legal advice
medical advice
financial advice
fully replaces your team
risk-free
no human review needed
4. Output Rules
4.1 Preferred CTA

What call-to-action should AI usually use?

Examples:

Book a quick call
Reply with your details
Review and approve this draft
Schedule a demo
Upload the missing file
Confirm if this looks correct
4.2 Must include

What should AI usually include?

Examples:

specific next step
client name/company when available
reason for qualification
relevant pain point
clear subject line
status summary
manual review reason
4.3 Must avoid

What should AI usually avoid?

Examples:

overpromising
fake personalization
unsupported claims
long intros
generic buzzwords
invented details
mentioning internal automation logic
4.4 Default output format

Choose one:

plain text
email draft
structured JSON
table
short summary
approval package
other
5. Risk and Approval Boundaries
5.1 Should AI outputs require approval before external use?
yes, always
yes, for some cases
no, not necessary
not sure
5.2 What should always trigger manual review?

Choose any:

low confidence
missing required field
payment issue
legal claim
health/medical topic
financial advice
customer complaint
angry customer
unclear intent
sensitive personal data
high-value lead
duplicate conflict
other
5.3 Confidence threshold

When should AI be sent to manual review?

Recommended default:

manual review below 0.75 confidence

Client preference:

threshold:
5.4 What fields should AI never guess?

Examples:

email
phone number
payment amount
address
legal status
medical details
consent/opt-out status
company size
budget
timeline
5.5 Can AI infer missing information from context?

Choose one:

no, never infer missing facts
yes, but only non-critical fields
yes, but mark assumptions clearly
not sure
6. Examples
6.1 Good example

Paste an example of a good email/message/content style.

6.2 Bad example

Paste an example of a style/output the AI should avoid.

6.3 Existing brand copy

Paste any existing website copy, sales email, message, or content that reflects the desired voice.

7. Approval Preferences
7.1 Who reviews AI outputs?
Name:
Role:
Email:
7.2 What actions can the reviewer take?
approve
edit
reject
request more information
send to manual review
7.3 Approval timing
same day
within 24 hours
within 48 hours
no strict timeline
8. Final Notes
8.1 Any topics AI should avoid entirely?
8.2 Any compliance, brand, or legal concerns?
8.3 Anything else we should know about AI behavior?

