#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
evidence_file="${repo_root}/evals/evidence-2026-07-17-next-step-contract.md"

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
require_text "## Veredito final"
require_text "paridade global e invocação global final"
require_text "Nenhum commit, push ou publicação foi realizado."

echo "Behavior evidence matches the current package."
