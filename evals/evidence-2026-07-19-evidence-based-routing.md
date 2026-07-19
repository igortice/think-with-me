# Think With Me — evidence-based model-routing record

**Date:** 19 July 2026
**Scope:** bind the evidence-based routing policy to the candidate package and
prepare the gate for fresh-context runtime validation.

## Candidate

- `PACKAGE_SHA256`: `a1cc89193af58372969d8ae7f031569e512448cea73b215aa5b4e0c1e4603e71`
- Package source: `skills/think-with-me/`
- Runtime evidence source configuration: pending Task 5; each sample must name
  the actual running `family + effort` and explicitly load the local candidate.
- Runtime sample `CANDIDATE_ID`: pending capture with the Task 5 manifest and
  fresh-context sessions.

## Approved design

The approved design preserves `GPT-5.5 High` as the historical quality
baseline and uses `Sol High` as the conservative floor for unresolved
contextual judgment. It evaluates family and effort as one atomic
configuration, filters first for required quality and domain-relevant evidence,
and compares total task cost only among eligible candidates. It does not
average heterogeneous benchmarks, infer equivalence from overlapping
confidence intervals, or assign Terra a preferred lane without supporting
evidence. Lower-cost routing remains provisional and limited to bounded,
verifiable work where cost, latency, or volume is material.

## RED result

Before Task 4 changed the gate, `bash tests/evidence-gate-v1.sh` exited `1` at
the first stale canonical dependency:

```text
FAIL: missing text in skills/think-with-me/references/output-contract.md: `Terra High` ·
```

After the Task 4 assertions were written but before their implementation, the
same command exited `1` because
`evals/model-routing-evidence-template.md` did not yet exist. Both failures
demonstrated that the gate was testing the intended stale-policy and
evidence-record boundaries.

## Implemented policy

The local package now carries the dated `model-evidence.md` snapshot and the
atomic routing policy implemented by Task 3. Its supported states are
`Sol High` for the sustained floor, `Sol XHigh` for selective depth, `Sol Max`
only behind the explicit deepest-reasoning gate, `Sol Medium` as a
non-equivalent value candidate, and `Luna Medium` as a provisional
bounded-volume route. No Terra configuration has a preferred route in this
snapshot. Task 4 changes only the evidence bindings, validation manifest,
canonical gate fixtures, and release review inputs.

## Commands run

- `bash scripts/candidate-manifest.sh`
- `bash tests/evidence-gate-v1.sh`
- `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh`
- `git diff --check`

Exact outputs and final status are recorded below from this Task 4 worktree.

## Static validation passed

- `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh`
  exited `0`, reported the package as valid, and ended with
  `Structural validation passed.`
- `git diff --check` exited `0` without output.
- `bash tests/evidence-gate-v1.sh` traversed the static policy, package,
  template, and release assertions, then exited `1` only because the explicit
  runtime-pending heading remains. This is the intentional Task 4 boundary; it
  is not a runtime pass.

## Runtime behavior pending

Task 5 still must run fresh contexts for open contextual comparison,
irreversible risk, settled high-volume extraction, benchmark conflict, and
frustration without additional ambiguity. No raw `agentMessage.text`, runtime
routing verdict, or local cost observation is claimed in this record yet.

Known runtime limitations at this point:

- Skill selection and continued loading remain host responsibilities.
- A natural-language skill remains probabilistic even when static invariants
  pass.
- The host may not expose token use, latency, agent steps, or total task cost;
  unavailable values must be recorded as unavailable rather than inferred.
- `Luna Medium` still has no qualifying local synthesis result and cannot be
  described as baseline-equivalent.

## Independent review

Independent review belongs to Task 6 and is pending. Task 4 will record only a
task-scoped pre-commit review before its commit; that review found and fixed a
case where a heading quoted inside fenced raw runtime output could satisfy the
verifier. This review is not a substitute for the independent Task 6 gate.

## Global parity

Current candidate has not been synchronized globally. The global installation,
if present, remains a previous-release surface and is not evidence for this
candidate. No push or publication has occurred in Task 4.

Tasks 1–3 implementation and evidence commits preceded this record and are
historical inputs to the Task 4 evidence-gate binding documented here.

No Task 4 evidence-gate implementation commit, push, publication, or global synchronization preceded this evidence record.
