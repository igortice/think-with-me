#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
comparison="${repo_root}/skills/think-with-me/references/model-comparison.md"
skill="${repo_root}/skills/think-with-me/SKILL.md"
readme="${repo_root}/README.md"
evidence="${repo_root}/skills/think-with-me/references/model-evidence.md"
output_contract="${repo_root}/skills/think-with-me/references/output-contract.md"
routing="${repo_root}/skills/think-with-me/references/model-routing.md"
claim_review="${repo_root}/docs/research/openai-model-claim-verification.md"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_text() {
  local file="$1"
  local text="$2"
  grep -Fq -- "${text}" "${file}" || \
    fail "missing current documentation text in ${file#"${repo_root}/"}: ${text}"
}

matrix_rows=(
  '| Ordinary conversation, project understanding, research, or reversible analysis when extra startup delay is acceptable | `Luna Max` |'
  '| Fast interactive conversation or rapid context recovery | `Sol Medium` |'
  '| Architecture, technical specification, or professional judgment | `Sol High` |'
  '| Quality-first agents, tools, or interdependent execution with a closed contract | `Terra Max` |'
  '| Residual ambiguity, conflicting constraints, or hard-to-detect risk | `Sol XHigh` |'
  '| A bounded critical problem still unresolved after `Sol XHigh` | `Sol Max` |'
)

for row in "${matrix_rows[@]}"; do
  require_text "${comparison}" "${row}"
  require_text "${skill}" "${row}"
  require_text "${readme}" "${row}"
done

require_text "${comparison}" '# Model Matrix'
require_text "${comparison}" '## Which model should I use?'
require_text "${comparison}" '## Cross-checked data'
require_text "${comparison}" '[Detailed evidence](model-evidence.md)'
if rg -n 'MODEL_COMPARISON_(START|END)' "${comparison}" >/dev/null; then
  fail 'the user-facing matrix contains technical synchronization markers'
fi
if [[ -e "${repo_root}/skills/think-with-me/references/model-comparison.pt-BR.md" ]]; then
  fail 'the matrix must remain English-only; unexpected Portuguese matrix found'
fi
if rg -n 'Qual modelo usar|Dados cruzados' "${comparison}" >/dev/null; then
  fail 'the matrix contains Portuguese headings'
fi
require_text "${evidence}" 'The current OpenAI Standard API prices are US$5/30 per 1M input/output tokens'
require_text "${evidence}" 'for Sol, US$2/12 for Terra, and US$0.20/1.20 for Luna.'
require_text "${evidence}" '10–100 for Sol, 25–200 for Terra, and'
require_text "${evidence}" '250–2,000 for Luna'

require_text "${claim_review}" '**Auditoria e atualização:** 31 de julho de 2026 (America/Fortaleza)'
require_text "${claim_review}" '51,24 no Artificial Analysis Intelligence Index v4.1'
require_text "${claim_review}" '177,8 tokens/s de output e 117,02 s'
if rg -n '189,8[[:space:]]+tokens/s|TTFT de cerca de 119 s' "${claim_review}" >/dev/null; then
  fail 'current OpenAI claim review still contains the superseded Artificial Analysis snapshot'
fi

for contract in "${skill}" "${output_contract}" "${routing}"; do
  require_text "${contract}" 'references/model-comparison.md'
  if rg -n 'https?://[^ )>]*model-comparison\.md|github\.com/igortice/think-with-me[^ )>]*model-comparison' "${contract}" >/dev/null; then
    fail "installable contract points the footer matrix link to a remote target: ${contract#"${repo_root}/"}"
  fi
  if rg -n '^> `(Sol|Terra|Luna) (Medium|High|XHigh|Max)` · ' "${contract}" >/dev/null; then
    fail "installable contract contains a footer without the local matrix link: ${contract#"${repo_root}/"}"
  fi
done

echo 'Current model documentation and local matrix-link checks passed.'
