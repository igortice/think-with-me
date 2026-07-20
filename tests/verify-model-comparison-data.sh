#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
artifact="${repo_root}/docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json"
comparison="${repo_root}/skills/think-with-me/references/model-comparison.md"

command -v jq >/dev/null 2>&1 || {
  echo 'FAIL: jq is required to verify the preserved DeepSWE artifact' >&2
  exit 1
}

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

verify_row() {
  local label="$1"
  local model="$2"
  local effort="$3"
  local pass_percent="$4"
  local ci_percent="$5"
  local cost="$6"
  local output_tokens="$7"
  local steps="$8"
  local markdown_row="$9"

  grep -Fqx -- "${markdown_row}" "${comparison}" || fail "missing canonical row for ${label}"

  jq -e \
    --arg model "${model}" \
    --arg effort "${effort}" \
    --argjson pass_percent "${pass_percent}" \
    --argjson ci_percent "${ci_percent}" \
    --argjson cost "${cost}" \
    --argjson output_tokens "${output_tokens}" \
    --argjson steps "${steps}" '
      any(.rows[];
        .model == $model and
        .reasoning_effort == $effort and
        (((.pass_at_1 * 100) - $pass_percent) | fabs) < 0.005 and
        (((.ci_half * 100) - $ci_percent) | fabs) < 0.005 and
        ((.mean_cost_usd - $cost) | fabs) < 0.005 and
        ((.mean_output_tokens - $output_tokens) | fabs) < 0.51 and
        ((.mean_agent_steps - $steps) | fabs) < 0.051
      )
    ' "${artifact}" >/dev/null || fail "preserved artifact does not support the canonical row for ${label}"
}

[[ "$(jq -r '.generated_at' "${artifact}")" == '2026-07-17T08:18:55.870582+00:00' ]] || fail 'unexpected DeepSWE generated_at value'
[[ "$(jq -r '.n_tasks_in_set' "${artifact}")" == '113' ]] || fail 'unexpected DeepSWE task count'

verify_row 'Sol Max' 'gpt-5-6-sol' 'max' '72.67' '2.83' '8.39' '60014' '61.3' '| Sol Max | 72.67% | ±2.83 pp | $8.39 | 60,014 | 61.3 |'
verify_row 'Sol XHigh' 'gpt-5-6-sol' 'xhigh' '70.73' '0.82' '4.70' '40745' '44.0' '| Sol XHigh | 70.73% | ±0.82 pp | $4.70 | 40,745 | 44.0 |'
verify_row 'Terra Max' 'gpt-5-6-terra' 'max' '69.62' '2.56' '4.95' '71939' '75.9' '| Terra Max | 69.62% | ±2.56 pp | $4.95 | 71,939 | 75.9 |'
verify_row 'Sol High' 'gpt-5-6-sol' 'high' '69.40' '1.43' '3.47' '28450' '36.9' '| Sol High | 69.40% | ±1.43 pp | $3.47 | 28,450 | 36.9 |'
verify_row 'Luna Max' 'gpt-5-6-luna' 'max' '67.19' '3.99' '3.03' '73400' '101.7' '| Luna Max | 67.19% | ±3.99 pp | $3.03 | 73,400 | 101.7 |'
verify_row 'GPT-5.5 High' 'gpt-5-5' 'high' '64.38' '3.12' '5.10' '31159' '61.9' '| GPT-5.5 High | 64.38% | ±3.12 pp | $5.10 | 31,159 | 61.9 |'
verify_row 'Sol Medium' 'gpt-5-6-sol' 'medium' '61.06' '1.58' '1.86' '18425' '30.9' '| Sol Medium | 61.06% | ±1.58 pp | $1.86 | 18,425 | 30.9 |'
verify_row 'Terra XHigh' 'gpt-5-6-terra' 'xhigh' '60.18' '2.12' '2.13' '39617' '43.1' '| Terra XHigh | 60.18% | ±2.12 pp | $2.13 | 39,617 | 43.1 |'
verify_row 'Luna XHigh' 'gpt-5-6-luna' 'xhigh' '56.86' '2.17' '1.54' '44678' '71.1' '| Luna XHigh | 56.86% | ±2.17 pp | $1.54 | 44,678 | 71.1 |'
verify_row 'Terra High' 'gpt-5-6-terra' 'high' '53.76' '4.33' '1.13' '21517' '33.5' '| Terra High | 53.76% | ±4.33 pp | $1.13 | 21,517 | 33.5 |'

echo 'Model comparison data matches the preserved DeepSWE artifact.'
