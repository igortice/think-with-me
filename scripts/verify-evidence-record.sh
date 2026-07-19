#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
evidence_file="${repo_root}/evals/evidence-2026-07-19-evidence-based-routing.md"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_text() {
  local pattern="$1"
  grep -Fq -- "${pattern}" "${evidence_file}" || fail "missing evidence text: ${pattern}"
}

has_heading() {
  local heading="$1"
  awk -v heading="${heading}" '
    /^[[:space:]]*(```|~~~)/ { in_fence = !in_fence; next }
    !in_fence && $0 == heading { found = 1 }
    END { exit(found ? 0 : 1) }
  ' "${evidence_file}"
}

require_heading() {
  local heading="$1"
  has_heading "${heading}" || fail "missing evidence heading: ${heading}"
}

reject_heading() {
  local heading="$1"
  if has_heading "${heading}"; then
    fail "evidence heading is still pending: ${heading}"
  fi
}

[[ -f "${evidence_file}" ]] || fail "missing evidence file: ${evidence_file#"${repo_root}/"}"

manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
package_hash="$(sed -n 's/^PACKAGE_SHA256=//p' <<<"${manifest}")"
[[ -n "${package_hash}" ]] || fail "candidate manifest has no package hash"

require_text "${package_hash}"
require_heading "## Static validation passed"
reject_heading "## Runtime behavior pending"
require_heading "## Runtime behavior passed"
require_heading "## Independent review"
require_heading "## Global parity"
require_text "No implementation commit, push, publication, or global synchronization preceded this evidence record."

echo "Behavior evidence matches the current package."
