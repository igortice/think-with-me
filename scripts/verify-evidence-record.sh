#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
evidence_file="${repo_root}/evals/evidence-2026-07-18-public-readiness.md"

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
require_text "## Contract validation passed"
require_text "## Runtime limitation"
require_text "Instalação global de referência:"
require_text "release anterior"
require_text "Current candidate has not been synchronized globally."
require_text "No implementation commit, push, or publication was made before this evidence record."

echo "Behavior evidence matches the current package."
