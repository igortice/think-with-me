#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
artifact="${repo_root}/docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json"
aa_artifact="${repo_root}/docs/research/assets/artificial-analysis-model-pages-2026-07-31.json"
comparison="${repo_root}/skills/think-with-me/references/model-comparison.md"
research_report="${repo_root}/docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md"

command -v jq >/dev/null 2>&1 || {
  echo 'FAIL: jq is required to verify the preserved DeepSWE artifact' >&2
  exit 1
}

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

verify_measurements() {
  local label="$1"
  local model="$2"
  local effort="$3"
  local pass_percent="$4"
  local ci_percent="$5"
  local output_tokens="$6"
  local steps="$7"
  local markdown_row="$8"

  grep -Fqx -- "${markdown_row}" "${comparison}" || fail "missing canonical row for ${label}"

  jq -e \
    --arg model "${model}" \
    --arg effort "${effort}" \
    --argjson pass_percent "${pass_percent}" \
    --argjson ci_percent "${ci_percent}" \
    --argjson output_tokens "${output_tokens}" \
    --argjson steps "${steps}" '
      any(.rows[];
        .model == $model and
        .reasoning_effort == $effort and
        (((.pass_at_1 * 100) - $pass_percent) | fabs) < 0.005 and
        (((.ci_half * 100) - $ci_percent) | fabs) < 0.005 and
        ((.mean_output_tokens - $output_tokens) | fabs) < 0.51 and
        ((.mean_agent_steps - $steps) | fabs) < 0.051
      )
    ' "${artifact}" >/dev/null || fail "preserved artifact does not support the canonical row for ${label}"
}

verify_raw_cost() {
  local label="$1"
  local model="$2"
  local effort="$3"
  local raw_cost="$4"

  jq -e \
    --arg model "${model}" \
    --arg effort "${effort}" \
    --argjson raw_cost "${raw_cost}" '
      any(.rows[];
        .model == $model and
        .reasoning_effort == $effort and
        ((.mean_cost_usd - $raw_cost) | fabs) < 0.005
      )
    ' "${artifact}" >/dev/null || fail "preserved artifact does not support the raw cost for ${label}"
}

verify_repriced_cost() {
  local label="$1"
  local model="$2"
  local effort="$3"
  local raw_cost="$4"
  local price_factor="$5"
  local displayed_cost="$6"

  jq -e \
    --arg model "${model}" \
    --arg effort "${effort}" \
    --argjson raw_cost "${raw_cost}" \
    --argjson price_factor "${price_factor}" \
    --argjson displayed_cost "${displayed_cost}" '
      any(.rows[];
        .model == $model and
        .reasoning_effort == $effort and
        ((.mean_cost_usd - $raw_cost) | fabs) < 0.005 and
        (((.mean_cost_usd * $price_factor) - $displayed_cost) | fabs) < 0.005
      )
    ' "${artifact}" >/dev/null || fail "preserved artifact does not support the repriced cost for ${label}"
}

verify_raw_row() {
  local label="$1"
  local model="$2"
  local effort="$3"
  local pass_percent="$4"
  local ci_percent="$5"
  local raw_cost="$6"
  local output_tokens="$7"
  local steps="$8"
  local markdown_row="$9"

  verify_measurements "${label}" "${model}" "${effort}" "${pass_percent}" "${ci_percent}" "${output_tokens}" "${steps}" "${markdown_row}"
  verify_raw_cost "${label}" "${model}" "${effort}" "${raw_cost}"
}

verify_repriced_row() {
  local label="$1"
  local model="$2"
  local effort="$3"
  local pass_percent="$4"
  local ci_percent="$5"
  local raw_cost="$6"
  local price_factor="$7"
  local displayed_cost="$8"
  local output_tokens="$9"
  local steps="${10}"
  local markdown_row="${11}"

  verify_measurements "${label}" "${model}" "${effort}" "${pass_percent}" "${ci_percent}" "${output_tokens}" "${steps}" "${markdown_row}"
  verify_repriced_cost "${label}" "${model}" "${effort}" "${raw_cost}" "${price_factor}" "${displayed_cost}"
}

