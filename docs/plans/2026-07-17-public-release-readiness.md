# Think With Me Public Release Readiness Plan

**Goal:** Prepare the repository for a future public GitHub release and skills.sh discovery. This readiness pass originally changed only activation metadata; the later continuity/reliability work is part of the current reviewed state and governs the installed behavior.

**Architecture:** Keep `skills/think-with-me/` as the only installable artifact. Keep human-facing distribution material, release checks, and evaluation cases at the repository root or in repository-level directories. The current frontmatter must remain aligned with the continuity contract.

**Tech stack:** Markdown, Bash, GitHub Actions, the Agent Skills `skills-ref` validator, and the existing Codex structural validator for local verification.

## Global constraints

- Preserve the existing conversation, approval, routing, and subagent behavior.
- Keep `skills/think-with-me/` free of README, license, and release-process files.
- Do not add `skills.sh.json` while this repository contains one public skill.
- Do not commit, push, change repository visibility, update the global installation, or publish without a new explicit user authorization after diff review.
- Use MIT in the repository-root `LICENSE` file. Do not add optional license metadata to `SKILL.md`.

---

## Task 1: Make the activation metadata public-ready

**Files:**

- Modify: `skills/think-with-me/SKILL.md`
- Create: `evals/trigger-cases.md`

**Interfaces:**

- Consumes: the existing skill behavior and the Agent Skills trigger-description guidance.
- Produces: a precise description plus human-reviewable positive and negative trigger cases.

- [x] Set the `description` frontmatter to the current continuity-aware activation text:

  ```yaml
  description: Use this skill when the user wants to understand a problem before acting, compare options or risks, plan or refine a spec, decide a next step, or continue an existing planning conversation. At each material continuation point, require the model family, effort, and decisive reason before any plan, question, or handoff; evaluate subagent eligibility separately.
  ```

- [x] Add trigger cases for planning/spec/model-routing prompts that should activate and direct execution or simple-edit prompts that should not activate.

- [x] Keep the public-readiness assets separate from the continuity/reliability behavior changes, while reviewing both together as one candidate release state.

## Task 2: Add public distribution documentation and license

**Files:**

- Modify: `README.md`
- Create: `LICENSE`
- Create: `docs/release/skills-sh-publication.md`

**Interfaces:**

- Consumes: the public repository URL `igortice/think-with-me`, the skills.sh discovery flow, and the current local review gate.
- Produces: an MIT-licensed repository with separate user installation, maintainer validation, and future release instructions.

- [x] Add a concise public installation section to the README with:

  ```bash
  npx skills add igortice/think-with-me --skill think-with-me
  ```

- [x] Keep the repository marked as a private preview until the user explicitly changes visibility.
- [x] Add the standard MIT license text at repository root.
- [x] Document the manual public-release sequence: review, authorized commit/push, visibility change, first public installation, cache wait, skills.sh page/audit verification.

## Task 3: Add portable validation

**Files:**

- Create: `scripts/validate-skill.sh`
- Create: `.github/workflows/validate.yml`

**Interfaces:**

- Consumes: the repository root and `skills/think-with-me/`.
- Produces: a reproducible validation command that checks Agent Skills conformance and repository release files, plus a GitHub workflow that runs it on pushes and pull requests.

- [x] Write `scripts/validate-skill.sh` to invoke the official `skills-ref validate` reference validator and assert that `README.md`, `LICENSE`, and the installable skill directory exist.
- [x] Add a GitHub Actions workflow with read-only permissions, `actions/checkout`, `astral-sh/setup-uv`, and `bash scripts/validate-skill.sh`.
- [x] Confirm the validator accepts the existing `agents/openai.yaml` directory; it passed without requiring a compatibility exception.

## Task 4: Validate and prepare review

**Files:**

- Verify: all changed and added files from Tasks 1-3

**Interfaces:**

- Consumes: the completed local changes.
- Produces: a clean, reviewable working tree with validation evidence.

- [x] Run the existing Codex structural validator.
- [x] Run the portable validation script and inspect the result.
- [x] Run `git diff --check` and inspect the full diff.
- [x] Do not run global synchronization, `git add`, `git commit`, `git push`, or change GitHub visibility.

## Self-review

- **Behavior preservation:** the readiness assets do not introduce behavior beyond activation metadata. The continuity/reliability changes intentionally alter the workflow body and references and are reviewed alongside this readiness pass.
- **Publication readiness:** installation, license, manual release flow, portable validation, and trigger evaluation all have explicit homes outside the installable skill folder.
- **Authority:** all state-changing release actions remain gated by a later explicit user authorization.
