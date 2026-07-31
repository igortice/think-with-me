# Think With Me — evidence for Luna cost routing and price overlay

Date: 2026-07-31

RUNTIME_SOURCE_FIDELITY: host-unverified
LOCAL_CANDIDATE_STATUS: passed
INDEPENDENT_REVIEW_STATUS: passed
GLOBAL_PARITY_STATUS: not-run
POST_INSTALL_RUNTIME_STATUS: not-run

No Task 4 evidence-gate implementation commit, push, publication, global synchronization, or skills.sh installation preceded this evidence record.

## Candidate identity

- `PACKAGE_SHA256`: `385a116e36937adaa3f42d1fe7fc8cc9bf998e8a0217a2dd830e3494f96ffe36`
- `INITIAL_RUNTIME_CAPTURES_SHA256`: `fc5d12557df87e14b4a2195e4f4289467a84f497cd2478a94811142774ef60cd`
- `FINAL_RUNTIME_CAPTURES_SHA256`: `9e786a746475c13f6269648929e35b0641102defc19b16376ee75b8eae6de712`

The package manifest was generated only after the installable package was clean
and complete at base commit `ff8e6448661141be8676904ab5bdae82ad9e604b`.
The immutable historical snapshot
`skills/think-with-me/references/model-evidence-2026-07-20.md` retains SHA-256
`13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8`.

## Static validation passed

The local candidate passed the synchronized model-comparison check and test,
source-data verification, strong routing semantic gate, skill validation,
full evidence gate, evidence verifier, and whitespace validation. These checks
cover the exact six-pair allowlist, mutually exclusive routing, preserved
historical source data, current price overlays, host-control boundary, and
structural binding of the package and both capture hashes.

## Runtime behavior passed

Five isolated, read-only evaluators loaded the exact local candidate paths
`skills/think-with-me/SKILL.md`,
`skills/think-with-me/references/model-routing.md`, and
`skills/think-with-me/references/output-contract.md`. Their identities and
first-pass routes were:

1. `019fb92b-47cd-71a0-bbbc-25cd61aabd13` — `Sol Medium` for interactive
   architecture discovery;
2. `019fb92b-4664-7e31-8b0f-4f7c7b110d46` — `Luna Max` for asynchronous,
   open-ended, reversible, cost-first execution;
3. `019fb92b-4503-7c01-be3f-8bd29250d0e4` — `Terra Max` for quality-first
   heterogeneous execution with a closed contract;
4. `019fb92b-4d4e-7ca0-85c9-7b608b734d6c` — `Sol High` when consequential
   judgment appeared during a Luna batch;
5. `019fb92b-4ae5-75a3-b3da-6517ae62bfcf` — `Sol High` preserved across the
   host-model unavailability boundary.

All five first-pass outputs passed. Their raw text is preserved unedited in the
initial capture. The final capture organizes those same passing outputs and
evaluator identities; it does not represent a second run. There was no policy
rewrite and no rerun.

The host-unavailability output did not claim that the skill selected, retried,
blocked, replaced, or verified the host model. Because the host did not attest
its active model, runtime source fidelity remains `host-unverified`.

## Independent review

Reviewer `019fb92c-edff-7b61-be67-c0e9e7a8601c` performed the separate
read-only review and returned `INDEPENDENT_REVIEW_STATUS: passed` with no
critical, important, or minor findings.

The review confirmed:

- eligibility is exactly `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`,
  `Terra Max`, and `Luna Max`;
- the six routing rows are mutually exclusive, including explicit
  priority-based Terra/Luna resolution and the Luna stop at consequential
  judgment;
- every evaluator output has one continuous three-field closing and one atomic
  recommendation;
- DeepSWE Pass@1, uncertainty, output tokens, and steps retain their July
  trajectory provenance;
- only displayed Luna Max and Terra Max costs are repriced, as an overlay;
- `3.0281 × 0.20` rounds to `$0.61` and `4.9458 × 0.80` rounds to `$3.96`,
  while non-overlay historical costs are retained;
- Artificial Analysis remains a separate source, domain, harness, table, and
  uncertainty regime and is not averaged with DeepSWE;
- the historical snapshot hash is
  `13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8`;
- repricing is not described as a benchmark or capability rerun.

## Global parity

Not run. This record binds only the local candidate package and supplied
isolated evaluator evidence. It makes no claim about global installation
parity.

## Post-install runtime

Not run. No global synchronization or post-install name-based runtime check is
part of this candidate evidence record.
