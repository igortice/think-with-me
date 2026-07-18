# Public Skill Surfaces Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the skills.sh preview and GitHub README clear public product surfaces while preserving the localized Think With Me conversation contract.

**Architecture:** Keep `SKILL.md` as a short English operational core that the skills.sh page can render safely. Move literal Portuguese and English output templates into `references/output-contract.md`, where the runtime can load them when needed. Make the README a product-first guide; keep routing policy and maintainer operations in references and the final README sections.

**Tech Stack:** Markdown, YAML, Bash validation scripts, Skills CLI, Codex global skill installation.

## Global Constraints

- Do not change the skill name, license, repository visibility, model-routing policy, or the conversation-to-execution boundary.
- `SKILL.md` must be English-only, concise, and must not mention `grilling` or any internal origin.
- The current user message determines the response language; the exact English and Portuguese templates remain in `references/output-contract.md`.
- The final response stays one continuous Markdown blockquote with conclusion, immediate dependency, and exactly one model recommendation.
- Keep `README.md` English-first with one canonical global Codex installation command.
- Do not claim a behavior test passed until the current package hash, global parity, and an actual forward-test have passed.

---

### Task 1: Move the semantic assertions to the correct public boundary

**Files:**
- Modify: `tests/evidence-gate-v1.sh`
- Modify: `skills/think-with-me/references/output-contract.md`

**Interfaces:**
- Consumes: the current three-field output contract.
- Produces: test coverage where public-core assertions target `SKILL.md` and literal language templates target `references/output-contract.md`.

- [ ] **Step 1: Make the public-core regression test fail**

Replace the literal-template requirements aimed at `skill_file` with these checks:

```bash
require_text "${skill_file}" 'Use the language of the current user message'
require_text "${skill_file}" 'one continuous Markdown blockquote'
require_text "${skill_file}" 'Open [the output contract](references/output-contract.md)'

if rg -n -i 'grilling|Minha visão|Próximo passo|Modelo para o próximo passo' "${skill_file}" >/dev/null; then
  fail "public core contains internal or language-specific copy"
fi
```

Change the two `closing_template` searches to read `${output_file}`. Keep the footer validator scanning both the core and references so examples in either location remain valid.

- [ ] **Step 2: Run the gate and confirm the expected RED result**

Run:

```bash
bash tests/evidence-gate-v1.sh
```

Expected: fail because `SKILL.md` still contains `grilling` and language-specific labels, and because the Portuguese canonical template has not yet moved to the output reference.

- [ ] **Step 3: Add canonical templates to the output reference**

Add this section before the existing examples in `skills/think-with-me/references/output-contract.md`:

```md
## Canonical closing templates

Use the Portuguese template when the current user message is Portuguese:

> **Minha visão:** one clear conclusion about the subject and the decisive reason.
>
> **Próximo passo:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.
>
> _Modelo para o próximo passo: **Terra High** — connect the concrete next step to the decisive conversational evidence._

Use the English template when the current user message is English:

> **My view:** one clear conclusion about the subject and the decisive reason.
>
> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.
>
> _Model for the next step: **Terra High** — connect the concrete next step to the decisive conversational evidence._
```

- [ ] **Step 4: Keep the output reference as the detailed contract**

Retain the current English and Portuguese examples, but add one English sentence under the canonical templates: `For other languages, preserve these three roles with concise natural labels.` Do not add a third hard-coded language.

- [ ] **Step 5: Run the gate after the reference change**

Run:

```bash
bash tests/evidence-gate-v1.sh
```

Expected: it still fails until Task 2 removes the public-core copy, proving the test distinguishes reference content from skills.sh preview content.

### Task 2: Rewrite the skills.sh-facing core

**Files:**
- Modify: `skills/think-with-me/SKILL.md`

**Interfaces:**
- Consumes: canonical output templates in `references/output-contract.md` and routing policy in `references/model-routing.md`.
- Produces: an English-only core rendered by skills.sh, with all operational behavior still reachable through direct instructions and references.

- [ ] **Step 1: Replace the introductory text and remove internal provenance**

Use this opening after the frontmatter:

```md
# Think With Me

Help the user make one well-grounded decision before acting. Understand the current conversation, state a position, identify the immediate dependency, and recommend the GPT-5.6 model best suited to that dependency.
```

Do not retain the paragraph mentioning `grilling`.

- [ ] **Step 2: Keep only concise operational sections**

Use these six headings and requirements:

```md
## Understand the conversation
## Advance one decision
## Close clearly
## Choose the model from the next step
## Open detailed references only when needed
## Keep the boundary clear
```

`Close clearly` must say: `Use the language of the current user message, not the application locale, prior system text, or the agent default.` It must define the three roles as `view`, `next step`, and `model recommendation`, require a continuous blockquote, one question only when the user must decide, and a one-line italic model footer. It must not name any language-specific label.

`Open detailed references only when needed` must contain exactly these links:

```md
Open [the output contract](references/output-contract.md) for exact localized labels, templates, and examples. Open [model routing](references/model-routing.md) when the next step requires a model recommendation.
```

- [ ] **Step 3: Preserve behavior without exposing examples**

