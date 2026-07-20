# Think With Me — conversational model routing evidence

RUNTIME_SOURCE_FIDELITY: host-unverified
LOCAL_CANDIDATE_STATUS: passed
INDEPENDENT_REVIEW_STATUS: passed
GLOBAL_PARITY_STATUS: not-run
POST_INSTALL_RUNTIME_STATUS: not-run

**Date:** 20 July 2026
**Scope:** bind the provisional conversational matrix, resolved-subject rule,
and phase-specific footer recommendations to the current installable package.

## Candidate

- `PACKAGE_SHA256`: `5c95c9bade33cda5dca7d2bb09bfb9994906425f9264301a88b7b64b11b33545`
- Package source: `skills/think-with-me/`.
- Base commit at capture:
  `34a1f22084c35227f9d4d1c1fccf8fb52219cb4f`.
- Runtime source requested explicitly: local candidate package; the installed
  global package was used only for the preserved RED baseline.
- Runtime source fidelity: `host-unverified`; isolated tasks received explicit
  source instructions, but the host emitted no source-selection receipt.
- Host model, effort, token, latency, step, and cost receipts: not exposed.

## Raw capture artifact

- Initial artifact:
  `evals/runtime-captures-2026-07-20-conversational-routing.md`.
- `INITIAL_RUNTIME_CAPTURES_SHA256`: `22f12479a914fe93f93ace1e4b54553c36fa2d6458930d69720aa7b71fdff7ed`
- Final artifact:
  `evals/runtime-captures-2026-07-20-conversational-routing-final.md`.
- `FINAL_RUNTIME_CAPTURES_SHA256`: `23e64b1e7e60b3156a292e02730579ce4c8904d138be9d8d9d2c906d3e62d0d3`

## Runtime behavior passed

| Case | Result | Evidence observed |
| --- | --- | --- |
| RED baseline | reproduced (`baseline_old_footer`) | The pre-sync package selected `Sol High` for a resolved, bounded confirmation with no action pending. |
| MR-25 | pass (`candidate_status`) | The candidate selected `Sol Medium`, stated that no action remained, and did not manufacture a future dependency. |
| MR-26 | pass (`candidate_terra`) | Selected `Terra Max` as a reviewable conversational pilot and rejected proven equivalence or superiority. |
| MR-27 | fail then pass (`candidate_luna`) | The initial package contradicted its disclaimer by calling the draft economic. The corrected-package rerun selected `Luna Max`, kept the review gate, treated cost only as a measurement target, and rejected transferred benchmark economics. |
| MR-28 / TWM-M17 | pass (`candidate_multiphase`) | Recomputed `Sol Medium`, `Terra Max`, and `Sol High` as the phase moved from resolved confirmation to reviewable exploration to consequential judgment. |
| MR-29 | pass (`candidate_xhigh`) | Selected `Sol XHigh` only after the prompt supplied a concrete cross-cutting ownership and authorization contradiction. |

All candidate closings preserved one localized continuous blockquote, one
actual next-step field, and one atomic configuration. Pilot routes stated their
provisional or reviewable status in prose and made no benchmark-equivalence
claim.

## Static validation passed

The synchronized-comparison check and structural validator exited `0`. The new
static conversational-routing assertions also passed; the evidence gate then
stopped only because the preceding evidence record carried the previous package
hash. After this new record was added, the verifier was expected to stop on the
pending independent-review marker until a separate read-only review completed.

## Independent review

A separate read-only reviewer rejected the first candidate because MR-27 called
the conversational draft economic despite admitting that local total cost was
unknown. The failed response remains in the initial capture. After the policy
was tightened and every new case was rerun against the corrected package, the
reviewer independently recalculated the package and capture hashes, checked all
raw closings and case claims, reran the safe validators, and returned PASS with
no material finding. No reviewer edited the worktree.

## Global parity

Not run for this candidate. The old global package intentionally remained in
place long enough to reproduce the reported baseline defect.

## Post-install runtime

Not run for this candidate. A fresh global multiphase smoke test will follow
only after local evidence and independent review pass.

No commit, push, publication, global synchronization, or skills.sh installation preceded this candidate evidence record.