verify_aa_row() {
  local label="$1"
  local model="$2"
  local configuration="$3"
  local source_url="$4"
  local intelligence="$5"
  local coding="$6"
  local blended_price="$7"
  local mean_cost="$8"
  local output_speed="$9"
  local first_answer_latency="${10}"
  local output_total_millions="${11}"
  local markdown_row="${12}"

  grep -Fqx -- "${markdown_row}" "${comparison}" || fail "missing canonical Artificial Analysis row for ${label}"

  jq -e \
    --arg model "${model}" \
    --arg configuration "${configuration}" \
    --arg source_url "${source_url}" \
    --argjson intelligence "${intelligence}" \
    --argjson coding "${coding}" \
    --argjson blended_price "${blended_price}" \
    --argjson mean_cost "${mean_cost}" \
    --argjson output_speed "${output_speed}" \
    --argjson first_answer_latency "${first_answer_latency}" \
    --argjson output_total_millions "${output_total_millions}" '
      [.rows[] | select(
        .model == $model and
        .configuration == $configuration and
        .source_url == $source_url and
        ((.intelligence_index_v4_1 - $intelligence) | fabs) < 0.0005 and
        ((.coding_index - $coding) | fabs) < 0.0005 and
        ((.blended_price_per_million_tokens_usd - $blended_price) | fabs) < 0.0005 and
        ((.mean_cost_per_intelligence_task_usd - $mean_cost) | fabs) < 0.0005 and
        ((.output_speed_tokens_per_second - $output_speed) | fabs) < 0.0005 and
        ((.time_to_first_answer_seconds - $first_answer_latency) | fabs) < 0.0005 and
        ((.total_output_tokens_for_index_millions - $output_total_millions) | fabs) < 0.0005
      )] | length == 1
    ' "${aa_artifact}" >/dev/null || fail "Artificial Analysis artifact does not support the canonical row for ${label}"
}

require_sha256 "${artifact}" '050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d'
require_sha256 "${aa_artifact}" 'acb5227d3825406968ebc0ca42841d46f5d1cf3b450123608f9edc06fa9ff3ce'

[[ "$(jq -r '.generated_at' "${artifact}")" == '2026-07-17T08:18:55.870582+00:00' ]] || fail 'unexpected DeepSWE generated_at value'
[[ "$(jq -r '.n_tasks_in_set' "${artifact}")" == '113' ]] || fail 'unexpected DeepSWE task count'
grep -Fq -- 'preserved DeepSWE JSON generated at `2026-07-17T08:18:55.870582+00:00`' "${comparison}" || \
  fail 'canonical comparison does not attribute DeepSWE rows to the preserved 17 July JSON'
grep -Fq -- 'Raw preserved-JSON costs remain $3.03 for Luna Max and $4.95 for Terra Max.' "${comparison}" || \
  fail 'canonical comparison does not distinguish preserved DeepSWE costs from the 31 July overlay'
if rg -n -- 'preserved 25 July trajectories|Raw 25 July JSON|generated on 2026-07-25|generated at `2026-07-25' \
  "${comparison}" "${research_report}" >/dev/null; then
  fail 'current provenance still attributes preserved DeepSWE data to a missing 25 July artifact'
fi

jq -e '
  .schema_version == "1.0" and
  .source == "Artificial Analysis" and
  .artifact_type == "dated_model_page_capture" and
  .retrieved_date == "2026-07-31" and
  .timezone == "America/Fortaleza" and
  .retrieved_time == null and
  .retrieval_note == "The exact time of day was not recorded; no timestamp is inferred." and
  .research_report == "docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md" and
  .units.intelligence_index == "points" and
  .units.coding_index == "points" and
  .units.blended_price_per_million_tokens == "USD" and
  .units.mean_cost_per_intelligence_task == "USD" and
  .units.output_speed == "tokens_per_second" and
  .units.time_to_first_answer == "seconds" and
  .units.total_output_tokens_for_index == "millions" and
  (.rows | length) == 4
' "${aa_artifact}" >/dev/null || fail 'unexpected Artificial Analysis artifact schema or retrieval provenance'

