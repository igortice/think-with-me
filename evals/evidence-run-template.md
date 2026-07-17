# Think With Me — evidence run record

Use one copy of this template for each behavioral-evaluation run. A structural pass proves package integrity; this record captures whether the installed skill actually followed its conversational contract.

## Candidate

- `candidate_id`:
- `base_commit`:
- `package_sha256`:
- evaluator and date:
- installed path tested:

Generate the first three values immediately before the run:

```bash
bash scripts/candidate-manifest.sh
```

## Run

- case ID:
- invocation used:
- actual transcript or stable transcript link:
- expected observable behavior:
- verdict: pass / fail / inconclusive

## Criteria

| Criterion | Result | Evidence |
|---|---|---|
| Correct approval boundary | | |
| Correct point of view and concrete next step | | |
| Exactly one applicable routing statement | | |
| Correct model, effort, and availability qualifier | | |
| Correct bounded-subagent recommendation or decisive non-use reason | | |
| No unsupported claim about the currently selected model | | |

## Notes

Record any environment issue, ambiguity in the fixture, or contract gap here. Do not replace a failed run with a new transcript: preserve the failure and create a separate record for the correction.
