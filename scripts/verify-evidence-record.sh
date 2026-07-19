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

main() {
  local manifest
  local package_hash

  [[ -f "${evidence_file}" ]] || fail "missing evidence file: ${evidence_file#"${repo_root}/"}"

  manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
  package_hash="$(sed -n 's/^PACKAGE_SHA256=//p' <<<"${manifest}")"
  [[ -n "${package_hash}" ]] || fail "candidate manifest has no package hash"

  verify_package_hashes "${evidence_file}" "${package_hash}"
  require_heading "## Static validation passed"
  reject_heading "## Runtime behavior pending"
  require_heading "## Runtime behavior passed"
  require_heading "## Independent review"
  require_heading "## Global parity"
  require_text "No Task 4 evidence-gate implementation commit, push, publication, or global synchronization preceded this evidence record."

  echo "Behavior evidence matches the current package."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
