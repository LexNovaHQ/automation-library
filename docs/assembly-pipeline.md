# Lex Nova HQ — Assembly Pipeline

**Version:** v1.0  
**Last updated:** 2026-05-24  
**Locked decision:** D86-A (hybrid template-first approach + 7-step assembly process)

---

## Purpose

This is the canonical 7-step process used for every template build and every paid client engagement. It is the operational discipline that converts the component library (see `component-catalog.md`) into shipped work.

**The core principle:** every reusable pattern is a component, not template-specific logic. Templates and client deliveries are *assemblies* of pre-built components, not bespoke builds from scratch.

**"We build, we don't grunt."** Every hour invested in this process compounds — components built today reduce time on every future engagement that uses them.

---

## The 7 Steps

### Step 1: Identify Buyer Outcomes

Before touching any tool, write down what the buyer is actually trying to achieve. Use the buyer's own language, not technical jargon.

**Examples of buyer outcomes:**
- "When a lead fills out my contact form, I want them added to my CRM and an AI-generated follow-up email sent within 5 minutes."
- "When my accountant uploads a bank statement PDF, I want the transactions extracted into a Google Sheet and categorized."
- "When a client signs my contract, I want them automatically billed and given access to a portal with their documents."

**Output of Step 1:** a bulleted list of buyer outcomes in plain language. No technical detail yet.

**Discipline:** never skip this step. Engineering brain wants to jump to "let me wire up the webhook" — resist. The buyer outcome list is what you'll validate against in Step 7.

---

### Step 2: Map Outcomes → Components

For each buyer outcome from Step 1, identify which components from `component-catalog.md` deliver that outcome.

**How to map:**
- Open `component-catalog.md`
- Scan the Backing-Templates table at the bottom for matching patterns
- For each outcome, list the component IDs needed

