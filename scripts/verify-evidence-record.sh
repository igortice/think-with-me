#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
evidence_file="${repo_root}/evals/evidence-2026-07-18-context-aware-next-step.md"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_text() {
  local pattern="$1"
  grep -Fq -- "${pattern}" "${evidence_file}" || fail "missing evidence text: ${pattern}"
}

[[ -f "${evidence_file}" ]] || fail "missing evidence file: ${evidence_file#"${repo_root}/"}"

manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
package_hash="$(sed -n 's/^PACKAGE_SHA256=//p' <<<"${manifest}")"
[[ -n "${package_hash}" ]] || fail "candidate manifest has no package hash"

require_text "${package_hash}"
require_text "## Forward test passed"
require_text "Global think-with-me installation matches the repository source."
require_text "No implementation commit, push, or publication was made before this evidence record."

echo "Behavior evidence matches the current package."
