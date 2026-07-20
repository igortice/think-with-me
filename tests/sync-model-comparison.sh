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
    '# Canonical' \
    '<!-- MODEL_COMPARISON_START -->' \
    '## Comparison' \
    '| Model | Score |' \
    '| --- | ---: |' \
    '| Sol High | 1 |' \
    '<!-- MODEL_COMPARISON_END -->' \
    >"${fixture_root}/skills/think-with-me/references/model-comparison.md"
}

write_mirror() {
  local target="$1"
  local score="$2"
  printf '%s\n' \
    '# Mirror' \
    '<!-- MODEL_COMPARISON_START -->' \
    '## Comparison' \
    '| Model | Score |' \
    '| --- | ---: |' \
    "| Sol High | ${score} |" \
    '<!-- MODEL_COMPARISON_END -->' \
    'After block.' \
    >"${target}"
}

write_canonical
write_mirror "${fixture_root}/README.md" '1'
write_mirror "${fixture_root}/skills/think-with-me/SKILL.md" '1'

bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null

write_mirror "${fixture_root}/README.md" '2'
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted a stale README mirror' >&2
  exit 1
fi

bash "${fixture_root}/scripts/sync-model-comparison.sh" >/dev/null
bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null
grep -Fqx -- '# Mirror' "${fixture_root}/README.md"
grep -Fqx -- 'After block.' "${fixture_root}/README.md"

printf '%s\n' '# Missing markers' >"${fixture_root}/skills/think-with-me/SKILL.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted missing markers' >&2
  exit 1
fi

write_mirror "${fixture_root}/skills/think-with-me/SKILL.md" '1'
printf '%s\n' '<!-- MODEL_COMPARISON_START -->' >>"${fixture_root}/skills/think-with-me/SKILL.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted duplicate markers' >&2
  exit 1
fi

printf '%s\n' \
  '# Mirror' \
  '<!-- MODEL_COMPARISON_END -->' \
  '<!-- MODEL_COMPARISON_START -->' \
  >"${fixture_root}/skills/think-with-me/SKILL.md"
if bash "${fixture_root}/scripts/sync-model-comparison.sh" --check >/dev/null 2>&1; then
  echo 'FAIL: check mode accepted reversed markers' >&2
  exit 1
fi

echo 'Model comparison synchronization tests passed.'
