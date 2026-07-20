# Model comparison refresh contract

**Date:** 2026-07-20
**Status:** approved in conversation for implementation before the release commit

## Goal

Keep the public model quality-and-cost tables auditable and easy to refresh
without turning the visual presentation into the source of truth.

## Design

The Markdown comparison inside
`skills/think-with-me/references/model-comparison.md` is the canonical public
view. The matching sections in `README.md` and `skills/think-with-me/SKILL.md`
are synchronized copies, bounded by stable markers and checked automatically.

The canonical reference also carries a refresh contract that records:

- the snapshot date and the rule that historical snapshots are immutable;
- the exact Artificial Analysis ten-configuration filter and both selected
  tabs;
- the DeepSWE raw leaderboard endpoint;
- which values are source fields and which values are derived calculations;
- the files and validation commands required for a refresh.

A repository-only synchronization script copies the canonical Markdown block
to the two public mirrors and supports a check-only mode. It does not scrape
or reinterpret benchmark websites. New external results must first be
reviewed as a new dated evidence snapshot, because the source methodology,
harness, metrics, or model set may have changed.

## Boundaries

- Keep DeepSWE and Artificial Analysis separate; do not create a composite
  score.
- Keep the tables as Markdown; no image is required for the public contract.
- Preserve screenshots and hashes as historical release evidence, not as
  installable runtime dependencies.
- Do not silently replace the 2026-07-19 snapshot with live values.
- Do not commit until the user-requested final review is complete.

## Validation

- The sync script must fail when a marker is missing or duplicated.
- Check mode must fail when either public mirror differs from the canonical
  block.
- The evidence gate must require the exact source URLs, refresh contract,
  synchronization script, and a clean synchronization check.
- Existing structural and evidence validation must continue to pass.
