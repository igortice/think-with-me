# Think With Me — model comparison and routing evidence

RUNTIME_SOURCE_FIDELITY: host-unverified
LOCAL_CANDIDATE_STATUS: passed
INDEPENDENT_REVIEW_STATUS: passed
GLOBAL_PARITY_STATUS: not-run
POST_INSTALL_RUNTIME_STATUS: not-run

**Date:** 20 July 2026
**Scope:** bind the portable comparison, open model portfolio, nearby-alternative
reasoning, and host activation boundary to the current installable package.

## Candidate

- `PACKAGE_SHA256`: `b0f2f5b6902a79835db37d7ba724aed5f0abe4f196e6da0a905dd5d59e4046a3`
- Package source: `skills/think-with-me/`
- Capture-time `CANDIDATE_ID`:
  `42b0db92134f8d3a2e3950d1ed23b93c1d9d056de2fab4cb513f1721b234c931`
- Base commit at capture:
  `d0aa46c4e4995f2b82c7bd704b241830573fd6c5`
- Runtime source requested explicitly: local candidate package; global
  installation excluded.
- Runtime source fidelity: `host-unverified`; the agent tasks were instructed
  to load the local path, but the host did not emit a source-selection receipt.
- Host source configuration: `gpt-5.6-sol` with `high` reasoning effort.

## Raw capture artifact

- Initial artifact: `evals/runtime-captures-2026-07-20.md`.
- `INITIAL_RUNTIME_CAPTURES_SHA256`: `e69f52d78c140a2a40c1f2c56e34970ee224b40a10fb02fd68e664f62adfe361`
- Final artifact: `evals/runtime-captures-2026-07-20-final.md`.
- `FINAL_RUNTIME_CAPTURES_SHA256`: `d9a0bb737b0a326d90e7ae4182fd306c307f1d48406c7213967da24d7f559a6a`
- Contents: exact prompts and unedited final responses for MR-09, MR-10,
  MR-16, MR-17, MR-18, MR-19, TWM-M11, TWM-M12, and TWM-M13. The initial
  artifact and the first responses in the final artifact preserve failed or
  superseded samples; the `qualifying rerun` sections identify the accepted
  replacements without rewriting the earlier output.
- Host-reported token use: `not exposed by host`.
- Host-reported latency: `not exposed by host`.
- Host-reported agent steps: `not exposed by host`.
- Host-reported total task cost: `not exposed by host`.

## Runtime behavior passed

| Case | Result | Evidence observed |
| --- | --- | --- |
| MR-09 | pass (`final_mr09b`) | Kept Artificial Analysis and DeepSWE separate, rejected a universal Sol Medium equivalence claim, preserved Sol High for contextual daily decisions, and left one immediate policy action. |
| MR-10 | pass (`final_mr10`) | Treated interval overlap as unresolved ordering rather than equivalence, rejected cost transfer from DeepSWE to strategic Portuguese conversation, and limited the cost observation to the measured harness. |
| MR-16 | pass (`final_mr16`) | Kept Sol Max eligible while recommending Sol XHigh for value; reported the 1.94 pp point-estimate difference, overlap, and $3.69 / 44% DeepSWE saving. |
| MR-17 | pass (`final_mr17c`) | Kept Sol Max, Sol XHigh, Terra Max, Sol High, Luna Max, and other documented configurations visible without a top-N quota; used coherent cost denominators and selected one immediate pilot action. |
| MR-18 | pass (`final_mr18`) | Emitted one footer recommendation while showing every cost-based nearby alternative with absolute and percentage cost plus uncertainty, token, and step trade-offs. |
| MR-19 | pass (`final_mr19`) | Reproduced both complete source-specific Markdown tables from the installable package, declared the missing Artificial Analysis interval, avoided a combined score, used coherent absolute and percentage cost differences, and left one pilot action. |
| TWM-M11 | pass (`final_m11`) | Reported the two source requirements as compatible facts and kept the maintenance concern explicitly inferential. |
| TWM-M12 | pass / host boundary (`final_m12`) | The explicitly invoked first turn used the closing. The second turn omitted the invocation and did not use the closing; that second response is recorded as host activation behavior, not candidate output. |
| TWM-M13 | pass (`final_m13d`) | A new explicit invocation recovered the centralization decision, explicitly retained the unstable-rule constraint, and preserved the exact open contract-output dependency without requesting a recap, then emitted the complete closing. |

Across the qualifying candidate-attributable samples, every closing contains useful prose
followed by one continuous Markdown blockquote with `Minha visão`, one immediate
`Próximo passo`, and exactly one atomic model configuration. No sample took an
unauthorized action. The value cases retained uncertainty and source scope
instead of presenting nearby point estimates as universal equivalence.

## Static validation passed

The following command sequence exited `0` before independent review:

```text
bash scripts/sync-model-comparison.sh --check
bash tests/sync-model-comparison.sh
bash tests/verify-model-comparison-data.sh
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
bash -n scripts/candidate-manifest.sh scripts/sync-model-comparison.sh scripts/validate-skill.sh scripts/validate-structure.sh scripts/verify-evidence-record.sh tests/evidence-gate-v1.sh tests/sync-model-comparison.sh tests/verify-model-comparison-data.sh
git diff --check
```

Observed output included `Model comparison mirrors are synchronized.`, `Model
comparison synchronization tests passed.`, `Model comparison data matches the
preserved DeepSWE artifact.`, `Valid skill`, and `Structural validation
passed.` The shell syntax check and `git diff --check` emitted no output.

`bash scripts/verify-evidence-record.sh` was also run and failed only on
`INDEPENDENT_REVIEW_STATUS: pending`. That RED result is intentional until the
review below is complete; it prevents the local gate from approving its own
evidence without an independent pass.

## Independent review

The first independent read-only review correctly rejected the initial record:
TWM-M13 had replaced the open dependency, MR-18 omitted one percentage, MR-17
and MR-19 bundled follow-on monitoring actions, and MR-10 transferred a cost
claim outside its measured domain. Those raw failures remain preserved. The
package contract was tightened and every affected case was rerun against the
final package. The second review found a contradictory legacy gate assertion
and required TWM-M13 to name the instability constraint explicitly. The gate
assertion was narrowed without changing the package, and `final_m13d` preserved
all three continuity facts. The third independent read-only review recalculated
the package and final-capture hashes, inspected the qualifying rerun, confirmed
that the gate then stopped only at the pending marker, and returned PASS with
no remaining finding. No reviewer edited the worktree.

## Global parity

Not run for this candidate. The global installation remains a release surface,
not a prerequisite for reviewing or committing the local candidate. It may be
synchronized only after explicit user authorization and, for the public `npx`
path, after the reviewed commit is available from the repository.

## Post-install runtime

Not run for this candidate. The release runbook requires a separate global
parity check and explicit-invocation smoke test after an authorized install or
update. These later checks must append a new dated record; they must not relabel
this pre-install evidence.

No commit, push, publication, global synchronization, or skills.sh installation preceded this candidate evidence record.
