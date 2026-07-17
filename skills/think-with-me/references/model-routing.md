# Model Routing

`SKILL.md` decides whether routing is mandatory. Its four material defaults are deliberately duplicated there because they must be emitted reliably. This reference expands those defaults for explicit availability, exceptional risk, and uncommon task shapes; it does not replace them with a lower effort by assumption. Use it when the user asks about models, effort, escalation, availability, or agents, and at a material continuation point defined in `SKILL.md`. At every material point, state the selected routing before the investigation, decision question, synthesis, or handoff. Do not dump this matrix into the conversation; express only the recommendation that changes how the user should proceed.

## Select the phase before the model

Do not route an entire conversation once at the beginning. Route the next bounded block of work.

The skill cannot read the model selector in the Codex interface. Never describe a model as active, tell the user to remain on it, or instruct them to change it.

Before naming an effort, use the availability the user supplied. If no availability is known, make the effort conditional, for example: “Para esta etapa, minha sugestão é Terra High, se essa opção estiver disponível na sua interface.”

| Phase | Primary concern |
|---|---|
| Understanding | Recover context and identify the real problem. |
| Exploration | Compare alternatives and collect evidence. |
| Planning | Choose an approach, sequence, dependencies, and validation. |
| Spec | Make scope and acceptance criteria executable. |
| Awaiting approval | Keep the user's approval explicit; do not act. |
| Approved execution | Prepare a handoff for a bounded, verifiable change. |
| Diagnosis or review | Test a hypothesis or find material risk. |

If new evidence invalidates the plan, say that work returns to planning or spec. Do not compensate by silently increasing effort.

## Distinguish the three routings

| Routing | Question | When to state it |
|---|---|---|
| Conversation stage | How should this phase be reasoned about? | Phase start/resumption or a material ambiguity/risk change. |
| Next bounded task | How should the now-clear task be executed? | The task has scope, output, and validation. |
| Subagent | Who can answer an independent question and with what capability? | The eligibility test passes and delegation changes the next step. |

At each listed material point, state the conversation-stage routing, except for a normal approved execution handoff, which opens with the next-task routing. Do not repeat either routing in a narrow follow-up unless one of those conditions changed or the user asks again.

## Mandatory material-point routing

| Material point | Required routing |
|---|---|
| Understanding, exploration, planning, or spec starts/resumes | Terra High, if available. |
| A new critical risk appears: architecture, authorization, sensitive data, irreversible migration, concurrency, or unknown root cause | Sol High, if available, for a focused review of that risk. |
| A subagent result expands a spec across services or preserves unresolved cross-cutting ambiguity | Terra XHigh, if available, to integrate the evidence and close the spec. |
| A normal implementation is approved with clear scope, acceptance criteria, and tests | Next bounded task: Luna XHigh, if available, for reliable integration and validation. |

State the recommendation even when the message also explains facts, risks, or the next decision. It must name family, effort, and decisive reason before those other actions. For an approved implementation, make clear that Luna XHigh is the next-task recommendation rather than a claim about the active selector. If the recommended effort is unavailable, say so conditionally rather than omitting routing.

## Approved execution handoff

For a normal approved execution handoff, use the `Luna XHigh, se disponível` next-task routing as the opening routing statement. Do not add a second Terra conversation-stage routing unless the approval also reveals a new material ambiguity or risk; in that case, return to planning or review first.

## Choose family, effort, then work mode

1. **Family:** Luna for clear and repeatable work; Terra for balanced everyday reasoning; Sol for ambiguous, high-risk, high-judgment work.
2. **Effort:** When available, High is the normal serious-work starting point. XHigh is for unresolved cross-cutting constraints or a first focused analysis that did not settle material uncertainty. Max is for a very hard bounded problem or long autonomous work with explicit validation.
3. **Work mode:** distinguish conversation, research, spec writing, human-checkpoint implementation, and autonomous execution. Max is not shorthand for importance.

## Operational matrix