verify_raw_row 'Sol Max' 'gpt-5-6-sol' 'max' '72.67' '2.83' '8.39' '60014' '61.3' '| Sol Max | 72.67% | ±2.83 pp | $8.39 | 60,014 | 61.3 |'
verify_raw_row 'Sol XHigh' 'gpt-5-6-sol' 'xhigh' '70.73' '0.82' '4.70' '40745' '44.0' '| Sol XHigh | 70.73% | ±0.82 pp | $4.70 | 40,745 | 44.0 |'
verify_repriced_row 'Terra Max' 'gpt-5-6-terra' 'max' '69.62' '2.56' '4.95' '0.80' '3.96' '71939' '75.9' '| Terra Max | 69.62% | ±2.56 pp | $3.96 | 71,939 | 75.9 |'
verify_raw_row 'Sol High' 'gpt-5-6-sol' 'high' '69.40' '1.43' '3.47' '28450' '36.9' '| Sol High | 69.40% | ±1.43 pp | $3.47 | 28,450 | 36.9 |'
verify_repriced_row 'Luna Max' 'gpt-5-6-luna' 'max' '67.19' '3.99' '3.03' '0.20' '0.61' '73400' '101.7' '| Luna Max | 67.19% | ±3.99 pp | $0.61 | 73,400 | 101.7 |'
verify_raw_row 'GPT-5.5 High' 'gpt-5-5' 'high' '64.38' '3.12' '5.10' '31159' '61.9' '| GPT-5.5 High | 64.38% | ±3.12 pp | $5.10 | 31,159 | 61.9 |'
verify_raw_row 'Sol Medium' 'gpt-5-6-sol' 'medium' '61.06' '1.58' '1.86' '18425' '30.9' '| Sol Medium | 61.06% | ±1.58 pp | $1.86 | 18,425 | 30.9 |'
verify_raw_row 'Terra XHigh' 'gpt-5-6-terra' 'xhigh' '60.18' '2.12' '2.13' '39617' '43.1' '| Terra XHigh | 60.18% | ±2.12 pp | $2.13 | 39,617 | 43.1 |'
verify_raw_row 'Luna XHigh' 'gpt-5-6-luna' 'xhigh' '56.86' '2.17' '1.54' '44678' '71.1' '| Luna XHigh | 56.86% | ±2.17 pp | $1.54 | 44,678 | 71.1 |'
verify_raw_row 'Terra High' 'gpt-5-6-terra' 'high' '53.76' '4.33' '1.13' '21517' '33.5' '| Terra High | 53.76% | ±4.33 pp | $1.13 | 21,517 | 33.5 |'

verify_aa_row 'Luna Max' 'GPT-5.6 Luna' 'Luna Max' 'https://artificialanalysis.ai/models/gpt-5-6-luna/' '51.24' '71.45' '0.174' '0.066' '177.8' '117.02' '130' '| Luna Max | 71.45 | 51.24 | $0.066 | 177.8 tok/s | 117.02 s |'
verify_aa_row 'Sol Medium' 'GPT-5.6 Sol' 'Sol Medium' 'https://artificialanalysis.ai/models/gpt-5-6-sol-medium/' '53.59' '76.26' '4.35' '0.514' '54.6' '4.31' '12' '| Sol Medium | 76.26 | 53.59 | $0.514 | 54.6 tok/s | 4.31 s |'
verify_aa_row 'Terra Max' 'GPT-5.6 Terra' 'Terra Max' 'https://artificialanalysis.ai/models/gpt-5-6-terra/' '54.95' '76.66' '1.74' '0.733' '131.8' '152.99' '96' '| Terra Max | 76.66 | 54.95 | $0.733 | 131.8 tok/s | 152.99 s |'
verify_aa_row 'Sol High' 'GPT-5.6 Sol' 'Sol High' 'https://artificialanalysis.ai/models/gpt-5-6-sol-high/' '55.87' '77.16' '4.35' '0.771' '62.4' '13.25' '21' '| Sol High | 77.16 | 55.87 | $0.771 | 62.4 tok/s | 13.25 s |'

grep -Fq -- 'docs/research/assets/artificial-analysis-model-pages-2026-07-31.json' "${comparison}" || \
  fail 'canonical comparison does not name the immutable Artificial Analysis capture'
grep -Fq -- 'acb5227d3825406968ebc0ca42841d46f5d1cf3b450123608f9edc06fa9ff3ce' "${comparison}" || \
  fail 'canonical comparison does not bind the Artificial Analysis capture hash'

echo 'Model comparison data matches the preserved DeepSWE and Artificial Analysis artifacts.'