**Example mapping (for Template #1 — Lead Capture → CRM → AI Follow-up):**

| Buyer Outcome | Components |
|---|---|
| "When a lead fills out my form..." | C2-E (Form Intake Pipeline), C2-C (Webhook Trigger) |
| "...add them to my CRM..." | C2-A (Data Sync Pipeline) |
| "...with auto-qualification..." | C4-L (Lead Qualification Agent), C2-B (Conditional Routing) |
| "...and send an AI-generated follow-up..." | C2-K (LLM-in-Workflow Adapter), C4-D (AI Content Generation) |
| "...within 5 minutes." | C2-I (Notification & Alert Engine for timing/alerts) |

**Output of Step 2:** a component dependency list. Every outcome has at least one component backing it.

---

### Step 3: Identify Gaps

Check each component in your list against its status in `component-catalog.md`:

- ✅ **Done** → ready to assemble
- 🟡 **Partial** → needs generalization work before assembly
- ❌ **Not done** → must be built before this template can be assembled

**Rule:** if any required component is ❌ Not done, build it as a standalone component FIRST. Do not build it inside the template. This is the discipline that makes the library work.

**Output of Step 3:** a gap list — components to build before assembly can proceed.

**If gaps exist:**
1. Pause template assembly
2. Build each gap component as a standalone, generalized, documented module in `components/[category]/[component-id]/`
3. Test the component independently with sample data
4. Update its status in `component-catalog.md` to ✅ Done
5. Return to Step 4

**If no gaps exist:** proceed to Step 4.

---

### Step 4: Clone Components into New Workflow

Open n8n. Create a new workflow named after the template or client engagement (e.g., `Template-1_Lead-Capture-CRM-AI-Follow-up` or `Client-Acme_Onboarding-System`).

For each component in your dependency list:
1. Open the component's source workflow (in `components/[category]/[component-id]/workflow.json`)
2. Import or copy the relevant nodes into your new workflow
3. Do NOT modify the component logic at this stage — clone-and-place only

**Rule:** components are cloned, not referenced. n8n doesn't support library imports the way code does, so each workflow is self-contained. The discipline is that the cloned nodes match the source component exactly.

**Output of Step 4:** new workflow file with all required component nodes present but not yet wired.

---

### Step 5: Wire Components Together

Connect the components according to the data flow from Step 2. This is where buyer-outcome-level routing logic is applied.

**Wiring discipline:**
- Use n8n's native connector lines for happy-path flow
- For branching, use C2-B (Conditional Routing Engine) — don't write inline IF nodes if a Conditional Routing pattern exists
- For error paths, attach C6-D (Schema/Payload Validator) — don't write inline error handlers
- Document each connection's purpose in n8n node sticky notes

**Output of Step 5:** a wired but uncalibrated workflow. Inputs and outputs at each component boundary are clearly labeled but not yet bound to real client data.

---

### Step 6: Configure for Specific Context

This is where the template becomes either:
- A **portfolio demo** (configured with demo data for showcase)
- A **client delivery** (configured with the client's actual credentials, endpoints, and data)

**For portfolio demos:**
- Use plausible fake company data
- Use sandbox accounts for any third-party services
- Use Claude/OpenAI API keys from your own budget (per locked Phase 2 tooling decision — small Phase 2 portfolio API budget)
- Capture screenshots and a Loom video walkthrough

**For client deliveries:**
- Client provides their own API keys and credentials (standard model — client pays for their own AI/tooling)
- Configure webhooks to client's actual endpoints
- Map fields to client's actual schema (their CRM field names, their CSV columns, their form fields)
- Set timezone, currency, language preferences

**Output of Step 6:** a context-bound, ready-to-run workflow.

---

### Step 7: Test, Document, Deploy

**Test:**
- Run end-to-end with realistic test data
- Verify every buyer outcome from Step 1 is achieved
- Test failure modes: malformed data, network timeouts, rate limits, missing credentials
- For client deliveries, run the test with the client watching (Zoom screen share) — catches expectation mismatches early

**Document:**
- Add sticky notes inside n8n explaining what each component does at a buyer-outcome level
- Create a brief Loom walkthrough (2-5 min) showing the workflow running end-to-end
- For client deliveries: write a 1-page SOP for the client team explaining how to use, monitor, and troubleshoot the system
- For portfolio: write a 1-paragraph case study describing buyer outcomes solved

**Deploy:**
- For portfolio: save workflow file to `templates/[template-id]/workflow.json` + add to portfolio listing
- For client deliveries: export workflow file, deliver to client's n8n instance, run handoff call

**Output of Step 7:** tested + documented + deployed workflow. Done.

---

## Worked Example: Template #1 — Lead Capture → CRM → AI Follow-up

**Step 1 — Buyer Outcomes:**
- When a lead submits the contact form, capture their data
- Score the lead (qualified vs. nurture vs. disqualified)
- Add to CRM with appropriate tag
- If qualified, send AI-generated personalized follow-up email within 5 minutes
- Notify sales rep via Slack if lead is qualified
- If unqualified, add to long-term nurture sequence

**Step 2 — Component Map:**
- Form intake → C2-E (Form Intake Pipeline) + C2-C (Webhook Trigger)
- Lead scoring → C4-L (Lead Qualification Agent)
- Conditional routing → C2-B (Conditional Routing Engine)
- CRM sync → C2-A (Data Sync Pipeline)
- AI email gen → C2-K (LLM-in-Workflow Adapter) + C4-D (AI Content Generation Pipeline)
- Sequence for nurture → C1-E (Multi-Step Sequence Engine)
- Notification → C2-I (Notification & Alert Engine)

**Step 3 — Gap Check (against component-catalog.md):**
- C2-E ✅, C2-C ✅, C4-L ✅, C2-B ✅, C2-A ✅, C2-K ✅, C4-D ✅, C2-I ✅
- C1-E 🟡 Partial — needs generalization for non-cold-outbound use cases

**Action:** Promote C1-E from 🟡 → ✅ by generalizing it OR substitute with a simpler scheduled-message pattern for portfolio demo. **Choice:** for Template #1 portfolio, use simpler scheduled-message pattern; flag C1-E generalization as a Tier 2 build priority.

**Step 4 — Clone:**
- Create new n8n workflow `Template-1_Lead-Capture-CRM-AI-Follow-up`
- Clone in nodes for each ✅ component

**Step 5 — Wire:**
- Form webhook → C4-L scoring → C2-B routing → (qualified path) C2-K+C4-D email gen → C2-A CRM write → C2-I Slack notify
- (Unqualified path) → C2-A CRM write with nurture tag → scheduled-message sequence

**Step 6 — Configure (portfolio demo):**
- Sample form URL (Typeform or n8n-hosted)
- Sandbox HubSpot CRM
- Claude API key (own budget)
- Demo Slack workspace

**Step 7 — Test + Document + Deploy:**
- Submit 5 test leads (qualified, unqualified, edge cases)
- Verify all 6 buyer outcomes achieved
- Loom walkthrough recorded
- Workflow file saved to `templates/template-1/workflow.json`
- 1-paragraph case study added to portfolio listing

---

## When to Use This Pipeline vs. a Saved Template

| Scenario | Action |
|---|---|
| New buyer outcome that doesn't match any of the 5 saved templates | Run the full 7-step pipeline from scratch |
| Buyer outcome matches a saved template exactly | Start from `templates/[template-id]/workflow.json`, apply Steps 6-7 only |
| Mostly matches a template but with a unique twist | Start from saved template, apply Steps 2-3 to identify the gap, build the gap component, then Steps 5-7 |
| Diagnostic engagement (Offering #6) | Use C6-A Diagnostic Checklist as the starting "template" — the engagement IS a structured walk through C6-A |

---

## Discipline Reminders

1. **Components are atomic.** A component does one thing well. If it does two things, split it.

2. **Templates are assemblies.** A template never contains logic that should be a component. If you find yourself writing template-specific business logic, stop — extract it as a component first.

3. **Test components independently.** Before assembling, every ✅ component should run on its own with sample data. If it can't, it's not ✅.

4. **Document at the component level, not the template level.** Templates assemble; components implement. Documentation lives with the thing being implemented.

5. **Every paid client engagement updates the library.** When you build something new for a client, the question is always: "is this reusable across other clients?" If yes, extract it as a component and add to `component-catalog.md`.

6. **The catalog is the source of truth, not the codebase.** If a component exists in code but not in the catalog, it doesn't exist. Catalog first, code second.

7. **Build sequence for Phase 2:** Cat 2 (Make.com/n8n) first per locked architecture. Days 2-10 of Phase 2 build the 5 demand-backed templates, extracting Cat 2 components from what repeats. Other categories ramp on demand thereafter.

---

## Common Anti-Patterns to Avoid

| Anti-pattern | Why it's bad | Correct pattern |
|---|---|---|
| Writing client-specific logic inside a template | Locks you into bespoke rebuilds every engagement | Extract as a configurable component with parameters |
| Skipping the catalog update after building something new | Library decays into a folder of files no one can find | Update catalog FIRST, then write code |
| Cloning a template and modifying inline for a new client | Diverges your sources of truth | Clone components from the library, not from a previous template instance |
| Building a component "good enough" for one use case | When the second use case arrives, you rebuild | Generalize at component creation time — name parameters, externalize config |
| Letting "Partial" components stay partial forever | Phantom inventory — looks like you have it but you don't | Schedule 🟡 → ✅ work; status it on the catalog with target date |

---

## Version History

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-05-24 | Initial pipeline documentation. Codifies D86-A hybrid template-first architecture and 7-step process. |

---

**This document is the canonical process reference. Every template build and every paid client engagement follows this sequence — no exceptions.**
