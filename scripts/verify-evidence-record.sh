#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
evidence_file="${repo_root}/evals/evidence-2026-07-20-model-comparison-routing.md"
initial_captures_file="${repo_root}/evals/runtime-captures-2026-07-20.md"
final_captures_file="${repo_root}/evals/runtime-captures-2026-07-20-final.md"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

markdown_top_level_lines() {
  local file="$1"
  awk '
    {
      line = $0
      content = line
      indent = 0
      while (substr(content, 1, 1) == " " && indent < 4) {
        content = substr(content, 2)
        indent++
      }

      fence_char_candidate = substr(content, 1, 1)
      fence_length_candidate = 0
      while (fence_char_candidate != "" && \
        substr(content, fence_length_candidate + 1, 1) == fence_char_candidate) {
        fence_length_candidate++
      }
      suffix = substr(content, fence_length_candidate + 1)

      if (!in_fence) {
        is_fence_char = fence_char_candidate == "`" || fence_char_candidate == "~"
        backtick_info_is_valid = fence_char_candidate != "`" || index(suffix, "`") == 0
        if (indent <= 3 && is_fence_char && fence_length_candidate >= 3 && backtick_info_is_valid) {
          in_fence = 1
          fence_char = fence_char_candidate
          fence_length = fence_length_candidate
          next
        }

        if (indent <= 3) {
          print content
        }
        next
      }

      closes_fence = indent <= 3 && fence_char_candidate == fence_char && \
        fence_length_candidate >= fence_length && suffix ~ /^[[:space:]]*$/
      if (closes_fence) {
        in_fence = 0
      }
    }
  ' "${file}"
}

has_heading_in_file() {
  local file="$1"
  local heading="$2"
  markdown_top_level_lines "${file}" | awk -v heading="${heading}" '
    $0 == heading { found = 1 }
    END { exit(found ? 0 : 1) }
  '
}

has_top_level_line_in_file() {
  local file="$1"
  local expected="$2"
  markdown_top_level_lines "${file}" | awk -v expected="${expected}" '
    $0 == expected { found = 1 }
    END { exit(found ? 0 : 1) }
  '
}

require_top_level_line() {
  local expected="$1"
  has_top_level_line_in_file "${evidence_file}" "${expected}" || \
    fail "missing top-level evidence line: ${expected}"
}

require_heading() {
  local heading="$1"
  has_heading_in_file "${evidence_file}" "${heading}" || fail "missing evidence heading: ${heading}"
}

reject_heading() {
  local heading="$1"
  if has_heading_in_file "${evidence_file}" "${heading}"; then
    fail "evidence heading is still pending: ${heading}"
  fi
}

verify_package_hashes() {
  local file="$1"
  local package_hash="$2"
  local hash_line_pattern='^- `PACKAGE_SHA256`: `([0-9A-Fa-f]{64})`$'
  local line
  local recorded_hash
  local hash_count=0

  [[ "${package_hash}" =~ ^[0-9a-f]{64}$ ]] || fail "candidate manifest package hash is malformed"

  while IFS= read -r line; do
    if [[ "${line}" =~ ${hash_line_pattern} ]]; then
      recorded_hash="${BASH_REMATCH[1]}"
      hash_count=$((hash_count + 1))
      [[ "${recorded_hash}" == "${package_hash}" ]] || \
        fail "evidence contains a conflicting package hash: ${recorded_hash}"
    elif [[ "${line}" == *"PACKAGE_SHA256"* ]]; then
      fail "evidence contains a malformed package hash line: ${line}"
    fi
  done < <(markdown_top_level_lines "${file}")

  [[ "${hash_count}" -gt 0 ]] || fail "evidence contains no structured package hash lines"
}

verify_runtime_capture_hash() {
  local evidence="$1"
  local captures="$2"
  local field="$3"
  local hash_line_pattern="^- \`${field}\`: \`([0-9A-Fa-f]{64})\`$"
  local line
  local expected
  local actual
  local hash_count=0

  [[ -f "${captures}" ]] || fail "missing runtime capture artifact: ${captures#"${repo_root}/"}"
  while IFS= read -r line; do
    if [[ "${line}" =~ ${hash_line_pattern} ]]; then
      expected="${BASH_REMATCH[1]}"
      hash_count=$((hash_count + 1))
    fi
  done < <(markdown_top_level_lines "${evidence}")
  [[ "${hash_count}" -eq 1 && "${expected}" =~ ^[0-9a-f]{64}$ ]] || \
    fail "evidence must contain exactly one valid ${field} field"
  actual="$(shasum -a 256 "${captures}" | awk '{print $1}')"
  [[ "${actual}" == "${expected}" ]] || \
    fail "runtime capture hash mismatch: expected ${expected}, got ${actual}"
}

main() {
  local manifest
  local package_hash

  [[ -f "${evidence_file}" ]] || fail "missing evidence file: ${evidence_file#"${repo_root}/"}"

  manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
  package_hash="$(sed -n 's/^PACKAGE_SHA256=//p' <<<"${manifest}")"
  [[ -n "${package_hash}" ]] || fail "candidate manifest has no package hash"

  verify_package_hashes "${evidence_file}" "${package_hash}"
  verify_runtime_capture_hash "${evidence_file}" "${initial_captures_file}" "INITIAL_RUNTIME_CAPTURES_SHA256"
  verify_runtime_capture_hash "${evidence_file}" "${final_captures_file}" "FINAL_RUNTIME_CAPTURES_SHA256"
  require_heading "## Static validation passed"
  reject_heading "## Runtime behavior pending"
  require_heading "## Runtime behavior passed"
  require_heading "## Independent review"
  require_heading "## Global parity"
  require_heading "## Post-install runtime"
  require_top_level_line "RUNTIME_SOURCE_FIDELITY: host-unverified"
  require_top_level_line "LOCAL_CANDIDATE_STATUS: passed"
  require_top_level_line "INDEPENDENT_REVIEW_STATUS: passed"
  require_top_level_line "GLOBAL_PARITY_STATUS: not-run"
  require_top_level_line "POST_INSTALL_RUNTIME_STATUS: not-run"
  require_top_level_line "No commit, push, publication, global synchronization, or skills.sh installation preceded this candidate evidence record."

  echo "Local evidence is bound to the current package; global parity and post-install runtime remain separate release checks."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