Keep the constraints that the next step is one immediate dependency, the model is selected only after view and next step are formed, active model state is never inferred, a reason cannot list alternative models, and direct operational instruction is required before execution. Express them without Portuguese literals, raw templates, or HTML examples.

- [ ] **Step 4: Run the semantic gate and confirm GREEN before evidence validation**

Run:

```bash
bash tests/evidence-gate-v1.sh
```

Expected: static assertions pass; the only remaining failure is the current package hash absent from the evidence record.

### Task 3: Restructure the GitHub README for an installer

**Files:**
- Modify: `README.md`

**Interfaces:**
- Consumes: the public promise and English canonical output shape.
- Produces: a product-first README with one clear Codex installation path and maintainer details at the end.

- [ ] **Step 1: Replace the top-level section order**

Use this exact order:

```md
# Think With Me
## Why use it
## What a response looks like
## Install for Codex
## Use it
## Language, compatibility, and boundaries
## For maintainers
## License
```

- [ ] **Step 2: Use a concise product promise**

Place this text below the title:

```md
Think through a decision before acting. Think With Me gives you a grounded view, one immediate next step, and a contextual GPT-5.6 recommendation for that step.
```

In `Why use it`, describe only four outcomes: a position grounded in the conversation, one immediate dependency, one contextual model recommendation, and a compact localized close. Do not mention test scripts or package internals.

- [ ] **Step 3: Keep the rendered English response example**

Use a normal paragraph followed by the existing English blockquote. Do not wrap it in a fenced code block. Follow it with one sentence that the labels adapt to the language of the current user message.

- [ ] **Step 4: Make Codex installation unambiguous**

Keep only this command in `Install for Codex`:

```bash
npx skills add igortice/think-with-me --skill think-with-me -g -a codex
```

Remove the auto-detection alternative. In `Use it`, retain the explicit `$think-with-me` invocation and explain in one sentence that compatible hosts can also discover the skill from a matching request.

- [ ] **Step 5: Move technical details to the maintainer section**

Put package layout, structural validation, evidence gate, and publication runbook under `For maintainers`. Keep one link each to `skills/think-with-me/`, `docs/release/skills-sh-publication.md`, and the license.

- [ ] **Step 6: Verify rendered Markdown locally**

Run:

```bash
git diff --check
rg -n '^```md|grilling' README.md skills/think-with-me/SKILL.md
```

Expected: no output from `rg`; `git diff --check` is silent.

### Task 4: Validate the candidate and publish the public surfaces

**Files:**
- Modify: `evals/evidence-2026-07-18-public-readiness.md`
- Modify: `.codex/project-context/CURRENT_STATE.md`
- Modify: `.codex/project-context/worklog/2026-07.md`

**Interfaces:**
- Consumes: the updated core, references, README, static gates, and global installation.
- Produces: evidence tied to the new package hash, a synchronized global skill, public GitHub content, and a skills.sh preview without internal provenance.

- [ ] **Step 1: Validate the source candidate**

Run:

```bash
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
git diff --check
```

Expected: structural validation passes; evidence gate waits only for the new package hash and global forward-test; whitespace check is silent.

- [ ] **Step 2: Synchronize and verify the global source**

Run:

```bash
NPM_CONFIG_CACHE=.cache/npm npx --yes skills add . --skill think-with-me -g -a codex -y
bash scripts/verify-global-install.sh
```

Expected: installation completes and prints `Global think-with-me installation matches the repository source.`

- [ ] **Step 3: Run the English forward-test**

Run an ephemeral, read-only Codex session with the TWM-13 prompt. Record the final answer only if it uses `My view`, `Next step`, and `Model for the next step` in a continuous blockquote and recommends exactly one model.

- [ ] **Step 4: Update evidence with the new package hash**

Replace `PACKAGE_SHA256` in `evals/evidence-2026-07-18-public-readiness.md` with the value from:

```bash
bash scripts/candidate-manifest.sh | rg '^PACKAGE_SHA256='
```

Add a dated paragraph describing the public-surface change, global parity, and the passed forward-test. Keep the phrase `No implementation commit, push, or publication was made before this evidence record.` before committing.

- [ ] **Step 5: Re-run the full gate**

Run:

```bash
bash tests/evidence-gate-v1.sh
git diff --check
```

Expected: `Evidence Gate v1 checks passed.` and no whitespace output.

- [ ] **Step 6: Commit and push the approved candidate**

Run:

```bash
git add README.md skills/think-with-me tests/evidence-gate-v1.sh evals/evidence-2026-07-18-public-readiness.md docs/specs/2026-07-18-public-surface-design.md docs/plans/2026-07-18-public-surface-implementation.md
git commit -m "refactor: simplify public skill surfaces"
git push origin main
```

Expected: `main` contains the README and public-core revision.

- [ ] **Step 7: Reinstall from the public repository and inspect both pages**

Run:

```bash
NPM_CONFIG_CACHE=.cache/npm npx --yes skills add igortice/think-with-me --skill think-with-me -g -a codex -y
curl -sS https://www.skills.sh/igortice/think-with-me/think-with-me
curl -sS https://github.com/igortice/think-with-me
```

Expected: skills.sh renders English-only public-core text without `grilling`; GitHub renders the README example as a blockquote and shows one canonical Codex command.
