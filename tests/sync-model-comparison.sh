#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fixture_root="$(mktemp -d "${TMPDIR:-/tmp}/think-with-me-sync-test.XXXXXX")"
trap 'rm -rf -- "${fixture_root}"' EXIT

mkdir -p \
  "${fixture_root}/scripts" \
  "${fixture_root}/skills/think-with-me/references"
cp "${repo_root}/scripts/sync-model-comparison.sh" "${fixture_root}/scripts/"

write_canonical() {
  printf '%s\n' \
    '# Model Matrix' \
    '' \
    'Last reviewed: **2026-07-31**.' \
    '' \
    '## Which model should I use?' \
    '| Situation | Model |' \
    '| --- | --- |' \
    '| Architecture | `Sol High` |' \
    '' \
    '## Cross-checked data' \
    '| Model | Score |' \
    '| --- | ---: |' \
    '| Sol High | 1 |' \
    '' \
    '[Detailed evidence](model-evidence.md)' \
    >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
}

write_readme_mirror() {
  local target="$1"
  local score="$2"
  printf '%s\n' \
    '# Mirror' \
    '<!-- MODEL_COMPARISON_START -->' \
    'Last reviewed: **2026-07-31**.' \
    '' \
    '## Which model should I use?' \
    '| Situation | Model |' \
    '| --- | --- |' \
    '| Architecture | `Sol High` |' \
    '' \
    '## Cross-checked data' \
    '| Model | Score |' \
    '| --- | ---: |' \
    "| Sol High | ${score} |" \
    '<!-- MODEL_COMPARISON_END -->' \
    'After block.' \
    >"${target}"
}

write_skill_mirror() {
  local target="$1"
  local model="$2"
  printf '%s\n' \
    '# Mirror' \
    '<!-- MODEL_ROUTING_SUMMARY_START -->' \
    'Last reviewed: **2026-07-31**.' \
    '' \
    '## Which model should I use?' \
    '| Situation | Model |' \
    '| --- | --- |' \
    "| Architecture | \`${model}\` |" \
    '<!-- MODEL_ROUTING_SUMMARY_END -->' \
    'After block.' \
    >"${target}"
}

write_canonical
write_readme_mirror "${fixture_root}/README.md" '1'
write_skill_mirror "${fixture_root}/skills/think-with-me/SKILL.md" 'Sol High'

bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null

write_readme_mirror "${fixture_root}/README.md" '2'
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted a stale README mirror' >&2
  exit 1
fi

bash "${fixture_root}/scripts/sync-model-comparison.sh" >/dev/null
bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null
grep -Fqx -- '# Mirror' "${fixture_root}/README.md"
grep -Fqx -- 'After block.' "${fixture_root}/README.md"
grep -Fqx -- '## Cross-checked data' "${fixture_root}/README.md"
grep -Fqx -- '<!-- MODEL_ROUTING_SUMMARY_START -->' "${fixture_root}/skills/think-with-me/SKILL.md"
grep -Fqx -- '<!-- MODEL_ROUTING_SUMMARY_END -->' "${fixture_root}/skills/think-with-me/SKILL.md"
grep -Fqx -- '| Architecture | `Sol High` |' "${fixture_root}/skills/think-with-me/SKILL.md"
if grep -Fq -- '## Cross-checked data' "${fixture_root}/skills/think-with-me/SKILL.md"; then
  echo 'FAIL: SKILL.md received progressive-disclosure benchmark data' >&2
  exit 1
fi

printf '%s\n' '# Missing markers' >"${fixture_root}/skills/think-with-me/SKILL.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted missing markers' >&2
  exit 1
fi

write_skill_mirror "${fixture_root}/skills/think-with-me/SKILL.md" 'Sol High'
printf '%s\n' '<!-- MODEL_ROUTING_SUMMARY_START -->' >>"${fixture_root}/skills/think-with-me/SKILL.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted duplicate markers' >&2
  exit 1
fi

printf '%s\n' \
  '# Mirror' \
  '<!-- MODEL_ROUTING_SUMMARY_END -->' \
  '<!-- MODEL_ROUTING_SUMMARY_START -->' \
  >"${fixture_root}/skills/think-with-me/SKILL.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted reversed markers' >&2
  exit 1
fi

write_skill_mirror "${fixture_root}/skills/think-with-me/SKILL.md" 'Sol High'
printf '%s\n' \
  '# Missing canonical heading' \
  '' \
  '## Comparison' \
  '' \
  '[Detailed evidence](model-evidence.md)' \
  >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted a canonical source without the H1 anchor' >&2
  exit 1
fi

printf '%s\n' \
  '# Model Matrix' \
  '' \
  '## Comparison' \
  '' \
  >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted a canonical source without the evidence anchor' >&2
  exit 1
fi

printf '%s\n' \
  '[Detailed evidence](model-evidence.md)' \
  '' \
  '# Model Matrix' \
  >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted reversed canonical anchors' >&2
  exit 1
fi

printf '%s\n' \
  '# Model Matrix' \
  '# Model Matrix' \
  '' \
  '[Detailed evidence](model-evidence.md)' \
  >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted duplicate canonical headings' >&2
  exit 1
fi

printf '%s\n' \
  '# Model Matrix' \
  '' \
  '## Which model should I use?' \
  '' \
  '[Detailed evidence](model-evidence.md)' \
  >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted a canonical source without the benchmark boundary' >&2
  exit 1
fi

printf '%s\n' \
  '# Model Matrix' \
  '' \
  '## Cross-checked data' \
  '## Cross-checked data' \
  '' \
  '[Detailed evidence](model-evidence.md)' \
  >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted duplicate benchmark boundaries' >&2
  exit 1
fi

printf '%s\n' \
  '## Cross-checked data' \
  '' \
  '# Model Matrix' \
  '' \
  '[Detailed evidence](model-evidence.md)' \
  >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted a benchmark boundary before the canonical heading' >&2
  exit 1
fi

echo 'Model comparison synchronization tests passed.'
