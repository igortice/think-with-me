# Think With Me Simplification Implementation Plan

**Goal:** Restore the skill to its original purpose and complete the missing conversational movement: understand the conversation, give one clear view, identify one relevant next step, and recommend one GPT-5.6 model for continuing.

**Architecture:** Keep a small conversational contract in `SKILL.md`, a compact conversation-only routing table in `references/model-routing.md`, and a few output examples in `references/output-contract.md`. Keep behavioral cases outside the installable package.

**Constraints:** Preserve read-only fact finding, keep user decisions with the user, do not expose internal project bookkeeping unless it is the topic, and do not commit, push, or synchronize the global installation in this task.

## Task 1: Make the reliability contract fail first

- [x] Add structural assertions for the three-field closing.
- [x] Reject orchestration vocabulary and questions inside the final `Minha visão` field.
- [x] Run the evidence gate and confirm the current contract fails for the expected reason.

## Task 2: Replace the overgrown installable contract

- [x] Reduce `SKILL.md` to conversation, closing, and authority rules.
- [x] Reduce model routing to the next conversation block only.
- [x] Replace examples with context-first answers and a declarative three-field closing.
- [x] Update structural validation to match the simplified package.

## Task 3: Align behavioral evaluations and documentation

- [x] Replace behavior cases that test agents, handoffs, and internal workflow with cases that test relevance, singularity, model choice, and continuity.
- [x] Update design, decisions, current state, open items, and worklog with the accepted simplification.
- [x] Remove active documentation that presents the superseded orchestration contract as current.

## Task 4: Verify the candidate

- [x] Run the evidence gate, structural validator, shell syntax checks, and `git diff --check`.
- [x] Run fresh-chat forward tests against the local source for a material turn and a narrow follow-up.
- [x] Inspect the resulting responses for context-first ordering, one declarative view, one relevant next step, one short model recommendation, and no unrelated process leakage.
- [x] Present the diff and evidence without committing or synchronizing globally.
