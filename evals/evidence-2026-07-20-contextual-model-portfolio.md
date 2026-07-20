# Think With Me — contextual model portfolio evidence

RUNTIME_SOURCE_FIDELITY: host-unverified
LOCAL_CANDIDATE_STATUS: passed
INDEPENDENT_REVIEW_STATUS: passed
GLOBAL_PARITY_STATUS: not-run
POST_INSTALL_RUNTIME_STATUS: not-run

**Date:** 20 July 2026
**Scope:** bind next-step-specific eligible-set routing, contextual upper-band
routes, and recommendation recomputation to the installable package.

## Candidate

- `PACKAGE_SHA256`: `ffb85377e4af72d09ecaf4c0d7233e188ca98c7e45d18d5a2f7506411ba67f96`
- Package source: `skills/think-with-me/`.
- Capture-time `CANDIDATE_ID` before this evidence record:
  `be4e60f7fc87cf9cd42e1d6c52c41da52d4cb01d9b844bbede73bcdd42899c28`.
- Base commit at capture:
  `223451cc245b6159d162f64e85dc4560f288f329`.
- Runtime source requested explicitly: local candidate package; global
  installation excluded.
- Runtime source fidelity: `host-unverified`; isolated tasks were instructed
  to load the local package, but the host did not emit a source receipt.
- Host model and effort receipt: not exposed by the isolated-task host.

## Raw capture artifact

- Initial artifact:
  `evals/runtime-captures-2026-07-20-contextual-portfolio.md`.
- `INITIAL_RUNTIME_CAPTURES_SHA256`: `d60911062a59f7d4a17fddbf7cfae6628591618023fbe54e9100186729df4aa2`
- Final artifact:
  `evals/runtime-captures-2026-07-20-contextual-portfolio-final.md`.
- `FINAL_RUNTIME_CAPTURES_SHA256`: `72cc49f3bc781f979b9b7cad24a4107d67df9fa7c4a2499657e3dafcceb5fa38`
- Host-reported token use, latency, steps, and total cost: not exposed.

## Runtime behavior passed

| Case | Result | Evidence observed |
| --- | --- | --- |
| MR-20 | pass (`runtime_luna`) | Selected `Luna Max` only in the matched long-horizon domain, reported the $0.44 / 12.7% mean-task saving, disclosed 44,950 extra tokens and 64.8 extra steps, and rejected general conversational transfer. |
| MR-21 | pass (`runtime_terra`) | Selected `Terra Max` only for a representative local-convergence pilot and explicitly rejected a proven general preference. |
| MR-22 | pass (`runtime_compact`) | Selected `Sol High` because compact upper-band execution was decisive and stated that a material future step change requires a new choice. |
| MR-23 | pass (`runtime_value`) | Selected `Sol Medium` provisionally for one bounded, reversible, cheaply verified analysis under material cost pressure. |
| MR-24 | pass (`runtime_trajectory`) | Changed from `Sol High` for open architectural judgment to `Luna Medium` for a bounded high-volume mechanical pilot after the immediate next step changed. |
| TWM-M16 | pass (`runtime_multiturn16`) | Changed from compact interactive `Sol High` to matched-domain `Luna Max` after cost became material and additional tokens, steps, and likely duration became acceptable. |

Every candidate-attributable answer preserved useful prose followed by the
continuous localized three-field closing, one immediate dependency, and one
atomic configuration. None declared a permanent default or transferred a
benchmark cost outside its measured domain.

## Static validation passed

Before independent review, the comparison synchronization and structural
validator passed. The new portfolio assertions also passed; the evidence gate
then stopped only because the prior evidence record carried the old package
hash. After this record was created, the verifier was expected to stop on the
pending independent-review marker until a separate read-only reviewer passed
the package, captures, and record.

## Independent review

A separate read-only reviewer recalculated the package, raw-capture,
final-capture, and pre-record candidate hashes; checked MR-20 through MR-24 and
the exact TWM-M16 transition; inspected every closing; and reran the static
validators. The first pass rejected a conflated TWM-M16 claim, stale verifier
path assertions, an overstated MR-22 description, and a superseded candidate
identity. After those corrections, the reviewer returned PASS with no material
finding. No reviewer edited the worktree. Runtime source fidelity remains
explicitly host-unverified.

## Global parity

Not run for this candidate. Global synchronization is a later explicit install
step and is not used to establish local candidate behavior.

## Post-install runtime

Not run for this candidate. A fresh global invocation will be recorded after
the validated package is synchronized.

No commit, push, publication, global synchronization, or skills.sh installation preceded this candidate evidence record.
