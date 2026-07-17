# Model Routing

Use this reference only when a concrete next task needs a model, effort, escalation, or subagent recommendation.

## Select the phase before the model

Do not route an entire conversation once at the beginning. Route the next bounded block of work.

At activation, still recommend the model for the **conversation currently happening**. This is separate from the model for a future implementation task.

| Phase | Primary concern |
|---|---|
| Understanding | Recover context and identify the real problem |
| Exploration | Compare alternatives and collect evidence |
| Planning | Choose an approach, sequence, dependencies, and validation |
| Spec | Make scope and acceptance criteria executable |
| Awaiting approval | Preserve the gate; do not act |
| Approved execution | Complete a bounded, verifiable change |
| Diagnosis or review | Test a hypothesis or find material risk |

If new evidence invalidates the plan, say that work returns to planning or spec. Do not compensate by silently increasing effort.

## Conversation model and next-task model

Every material closure has two routing decisions:

1. **Conversation model:** choose from the current phase. For normal understanding, planning, and spec conversation, recommend Terra High. For a cross-cutting spec with persistent ambiguity, recommend Terra XHigh. For a focused critical decision about architecture, security, migration, concurrency, or an unknown root cause, recommend Sol High for that intervention.
2. **Next-task model:** choose only after the user has a bounded task. State that it is not yet defined while the conversation is still choosing the work.

Do not recommend Luna merely because the conversation is long. Luna is for clear/repeatable work or approved implementation, not for an open planning conversation.

## Choose family, effort, then work mode

1. **Family:** Luna for clear and repeatable work; Terra for balanced everyday reasoning; Sol for ambiguous, high-risk, high-judgment work.
2. **Effort:** High is the normal serious-work starting point. XHigh is for unresolved cross-cutting constraints or a first focused analysis that did not settle material uncertainty. Max is for a very hard bounded problem or long autonomous work with explicit validation.
3. **Work mode:** distinguish conversation, research, spec writing, human-checkpoint implementation, and autonomous execution. Max is not shorthand for important.

## Operational matrix

| Situation | Principal recommendation | Escalate only when | Avoid |
|---|---|---|---|
| Context, understanding, normal planning | Terra High | Dependencies or ambiguity persist after a first synthesis: Terra XHigh | Max in a long exploratory conversation |
| Cross-cutting or multi-area spec | Terra XHigh | Critical architecture, security, migration, or operational risk needs a short Sol High review | Keeping Sol active during discovery |
| Critical architecture, authorization, sensitive data, migration, concurrency, or unknown root cause | Sol High | A focused first analysis leaves material uncertainty: Sol XHigh | Starting directly in Sol Max |
| Clear repeated search, summary, classification, or bounded documentation | Luna High | Integration or normal implementation needs Luna XHigh | Asking Luna alone to settle architecture ambiguity |
| Small approved implementation with human checkpoints | Luna High | Logic, tests, or moderate integration need Luna XHigh | Max because the task matters |
| Normal approved implementation with tests and acceptance criteria | Luna XHigh | Long autonomous execution, many tool calls, closed scope, and explicit validation: Luna Max | Treating Max as the default |
| Long autonomous execution of a mature spec | Luna Max | A new hard decision appears: pause and use Sol High for that decision | Escalating further without reframing |
| Exceptional, high-cost-of-error last resort | Sol Max | None by default | Daily default use |

## Escalate and stop

1. State what the current model/effort could not establish.
2. Formulate the narrowest question that would resolve uncertainty.
3. Escalate one dimension when possible: family or effort.
4. Use the expensive intervention briefly, then return to the model for the phase.
5. Stop and ask the user when the unresolved item is priority, preference, scope, or acceptable risk.

Valid triggers include persistent conflicting requirements, a risky irreversible migration, an unknown root cause after direct investigation, or a gap in an otherwise approved spec. Importance alone is not a valid trigger.

## Recommend a subagent only when independent

Suggest a subagent only if every condition is true:

- its question does not depend on a user decision still open;
- its scope does not overlap the parent or another agent;
- it has a concrete deliverable;
- the value of parallel work exceeds coordination cost.

| Independent need | Suggested role | Initial routing | Required output |
|---|---|---|---|
| Map files, symbols, call paths, or dependencies | explorer or code_mapper | Terra Medium | paths, evidence, gaps |
| Verify official docs, versions, APIs, or benchmarks | docs_researcher | Terra Medium | dated primary sources and limitations |
| Produce approved repetitive documentation | documentation_engineer | Luna Medium | bounded artifact and unresolved items |
| Investigate a failure or unknown root cause | debugger | Sol High | hypothesis, evidence, reproduction, next test |
| Review critical correctness, security, or regressions | reviewer | Sol High | prioritized findings and correction criteria |

If a concrete interface only offers High, XHigh, and Max, choose the nearest available effort according to the phase; do not pretend the selector is the same as a benchmark harness.

## Evidence boundary

The dated research report in docs/research/model-routing-evidence-2026-07-17.md records official product guidance and DeepSWE evidence. It supports a starting policy, not a quota calculator.

- DeepSWE costs and API-style benchmark fields do not convert to Codex credits or weekly quota.
- Benchmark xhigh is not assumed to be exactly the Codex product effort selector.
- Benchmark performance does not directly measure planning conversations or local project context.
- Calibrate defaults with real tasks: phase, model/effort, clarity, accepted result, rework, and observed credit use.
