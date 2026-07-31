#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

usage() {
  echo "Usage: bash scripts/verify-install-record.sh <install-record.md> <expected-package-sha256>" >&2
  exit 2
}

[[ "$#" -eq 2 ]] || usage
install_record="$1"
expected_package_hash="$2"

[[ -f "${install_record}" ]] || fail "missing install record: ${install_record}"
[[ "${expected_package_hash}" =~ ^[0-9a-f]{64}$ ]] || fail 'expected package SHA-256 is malformed'

# Reuse the source-safe Markdown parser so fenced runtime output cannot satisfy
# release status or identity checks.
source "${repo_root}/scripts/verify-evidence-record.sh"

top_level_lines="$(markdown_top_level_lines "${install_record}")"

require_exact_top_level_line() {
  local expected="$1"
  local label="$2"
  local count

  count="$(grep -Fxc -- "${expected}" <<<"${top_level_lines}" || true)"
  [[ "${count}" == '1' ]] || fail "install record must contain exactly one ${label}: ${expected}"
}

require_exact_top_level_line 'Date: 2026-07-31' 'current date'
require_exact_top_level_line "Candidate package: \`${expected_package_hash}\`" 'candidate package hash'
require_exact_top_level_line 'GLOBAL_PARITY_STATUS: passed' 'global parity status'
require_exact_top_level_line 'POST_INSTALL_RUNTIME_STATUS: passed' 'post-install runtime status'
require_exact_top_level_line '`Sol Medium` → `Luna Max` → `Sol High`' 'routing transition'

candidate_line_count="$(grep -Ec '^Candidate package: ' <<<"${top_level_lines}" || true)"
parity_line_count="$(grep -Ec '^GLOBAL_PARITY_STATUS: ' <<<"${top_level_lines}" || true)"
runtime_line_count="$(grep -Ec '^POST_INSTALL_RUNTIME_STATUS: ' <<<"${top_level_lines}" || true)"
[[ "${candidate_line_count}" == '1' ]] || fail 'install record contains missing, duplicate, or malformed candidate package fields'
[[ "${parity_line_count}" == '1' ]] || fail 'install record contains missing, duplicate, or malformed global parity fields'
[[ "${runtime_line_count}" == '1' ]] || fail 'install record contains missing, duplicate, or malformed post-install runtime fields'

echo 'Install record is bound to the expected package, passed release statuses, and routing transition.'
