#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
deepswe_artifact="${repo_root}/docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json"
aa_artifact="${repo_root}/docs/research/assets/artificial-analysis-model-pages-2026-07-31.json"
comparison="${repo_root}/skills/think-with-me/references/model-comparison.md"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_sha256() {
  local file="$1"
  local expected="$2"
  local actual

  [[ -f "${file}" ]] || fail "missing data artifact: ${file#"${repo_root}/"}"
  actual="$(shasum -a 256 "${file}" | awk '{print $1}')"
  [[ "${actual}" == "${expected}" ]] || \
    fail "SHA-256 mismatch for ${file#"${repo_root}/"}: expected ${expected}, got ${actual}"
}

require_row() {
  local row="$1"
  grep -Fqx -- "${row}" "${comparison}" || fail "missing matrix row: ${row}"
}

verify_deepswe() {
  local label="$1"
  local model="$2"
  local effort="$3"
  local pass_percent="$4"
  local raw_cost="$5"
  local price_factor="$6"
  local displayed_cost="$7"

  jq -e \
    --arg model "${model}" \
    --arg effort "${effort}" \
    --argjson pass_percent "${pass_percent}" \
    --argjson raw_cost "${raw_cost}" \
    --argjson price_factor "${price_factor}" \
    --argjson displayed_cost "${displayed_cost}" '
      any(.rows[];
        .model == $model and
        .reasoning_effort == $effort and
        (((.pass_at_1 * 100) - $pass_percent) | fabs) < 0.005 and
        ((.mean_cost_usd - $raw_cost) | fabs) < 0.005 and
        (((.mean_cost_usd * $price_factor) - $displayed_cost) | fabs) < 0.005
      )
    ' "${deepswe_artifact}" >/dev/null || fail "DeepSWE artifact does not support ${label}"
}

verify_aa() {
  local configuration="$1"
  local intelligence="$2"
  local first_answer="$3"

  jq -e \
    --arg configuration "${configuration}" \
    --argjson intelligence "${intelligence}" \
    --argjson first_answer "${first_answer}" '
      any(.rows[];
        .configuration == $configuration and
        ((.intelligence_index_v4_1 - $intelligence) | fabs) < 0.0005 and
        ((.time_to_first_answer_seconds - $first_answer) | fabs) < 0.0005
      )
    ' "${aa_artifact}" >/dev/null || fail "Artificial Analysis artifact does not support ${configuration}"
}

command -v jq >/dev/null 2>&1 || fail 'jq is required'
require_sha256 "${deepswe_artifact}" '050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d'
require_sha256 "${aa_artifact}" 'acb5227d3825406968ebc0ca42841d46f5d1cf3b450123608f9edc06fa9ff3ce'

verify_deepswe 'Sol Max' 'gpt-5-6-sol' 'max' '72.67' '8.39' '1.00' '8.39'
verify_deepswe 'Sol XHigh' 'gpt-5-6-sol' 'xhigh' '70.73' '4.70' '1.00' '4.70'
verify_deepswe 'Terra Max' 'gpt-5-6-terra' 'max' '69.62' '4.9458' '0.80' '3.95664'
verify_deepswe 'Sol High' 'gpt-5-6-sol' 'high' '69.40' '3.47' '1.00' '3.47'
verify_deepswe 'Luna Max' 'gpt-5-6-luna' 'max' '67.19' '3.0281' '0.20' '0.60562'
verify_deepswe 'Sol Medium' 'gpt-5-6-sol' 'medium' '61.06' '1.86' '1.00' '1.86'

verify_aa 'Sol High' '55.87' '13.25'
verify_aa 'Terra Max' '54.95' '152.99'
verify_aa 'Sol Medium' '53.59' '4.31'
verify_aa 'Luna Max' '51.24' '117.02'

require_row '| Sol Max | 72.67% | $8.39 | — | — |'
require_row '| Sol XHigh | 70.73% | $4.70 | — | — |'
require_row '| Terra Max | 69.62% | $3.96 | 54.95 | 152.99 s |'
require_row '| Sol High | 69.40% | $3.47 | 55.87 | 13.25 s |'
require_row '| Luna Max | 67.19% | $0.61 | 51.24 | 117.02 s |'
require_row '| Sol Medium | 61.06% | $1.86 | 53.59 | 4.31 s |'

grep -Fq -- 'Luna Max and Terra Max costs apply the documented 31 July price overlay' "${comparison}" || \
  fail 'matrix does not disclose the Luna and Terra price overlay'
grep -Fq -- 'Do not combine the two benchmark scores into one ranking.' "${comparison}" || \
  fail 'matrix does not preserve the cross-source evidence boundary'
grep -Fq -- '[Detailed evidence](model-evidence.md)' "${comparison}" || \
  fail 'matrix does not link to detailed local evidence'

echo 'Simple model matrix matches the preserved benchmark artifacts.'
