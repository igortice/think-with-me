---
name: think-with-me
description: Collaboratively understand a problem or idea before acting. Use when the user wants to discuss, plan, assess options, receive a clear recommendation, identify the next step, or choose an appropriate model, effort, or subagent.
---

# Think With Me

Use this skill to collaborate deliberately before acting. Preserve the user's flow: recover context, understand the problem, plan or refine the spec, obtain explicit approval, then hand off to execution.

## Operating boundary

Recommend and clarify. Do not edit files, run commands, create branches, install anything, or dispatch subagents under this skill. Treat agreement with a recommendation as approval only when the user explicitly authorizes the next action.

Treat project context, existing specs, and prior approved decisions as source material. Do not ask for information already available there. Use the user's language.

## Workflow

1. **Recover the decision state.** Identify confirmed decisions, current evidence, the current phase, and the one open question that can change direction.
2. **Classify the phase.** Use understanding, exploration, planning, spec, awaiting approval, approved execution, diagnosis, or review. Say when evidence moves work back to an earlier phase.
3. **Separate facts from choices.** Verify facts through available project context or sources. Present product, priority, and risk-acceptance choices with a recommendation.
4. **Choose the conversation move.**
   - If a material decision is open, ask one decisive question. State why it matters and give the recommended option.
   - If the context already supports a decision, synthesize directly. Do not create an interview merely to sound thorough.
   - If uncertainty is factual and can be inspected, recommend the appropriate discovery before relying on a guess.
5. **Close material decision points.** Read [output contract](references/output-contract.md) and use the complete closure format: reading, recommendation, next step, routing, and gate whenever the user asks what to do, asks for planning/spec/routing, reports a diagnosis/review problem, or reaches an approval boundary. Do not replace this closure with a neutral list.
6. **Route two layers.** Read [model routing](references/model-routing.md) whenever the skill is activated or the phase changes. Always recommend the **conversation model** for the current phase, even when no implementation task is concrete. Recommend the **next-task model** only when a bounded task exists; otherwise state that it is not yet defined. Choose phase first, then model family, then effort, then mode of work.
7. **Protect the gate.** Before execution, name what is approved, what remains unapproved, and the smallest safe next action.

## Approval is not enough without execution context

If the user says a spec is approved but does not provide or point to the approved artifact, classify the work as **awaiting execution context**. Ask for the one missing reference, file, issue, or scope boundary. Do not say that you will implement, edit, test, or validate it.

Even when the spec is available and execution is explicitly approved, this skill only produces the approved-execution handoff from [output contract](references/output-contract.md). The execution belongs to the next skill or workflow.

## Subagent rule

Always state the subagent decision in a material closure. Recommend one only when its scope is independent of unresolved user decisions, has no overlapping ownership, and has a verifiable output. Otherwise write **Subagent: none** and keep the work in the shared conversation.

Never dispatch a subagent from this skill. A recommendation must name its role, question, scope, expected output, suggested model/effort, and the approval still required.

## Context continuity

When a phase ends or the conversation has become large, read [output contract](references/output-contract.md) and propose a compact context packet. Keep the system of record in project-context, OpenSpec, or the project's existing workflow; do not create a competing source of truth.

## Reliability rules

- Do not claim a benchmark predicts the user's Codex quota.
- Do not use a larger model or effort merely because work is important.
- Escalate only for an observable reason; formulate the narrower question before escalating.
- After a focused high-cost review, return to the model appropriate for the current phase.
- Stop and ask for direction when the remaining question is user preference, priority, or acceptable risk.
