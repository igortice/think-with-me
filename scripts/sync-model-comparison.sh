#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="${repo_root}/skills/think-with-me/references/model-comparison.md"
start_marker='<!-- MODEL_COMPARISON_START -->'
end_marker='<!-- MODEL_COMPARISON_END -->'
source_title='# Model Matrix'
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

title_line="$(grep -Fnx -- "${source_title}" "${source_file}" | cut -d: -f1)"
end_anchor_line="$(grep -Fn -- "${source_end_anchor}" "${source_file}" | cut -d: -f1)"
[[ "${end_anchor_line}" -gt "${title_line}" ]] || \
  fail 'canonical evidence anchor must follow the model-matrix heading'

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/think-with-me-model-comparison.XXXXXX")"
trap 'rm -rf -- "${tmp_dir}"' EXIT
public_body="${tmp_dir}/public-body.md"
canonical_block="${tmp_dir}/canonical.md"

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

{
  printf '%s\n' "${start_marker}"
  cat "${public_body}"
  printf '%s\n' "${end_marker}"
} >"${canonical_block}"

targets=(
  "${repo_root}/README.md"
  "${repo_root}/skills/think-with-me/SKILL.md"
)

for target in "${targets[@]}"; do
  [[ -f "${target}" ]] || fail "missing mirror: ${target#"${repo_root}/"}"
  require_single_marker "${target}" "${start_marker}"
  require_single_marker "${target}" "${end_marker}"
  require_ordered_markers "${target}"

  rendered="${tmp_dir}/$(basename "${target}").rendered"
  awk -v start="${start_marker}" -v end="${end_marker}" -v block="${canonical_block}" '
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
      echo "FAIL: model comparison mirror is stale: ${target#"${repo_root}/"}" >&2
      diff -u "${target}" "${rendered}" || true
      exit 1
    fi
  else
    mv "${rendered}" "${target}"
  fi
done

if [[ "${mode}" == 'check' ]]; then
  echo 'Model comparison mirrors are synchronized.'
else
  echo 'Model comparison mirrors updated.'
fi
