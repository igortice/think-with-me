# Think With Me — evidence for Luna cost routing and price overlay

Date: 2026-07-31

RUNTIME_SOURCE_FIDELITY: host-unverified
LOCAL_CANDIDATE_STATUS: passed
INDEPENDENT_REVIEW_STATUS: passed
GLOBAL_PARITY_STATUS: not-run
POST_INSTALL_RUNTIME_STATUS: not-run

No Task 4 evidence-gate implementation commit, push, publication, global synchronization, or skills.sh installation preceded this evidence record.

## Candidate identity

- `PACKAGE_SHA256`: `d57b7b39bcd29bfed7ccaed692f9257ca4150150d3d13881a5113d32b8e034f5`
- `INITIAL_RUNTIME_CAPTURES_SHA256`: `7115aa0458deb904b665c61661362df3aec45c06e509eb13c01b4ea2fe9db6ae`
- `FINAL_RUNTIME_CAPTURES_SHA256`: `7115aa0458deb904b665c61661362df3aec45c06e509eb13c01b4ea2fe9db6ae`

The package manifest was generated from the complete uncommitted worktree at
base commit `c3a7a13c9a0f6ef112051b679e817ef86f889ac1`.
The immutable historical snapshot
`skills/think-with-me/references/model-evidence-2026-07-20.md` retains SHA-256
`13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8`.

## Static validation passed

The local candidate passed the synchronized model-comparison check and test,
source-data verification, strong routing semantic gate, focused install-record
verifier, structure and skill validation, candidate evidence verifier, shell
syntax, and whitespace validation. These checks cover the exact six-pair
allowlist, mutually exclusive routing, preserved historical source data,
current price overlays, and structural binding of the package and both capture
hashes. The all-in release gate remains a separate Phase C check because its
install record and global runtime are intentionally not refreshed here.

## Runtime behavior passed

Five isolated evaluators were instructed to use the repository-local skill
package and not inspect eval fixtures or expected answers. Their identities and
fresh forward-test results were:

1. `019fb966-bbf9-7100-b3a9-0d9c81518b1d` — asked exactly one decisive
   cost-first-versus-quality-first question and emitted no model footer;
2. `019fb966-bee1-7a23-9602-36ad2730be01` — selected `Luna Max` for qualified
   cost-first, asynchronous, reversible, reviewed execution;
3. `019fb966-bd53-7233-a556-e5a3dd718dc2` — selected `Terra Max` for qualified
   quality-first heterogeneous and interdependent execution;
4. `019fb966-c0a9-7ce0-9b1a-db043b641619` — did not select `Sol Max` for a
   direct maximum-depth request without bounded risk or prior selective failure;
5. `019fb967-c708-7a30-b5e9-bbfc13d66f58` — selected `Sol Max` for the same
   bounded critical risk after a narrower `Sol XHigh` investigation failed.

The supplied runtime artifact records five fresh forward tests with `Passed:
5/5` and `Failed: 0/5`. Both repository capture files preserve that supplied
artifact byte-for-byte; the duplicate capture is not evidence of a second run.

The artifact identifies the repository-local package requested by the
evaluators but does not contain a host attestation of the active runtime model.
Runtime source fidelity therefore remains `host-unverified`.

## Independent review

Reviewer `019fb96a-1391-70f1-a120-482fa3dc2c23` performed the separate
read-only review using `gpt-5.6-sol` at `max` reasoning effort and returned
`INDEPENDENT_REVIEW_STATUS: passed` with no findings.

The review confirmed:

- eligibility is exactly `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`,
  `Terra Max`, and `Luna Max`;
- the six routing rows are mutually exclusive, including explicit
  priority-based Terra/Luna resolution and the no-footer exception while that
  decisive priority is unknown;
- direct maximum-depth requests do not bypass the failed-selective-route
  requirement, while the same bounded risk can select `Sol Max` after the
  narrower investigation fails;
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