| Situation | Principal recommendation | Escalate only when | Avoid |
|---|---|---|---|
| Context, understanding, normal planning | Terra High, if available | Dependencies or ambiguity persist after a first synthesis: Terra XHigh, if available | Max in a long exploratory conversation. |
| Cross-cutting or multi-area spec | Terra XHigh, if available | Critical architecture, security, migration, or operational risk needs a short Sol High review, if available | Keeping Sol active during discovery. |
| Critical architecture, authorization, sensitive data, migration, concurrency, or unknown root cause | Sol High, if available | A focused first analysis leaves material uncertainty: Sol XHigh, if available | Starting directly in Sol Max. |
| Clear repeated search, summary, classification, or bounded documentation | Luna High, if available | Integration or normal implementation needs Luna XHigh, if available | Asking Luna alone to settle architecture ambiguity. |
| Small approved implementation with human checkpoints | Luna High, if available | Logic, tests, or moderate integration need Luna XHigh, if available | Max because the task matters. |
| Normal approved implementation with tests and acceptance criteria | Luna XHigh, if available | Long autonomous execution, many tool calls, closed scope, and explicit validation: Luna Max, if available | Treating Max as the default. |
| Long autonomous execution of a mature spec | Luna Max, if available | A new hard decision appears: pause and use Sol High, if available, for that decision | Escalating further without reframing. |
| Exceptional, high-cost-of-error last resort | Sol Max, if available | None by default | Daily default use. |

## Escalate and stop

1. State what the previous analysis, recommendation, or investigation could not establish.
2. Formulate the narrowest question that would resolve uncertainty.
3. Escalate one dimension when possible: effort or family.
4. Use the expensive intervention briefly, then return to the model for the phase.
5. Stop and ask the user when the unresolved item is priority, preference, scope, or acceptable risk.

Valid triggers include persistent conflicting requirements, a risky irreversible migration, an unknown root cause after direct investigation, or a gap in an otherwise approved spec. Importance alone is not a valid trigger.

## Recommend a subagent only when independent

Suggest a subagent only if every condition is true:

- its question does not depend on a user decision still open;
- its scope does not overlap the parent or another agent;
- it has a concrete deliverable; and
- the value of parallel work exceeds coordination cost.

| Independent need | Suggested role | Initial routing | Required output |
|---|---|---|---|
| Map files, symbols, call paths, or dependencies | explorer or code_mapper | Terra; use the lowest suitable effort that is known to be available | Paths, evidence, and gaps. |
| Verify official docs, versions, APIs, or benchmarks | docs_researcher | Terra; use the lowest suitable effort that is known to be available | Dated primary sources and limitations. |
| Produce approved repetitive documentation | documentation_engineer | Luna; use the lowest suitable effort that is known to be available | Bounded artifact and unresolved items. |
| Investigate a failure or unknown root cause | debugger | Sol High, if available | Hypothesis, evidence, reproduction, and next test. |
| Review critical correctness, security, or regressions | reviewer | Sol High, if available | Prioritized findings and correction criteria. |

A suggested subagent must state role, question, scope and exclusions, required output, model and effort, reason for parallelism, and explicit approval needed before it starts.

When the environment exposes a named agent with a model or effort pinned in its own configuration, respect that contract. Otherwise recommend a role and conditional family/effort without claiming the role or selector exists.

## Integrate a subagent result

Treat a completed subagent result as new evidence in the main decision thread. Compare it with confirmed decisions and exclusions, state only what it confirms or changes, then recommend the next phase and routing. Do not restart discovery, revive discarded options without evidence, or treat the result as authorization to execute.

## Evidence boundary

This matrix is a conservative starting policy, not a quota calculator or a claim about the user's active selector.

- DeepSWE costs and API-style benchmark fields do not convert to Codex credits or weekly quota.
- Benchmark XHigh is not assumed to be exactly the Codex product effort selector.
- Benchmark performance does not directly measure planning conversations or a particular local project context.
- Calibrate defaults with real tasks: phase, model/effort, clarity, accepted result, rework, and observed credit use.
