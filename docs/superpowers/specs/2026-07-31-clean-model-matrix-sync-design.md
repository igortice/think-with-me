# Clean Model Matrix Synchronization Design

**Date:** 2026-07-31
**Status:** approved conversational design; pending written-spec review

## Objective

Keep the installed `model-comparison.md` free of technical synchronization
comments while preserving deterministic synchronization with `README.md` and
`skills/think-with-me/SKILL.md`.

## Design

`skills/think-with-me/references/model-comparison.md` remains the canonical,
user-facing matrix and contains only readable Markdown. It starts with exactly
one `# Model Matrix` heading and ends with the existing `Detailed evidence`
link. It contains no `MODEL_COMPARISON_START` or `MODEL_COMPARISON_END`
comments.

`scripts/sync-model-comparison.sh` extracts the public body after the canonical
H1 and before the detailed-evidence link. The script validates that both
anchors exist exactly once and in the expected order. It then replaces the
content between the existing technical markers in `README.md` and
`skills/think-with-me/SKILL.md`.

The target markers remain because they provide a deterministic replacement
boundary. They do not appear in the matrix opened from the response footer.

## Failure behavior

Synchronization fails without writing files when:

- the canonical H1 is missing or duplicated;
- the detailed-evidence link is missing or duplicated;
- the anchors are reversed;
- the extracted body is empty;
- either target has missing, duplicated, or reversed replacement markers.

## Verification

Update the synchronization fixture and documentation gates to require:

- no synchronization markers in `model-comparison.md`;
- exactly one canonical H1 and detailed-evidence link;
- identical extracted matrix content in `README.md` and `SKILL.md`;
- successful `--check` behavior and rejection of malformed fixtures;
- repository/global installation parity after synchronization;
- a clean installed matrix when opened through `Ver matriz` or `View matrix`.

## Non-goals

- Removing the replacement markers from `README.md` or `SKILL.md`.
- Changing model recommendations, benchmark values, or routing policy.
- Adding another generated matrix file or another language variant.
