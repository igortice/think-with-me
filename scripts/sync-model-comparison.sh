#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="${repo_root}/skills/think-with-me/references/model-comparison.md"
comparison_start_marker='<!-- MODEL_COMPARISON_START -->'
comparison_end_marker='<!-- MODEL_COMPARISON_END -->'
routing_start_marker='<!-- MODEL_ROUTING_SUMMARY_START -->'
routing_end_marker='<!-- MODEL_ROUTING_SUMMARY_END -->'
source_title='# Model Matrix'
benchmark_heading='## Cross-checked data'
source_end_anchor='[Detailed evidence](model-evidence.md)'
mode='write'

if [[ "${1:-}" == '--check' ]]; then
  mode='check'
elif [[ -n "${1:-}" ]]; then
  echo "Usage: bash scripts/sync-model-comparison.sh [--check]" >&2
  exit 2
fi

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_single_marker() {
  local file="$1"
  local marker="$2"
  local count
  count="$(grep -Fxc -- "${marker}" "${file}" || true)"
  [[ "${count}" == '1' ]] || fail "expected one '${marker}' marker in ${file#"${repo_root}/"}; found ${count}"
}

require_ordered_markers() {
  local file="$1"
  local start_marker="$2"
  local end_marker="$3"
  awk -v start="${start_marker}" -v end="${end_marker}" '
    $0 == start { start_line = NR }
    $0 == end { end_line = NR }
    END { exit !(start_line > 0 && end_line > start_line) }
  ' "${file}" || fail "end marker must follow start marker in ${file#"${repo_root}/"}"
}

[[ -f "${source_file}" ]] || fail 'missing canonical model comparison'

title_count="$(grep -Fxc -- "${source_title}" "${source_file}" || true)"
[[ "${title_count}" == '1' ]] || \
  fail "expected one canonical '${source_title}' heading; found ${title_count}"

end_anchor_count="$(grep -Fc -- "${source_end_anchor}" "${source_file}" || true)"
[[ "${end_anchor_count}" == '1' ]] || \
  fail "expected one canonical '${source_end_anchor}' anchor; found ${end_anchor_count}"

benchmark_heading_count="$(grep -Fxc -- "${benchmark_heading}" "${source_file}" || true)"
[[ "${benchmark_heading_count}" == '1' ]] || \
  fail "expected one canonical '${benchmark_heading}' heading; found ${benchmark_heading_count}"

title_line="$(grep -Fnx -- "${source_title}" "${source_file}" | cut -d: -f1)"
benchmark_heading_line="$(grep -Fnx -- "${benchmark_heading}" "${source_file}" | cut -d: -f1)"
end_anchor_line="$(grep -Fn -- "${source_end_anchor}" "${source_file}" | cut -d: -f1)"
[[ "${end_anchor_line}" -gt "${title_line}" ]] || \
  fail 'canonical evidence anchor must follow the model-matrix heading'
[[ "${benchmark_heading_line}" -gt "${title_line}" && "${benchmark_heading_line}" -lt "${end_anchor_line}" ]] || \
  fail 'canonical benchmark heading must follow the model-matrix heading and precede the evidence anchor'

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/think-with-me-model-comparison.XXXXXX")"
trap 'rm -rf -- "${tmp_dir}"' EXIT
public_body="${tmp_dir}/public-body.md"
routing_body="${tmp_dir}/routing-body.md"
comparison_block="${tmp_dir}/comparison.md"
routing_block="${tmp_dir}/routing.md"

awk -v first="${title_line}" -v last="${end_anchor_line}" '
  NR > first && NR < last { lines[++count] = $0 }
  END {
    start = 1
    while (start <= count && lines[start] ~ /^[[:space:]]*$/) start++
    finish = count
    while (finish >= start && lines[finish] ~ /^[[:space:]]*$/) finish--
    for (i = start; i <= finish; i++) print lines[i]
  }
' "${source_file}" >"${public_body}"

grep -Eq '[^[:space:]]' "${public_body}" || fail 'canonical model comparison body is empty'

awk -v first="${title_line}" -v last="${benchmark_heading_line}" '
  NR > first && NR < last { lines[++count] = $0 }
  END {
    start = 1
    while (start <= count && lines[start] ~ /^[[:space:]]*$/) start++
    finish = count
    while (finish >= start && lines[finish] ~ /^[[:space:]]*$/) finish--
    for (i = start; i <= finish; i++) print lines[i]
  }
' "${source_file}" >"${routing_body}"

grep -Eq '[^[:space:]]' "${routing_body}" || fail 'canonical model routing summary is empty'

{
  printf '%s\n' "${comparison_start_marker}"
  cat "${public_body}"
  printf '%s\n' "${comparison_end_marker}"
} >"${comparison_block}"

{
  printf '%s\n' "${routing_start_marker}"
  cat "${routing_body}"
  printf '%s\n' "${routing_end_marker}"
} >"${routing_block}"

render_target() {
  local target="$1"
  local start_marker="$2"
  local end_marker="$3"
  local block="$4"
  local label="$5"
  [[ -f "${target}" ]] || fail "missing mirror: ${target#"${repo_root}/"}"
  require_single_marker "${target}" "${start_marker}"
  require_single_marker "${target}" "${end_marker}"
  require_ordered_markers "${target}" "${start_marker}" "${end_marker}"

  local rendered="${tmp_dir}/$(basename "${target}").rendered"
  awk -v start="${start_marker}" -v end="${end_marker}" -v block="${block}" '
    $0 == start {
      while ((getline line < block) > 0) {
        print line
      }
      close(block)
      replacing = 1
      next
    }
    replacing && $0 == end {
      replacing = 0
      next
    }
    !replacing { print }
  ' "${target}" >"${rendered}"

  if [[ "${mode}" == 'check' ]]; then
    if ! cmp -s "${target}" "${rendered}"; then
      echo "FAIL: ${label} mirror is stale: ${target#"${repo_root}/"}" >&2
      diff -u "${target}" "${rendered}" || true
      exit 1
    fi
  else
    mv "${rendered}" "${target}"
  fi
}

render_target \
  "${repo_root}/README.md" \
  "${comparison_start_marker}" \
  "${comparison_end_marker}" \
  "${comparison_block}" \
  'model comparison'

render_target \
  "${repo_root}/skills/think-with-me/SKILL.md" \
  "${routing_start_marker}" \
  "${routing_end_marker}" \
  "${routing_block}" \
  'model routing summary'

if [[ "${mode}" == 'check' ]]; then
  echo 'Model comparison projections are synchronized.'
else
  echo 'Model comparison projections updated.'
fi
