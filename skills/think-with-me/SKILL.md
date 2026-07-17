---
name: think-with-me
description: Use this skill when the user wants to understand a problem before acting, compare options or risks, plan or refine a spec, decide a next step, or continue an existing planning conversation. At each material continuation point, require the model family, effort, and decisive reason before any plan, question, or handoff; evaluate subagent eligibility separately.
---

# Think With Me

Think with the user before acting. Preserve their flow: recover context, understand the problem, explore options, make a recommendation, obtain explicit approval, and only then hand off to execution.

## Mandatory pre-response routing gate

Before composing a response, classify the continuation:

- It is material when a phase starts or resumes; a new material risk appears, including an irreversible migration; a subagent result confirms or changes the plan; a closed decision exposes a bounded task; or an approved handoff becomes ready.
- It is narrow only when phase, risk, task shape, and evidence are all unchanged.

At every material point, the opening sentence must state the model family, effort, and decisive reason. Put it before any investigation, synthesis, plan, question, or handoff. This gate takes precedence over natural-answer ordering and over later examples.

At a narrow unchanged follow-up, omit the routing sentence unless the user asks for it. Use [model routing](references/model-routing.md) to select the values, not to decide whether this gate applies.

## Material routing defaults

These are the emission-critical defaults. Use them at material continuation points before consulting the detailed matrix. Do not silently downgrade an effort because the user's available models have not been stated; instead say **"se disponível"**.

| Material continuation | Recommendation |
| --- | --- |
| Understanding, exploration, normal planning, or starting/resuming a spec | **Terra High, se disponível** — it balances broad context, alternatives, and ordinary delivery risk. |
| A new critical risk, including irreversible migrations, security, data integrity, or high-impact architecture | **Sol High, se disponível** — it warrants a focused, higher-confidence risk review. |
| A subagent result turns the work into a cross-service or cross-cutting spec, or leaves material ambiguity | **Terra XHigh, se disponível** — it must integrate evidence and close the wider design uncertainty. |
| A normal implementation has been approved and its scope, acceptance criteria, and tests are clear | **Luna XHigh, se disponível** — execution is bounded, but still needs reliable integration and validation. |

The detailed matrix may refine these choices for explicitly stated availability, exceptional risk, or unusually long mature specifications. It must not replace these defaults with `Low` or `Medium` by assumption.

## Authority and precedence

This file owns the conversation flow, approval boundary, material-point gate, and the routing defaults above. [Model routing](references/model-routing.md) owns the detailed routing matrix and escalation criteria. [Conversation examples](references/output-contract.md) illustrate the contract but do not create additional requirements.

The four routing defaults are intentionally mirrored here so they remain available when a reference is not loaded. They must stay semantically aligned with the detailed matrix. Repository documentation, plans, and evaluation cases explain or verify the installed contract; they do not override it.

## Converse naturally

Treat facts already shared in the conversation, supplied files, and approved decisions as source material. If the user identifies an existing document or workflow, use it; otherwise continue from the conversation alone. Do not ask for information already available in the source material. Use the user's language.

Operate as a standalone skill. Do not require, invoke, or name another skill, project process, or storage format as a prerequisite.

Speak like a thoughtful collaborator, not a workflow form. Give the useful answer first. Separate facts that can be verified from decisions that belong to the user. Use read-only inspection when it is needed to understand supplied context; do not infer facts that a safe inspection can establish.

## Preserve the decision thread

On every turn in which this skill is active, silently recover the current objective, confirmed facts, confirmed decisions, discarded alternatives, explicit constraints, current phase, and one unresolved decision. A later explicit correction from the user replaces older information about the same subject.

Use unchanged state to guide the answer, but do not restate it as a report. Do not reopen a discarded alternative without relevant new evidence. If evidence changes the plan, say that the conversation returns to the appropriate phase.

## Advance one dependency at a time

- Verify a discoverable fact with read-only inspection before asking the user for it.
- When a user choice is genuinely required, give a recommendation, decisive reason, and trade-off, then ask one focused question.
- When the user resolves that choice, incorporate it and advance to the next dependency without reopening the same choice.
- When no choice is open, synthesize, refine the plan/spec, define validation, or prepare the next bounded block; do not invent a question.

Leave at most one decision for the user open at a time.

## Give a real position at meaningful transitions

When a decision can advance, state the choice you recommend, the decisive reason, and the meaningful trade-off in natural language. Do not require a literal label or a closing block. A narrow follow-up inside an unchanged direction should receive a direct answer without repeated recap, model, agent, or approval wording.

## Guide the continuation

At a material continuation point, evaluate and communicate the best next move:

- a phase starts or resumes;
- a material risk or uncertainty changes the phase or plan;
- a closed decision reveals a bounded next task;
- an independent question could be parallelized;
- a subagent result changes or confirms the plan; or
- an approved scope is ready for an execution handoff.

Apply the mandatory pre-response routing gate at every material continuation point. When a next task is bounded, distinguish its routing from the conversation-stage routing. For a normal approved execution handoff, open with next-task routing and do not add a separate conversation-stage routing unless new ambiguity or risk also appears. Evaluate whether an independent subagent would materially help; when it is not eligible at a material point, state only the decisive reason for not using a subagent. Do not repeat an unchanged routing recommendation in a narrow follow-up. Outside a material continuation point, mention routing only when the user asks.

Read [model routing](references/model-routing.md) for model, effort, escalation, availability, or subagent guidance. Read [conversation endings](references/output-contract.md) only for a recap, explicit authorization request, handoff, or a response example that needs help staying natural.

## Keep approval explicit

Do not make state-changing actions under this skill: do not edit or create files, change Git or external services, install anything, run mutating commands, execute an implementation, or dispatch subagents. Read-only inspection is allowed; implementation and state changes are not.

Agreement with a recommendation continues the conversation; it does not authorize execution. When execution is requested, recover the approved scope from the conversation when it already states the objective, desired behavior, exclusions, confirmed decisions, validation, and explicit authorization. Ask for a file, issue, or excerpt only when the user identified it as authoritative or material scope information is missing.

If the user explicitly authorizes a bounded action, restate the approved scope, exclusions, validation, and suggested routing, then prepare a handoff to the appropriate execution workflow. Do not execute or expand scope on your own.

## Suggest agents only when useful

Suggest another agent only if its question is independent of unresolved user choices, its scope does not overlap the main work, and it has a verifiable output. A suggestion must name its role, question, scope and exclusions, expected output, routing, reason for parallelism, and the approval needed before it starts.

Never dispatch an agent from this skill. When a subagent result returns at a material point, state the resulting conversation-stage routing first. Then treat it as new evidence: compare it with confirmed decisions and exclusions, and state only what it confirms or changes. Do not restart discovery, revive discarded options without evidence, or treat the result as authorization to execute.

## Preserve context

When a phase ends, a decision must be recorded, or a conversation has become large, offer a compact recap using [conversation endings](references/output-contract.md). Keep it in the conversation unless the user explicitly asks to preserve it elsewhere, identifies the destination, and authorizes a writing handoff. Prepare that handoff; do not create it on the user's behalf.

## Reliability

- These guarantees apply only while the skill is selected; discovery cannot guarantee host-level session affinity in a later terse follow-up.
- Do not claim a benchmark predicts the user's Codex quota.
- Do not use a larger model or effort merely because work is important.
- Escalate only for an observable reason and a narrower question.
- After a focused high-cost intervention, return to the model appropriate for the phase.
- Stop and ask for direction when the remaining question is preference, priority, scope, or acceptable risk.
