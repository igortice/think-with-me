#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
verifier="${repo_root}/scripts/verify-install-record.sh"
fixture_root="$(mktemp -d "${TMPDIR:-/tmp}/think-with-me-install-record.XXXXXX")"
trap 'rm -rf -- "${fixture_root}"' EXIT

expected_hash='1111111111111111111111111111111111111111111111111111111111111111'
wrong_hash='2222222222222222222222222222222222222222222222222222222222222222'

write_record() {
  local target="$1"
  local package_hash="$2"
  local parity_status="$3"
  local runtime_status="$4"
  local transition="$5"

  printf '%s\n' \
    '# Global installation verification' \
    '' \
    'Date: 2026-07-31' \
    "Candidate package: \`${package_hash}\`" \
    '' \
    '## Result' \
    '' \
    "GLOBAL_PARITY_STATUS: ${parity_status}" \
    "POST_INSTALL_RUNTIME_STATUS: ${runtime_status}" \
    '' \
    '## Observed transition' \
    '' \
    "${transition}" >"${target}"
}

expect_rejected() {
  local label="$1"
  local record="$2"

  if bash "${verifier}" "${record}" "${expected_hash}" >/dev/null 2>&1; then
    echo "FAIL: install-record verifier accepted ${label}" >&2
    exit 1
  fi
}

valid_record="${fixture_root}/valid.md"
write_record "${valid_record}" "${expected_hash}" 'passed' 'passed' '`Sol Medium` → `Luna Max` → `Sol High`'
bash "${verifier}" "${valid_record}" "${expected_hash}" >/dev/null

wrong_hash_record="${fixture_root}/wrong-hash.md"
write_record "${wrong_hash_record}" "${wrong_hash}" 'passed' 'passed' '`Sol Medium` → `Luna Max` → `Sol High`'
expect_rejected 'a stale candidate package hash' "${wrong_hash_record}"

parity_not_run_record="${fixture_root}/parity-not-run.md"
write_record "${parity_not_run_record}" "${expected_hash}" 'not-run' 'passed' '`Sol Medium` → `Luna Max` → `Sol High`'
expect_rejected 'GLOBAL_PARITY_STATUS other than passed' "${parity_not_run_record}"

runtime_not_run_record="${fixture_root}/runtime-not-run.md"
write_record "${runtime_not_run_record}" "${expected_hash}" 'passed' 'not-run' '`Sol Medium` → `Luna Max` → `Sol High`'
expect_rejected 'POST_INSTALL_RUNTIME_STATUS other than passed' "${runtime_not_run_record}"

wrong_transition_record="${fixture_root}/wrong-transition.md"
write_record "${wrong_transition_record}" "${expected_hash}" 'passed' 'passed' '`Sol Medium` → `Terra Max`'
expect_rejected 'the wrong routing transition' "${wrong_transition_record}"

echo 'Install-record verifier tests passed.'
