# Clean Model Matrix Synchronization Design

**Date:** 2026-07-31
**Status:** approved; amended on 2026-08-14 for progressive disclosure

## Objective

Keep the installed `model-comparison.md` free of technical synchronization
comments while producing deterministic, purpose-specific projections for the
public README and the operational `SKILL.md`.

## Design

`skills/think-with-me/references/model-comparison.md` remains the canonical,
user-facing matrix and contains only readable Markdown. It starts with exactly
one `# Model Matrix` heading and ends with the existing `Detailed evidence`
link. It contains no `MODEL_COMPARISON_START` or `MODEL_COMPARISON_END`
comments.

`scripts/sync-model-comparison.sh` extracts the public body after the canonical
H1 and before the detailed-evidence link for `README.md`. For
`skills/think-with-me/SKILL.md`, it extracts only the reviewed date and
`Which model should I use?` section before `Cross-checked data`. The script
validates all three headings/anchors exactly once and in the expected order.

The README uses `MODEL_COMPARISON_START` and `MODEL_COMPARISON_END`. The skill
uses `MODEL_ROUTING_SUMMARY_START` and `MODEL_ROUTING_SUMMARY_END`, making the
different projection explicit. Benchmark rows remain available through
`references/model-comparison.md` and are not loaded on every skill turn.

The target markers remain because they provide a deterministic replacement
boundary. They do not appear in the matrix opened from the response footer.

## Failure behavior

Synchronization fails without writing files when:

- the canonical H1 is missing or duplicated;
- the `Cross-checked data` heading is missing, duplicated, or out of order;
- the detailed-evidence link is missing or duplicated;
- the anchors are reversed;
- the extracted body is empty;
- either target has missing, duplicated, or reversed replacement markers.

## Verification

Update the synchronization fixture and documentation gates to require:

- no synchronization markers in `model-comparison.md`;
- exactly one canonical H1 and detailed-evidence link;
- the complete extracted comparison in `README.md`;
- only the reviewed date and routing summary in `SKILL.md`;
- absence of benchmark rows and notes from the always-loaded skill core;
- successful `--check` behavior and rejection of malformed fixtures;
- repository/global installation parity after synchronization;
- a clean installed matrix when opened through `Ver matriz` or `View matrix`.

## Non-goals

- Removing the replacement markers from `README.md` or `SKILL.md`.
- Changing model recommendations, benchmark values, or routing policy.
- Adding another generated matrix file or another language variant.
