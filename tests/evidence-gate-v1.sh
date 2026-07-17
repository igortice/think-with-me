#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_file() {
  [[ -f "$1" ]] || fail "missing file: ${1#"${repo_root}/"}"
}

require_text() {
  local file="$1"
  local pattern="$2"
  grep -Fq -- "$pattern" "$file" || fail "missing text in ${file#"${repo_root}/"}: $pattern"
}

require_file "${repo_root}/scripts/candidate-manifest.sh"
require_file "${repo_root}/scripts/validate-structure.sh"
require_file "${repo_root}/evals/evidence-run-template.md"

manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
grep -Fq 'CANDIDATE_ID=' <<<"${manifest}" || fail "candidate manifest has no candidate id"
grep -Fq 'PACKAGE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no package hash"
grep -Fq 'FILE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no file hashes"

require_text "${repo_root}/skills/think-with-me/SKILL.md" '## Authority and precedence'
require_text "${repo_root}/skills/think-with-me/references/model-routing.md" 'Approved execution handoff'
require_text "${repo_root}/skills/think-with-me/references/output-contract.md" 'next-task routing'
require_text "${repo_root}/scripts/validate-structure.sh" 'Structural validation passed.'

if grep -Fq 'Public-release validation passed.' "${repo_root}/scripts/validate-skill.sh"; then
  fail "legacy validator still claims public-release validation"
fi

echo "Evidence Gate v1 checks passed."
