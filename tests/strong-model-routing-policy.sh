#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_file="${repo_root}/skills/think-with-me/SKILL.md"
routing_file="${repo_root}/skills/think-with-me/references/model-routing.md"
evidence_file="${repo_root}/skills/think-with-me/references/model-evidence.md"
historical_evidence_file="${repo_root}/skills/think-with-me/references/model-evidence-2026-07-20.md"
output_file="${repo_root}/skills/think-with-me/references/output-contract.md"
metadata_file="${repo_root}/skills/think-with-me/agents/openai.yaml"
routing_cases_file="${repo_root}/evals/model-routing-cases.md"
multiturn_cases_file="${repo_root}/evals/think-with-me-multiturn-cases.md"
cases_file="${repo_root}/evals/think-with-me-cases.md"
readme_file="${repo_root}/README.md"
research_file="${repo_root}/docs/research/openai-model-claim-verification.md"
price_research_file="${repo_root}/docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md"
design_file="${repo_root}/docs/superpowers/specs/2026-07-31-luna-cost-routing-and-price-overlay-design.md"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_file() {
  [[ -f "$1" ]] || fail "missing file: ${1#"${repo_root}/"}"
}

require_text() {
  local file="$1"
  local text="$2"
  grep -Fq -- "${text}" "${file}" || fail "missing text in ${file#"${repo_root}/"}: ${text}"
}

reject_pattern() {
  local file="$1"
  local pattern="$2"
  if rg -n -- "${pattern}" "${file}" >/dev/null; then
    fail "forbidden pattern in ${file#"${repo_root}/"}: ${pattern}"
  fi
}

require_count() {
  local file="$1"
  local text="$2"
  local expected="$3"
  local actual
  actual="$(grep -Fc -- "${text}" "${file}" || true)"
  [[ "${actual}" == "${expected}" ]] || \
    fail "expected ${expected} occurrences in ${file#"${repo_root}/"}; found ${actual}: ${text}"
}

section_body() {
  local file="$1"
  local heading="$2"
  awk -v heading="${heading}" '
    $0 == heading { in_section = 1; next }
    in_section && /^## / { exit }
    in_section { print }
  ' "${file}"
}

require_section_text() {
  local file="$1"
  local heading="$2"
  local text="$3"
  section_body "${file}" "${heading}" | grep -Fq -- "${text}" || \
    fail "section ${heading} in ${file#"${repo_root}/"} must contain: ${text}"
}

reject_section_pattern() {
  local file="$1"
  local heading="$2"
  local pattern="$3"
  if section_body "${file}" "${heading}" | rg -n -- "${pattern}" >/dev/null; then
    fail "section ${heading} in ${file#"${repo_root}/"} contains forbidden pattern: ${pattern}"
  fi
}

require_section_question_count() {
  local file="$1"
  local heading="$2"
  local expected="$3"
  local actual

  actual="$(section_body "${file}" "${heading}" | awk '{line = $0; count += gsub(/\?/, "", line)} END {print count + 0}')"
  [[ "${actual}" == "${expected}" ]] || \
    fail "section ${heading} in ${file#"${repo_root}/"} must contain ${expected} question mark(s); found ${actual}"
}

for file in \
  "${skill_file}" \
  "${routing_file}" \
  "${evidence_file}" \
  "${historical_evidence_file}" \
  "${output_file}" \
  "${metadata_file}" \
  "${routing_cases_file}" \
  "${multiturn_cases_file}" \
  "${cases_file}" \
  "${readme_file}" \
  "${research_file}" \
  "${price_research_file}" \
  "${design_file}"; do
  require_file "${file}"
done

allowlist='`Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max`, and `Luna Max`'
require_text "${skill_file}" "${allowlist}"
require_text "${routing_file}" "${allowlist}"
require_text "${metadata_file}" 'Sol Medium, Sol High, Sol XHigh, Sol Max, Terra Max, or Luna Max'
require_count "${skill_file}" 'This is a hard allowlist' '1'

reject_pattern "${skill_file}" 'retry (only )?(the )?same pair|fail closed'
reject_pattern "${routing_file}" 'retry (only )?(the )?same (atomic )?pair|fail closed'
require_text "${skill_file}" 'The skill recommends a pair; it does not select, retry, or replace the host model.'
require_text "${routing_file}" 'If the host reports that pair as unavailable, preserve the recommendation, report the mismatch, and require an explicit host-level choice from the allowlist.'

reject_pattern "${routing_file}" 'Apply the first row|worker/coordinator|workers|fan-out|fan-in|parallel execution'
require_text "${routing_file}" '| Explicitly bounded critical risk that remains unresolved after a narrower selective route, normally `Sol XHigh` | `Sol Max` |'
require_text "${routing_file}" 'An explicit request for maximum depth, importance, novelty, or urgency never bypasses the prior-failure requirement.'
reject_pattern "${routing_file}" 'requiring explicitly requested maximum depth or unresolved failure|requires[[:space:]]+an explicit maximum-depth need or evidence'
require_text "${routing_file}" '| Concrete residual ambiguity, conflicting constraints, repeated framing failure, or difficult-to-detect risk | `Sol XHigh` |'
require_text "${routing_file}" '| Architecture trade-off, technical specification, or other substantive professional judgment | `Sol High` |'
require_text "${routing_file}" '| Latency-sensitive interactive project conversation, context recovery, explanation, architecture discovery, or bounded reversible analysis without hidden judgment | `Sol Medium` |'
require_text "${routing_file}" '| Quality-first heterogeneous agent execution, tool-heavy coordination, or interdependent multi-step processing after the decision contract is closed | `Terra Max` |'
require_text "${routing_file}" '| Cost-first asynchronous work whose output is reversible and reviewed before consequence, including fixed-schema volume or open-ended long-horizon execution, when extra latency, tokens, steps, and retries are acceptable | `Luna Max` |'
require_text "${routing_file}" 'ask exactly one focused cost-first-versus-quality-first question and do not emit a model footer until the priority is known.'
reject_pattern "${routing_file}" '^\| Latency-sensitive interactive project conversation.*\| `Luna Max` \|$'
reject_pattern "${routing_file}" '^\| Architecture trade-off, technical specification, or other substantive professional judgment \| `Luna Max` \|$'
reject_pattern "${routing_file}" '^tool-heavy coordination use `Terra Max`\.'

reject_pattern "${routing_file}" 'Luna Medium|Terra High|Terra XHigh|Luna XHigh|GPT-5\.5|GPT-5\.4'
reject_pattern "${output_file}" 'Luna Medium|Terra High|Terra XHigh|Luna XHigh'
reject_pattern "${evidence_file}" 'Luna Medium|Terra High|Terra XHigh|Luna XHigh'

require_section_text "${output_file}" '## Long reviewable exploration' '> `Sol Medium` ·'
reject_section_pattern "${output_file}" '## Long reviewable exploration' 'Terra Max|Luna Max'
require_section_text "${output_file}" '## Long reviewable drafting' '> `Sol Medium` ·'
reject_section_pattern "${output_file}" '## Long reviewable drafting' 'Terra Max|Luna Max'
require_section_text "${output_file}" '## Matched long-horizon agent execution' '> `Terra Max` ·'
reject_section_pattern "${output_file}" '## Matched long-horizon agent execution' 'Luna Max'
require_section_text "${output_file}" '## Structured high-volume processing' '> `Luna Max` ·'
for condition in 'prioridade de custo' 'assíncrona' 'reversível' 'revisada antes de qualquer consequência' 'latência, tokens, passos e retries adicionais'; do
  require_section_text "${output_file}" '## Structured high-volume processing' "${condition}"
done
reject_section_pattern "${output_file}" '## Structured high-volume processing' 'menor custo e latência|lower latency'
for condition in 'cost-first' 'assíncrona' 'reversível' 'revisada antes de consequência' 'latência, tokens, passos ou retries adicionais'; do
  require_section_text "${output_file}" '## Judgment boundary during cost-first execution' "${condition}"
done
for condition in 'contrato de aceitação está fechado' 'prioridade explícita é qualidade' 'heterogêneo' 'interdependentes'; do
  require_section_text "${output_file}" '## Heavy agent execution' "${condition}"
done
require_section_text "${output_file}" '## Unknown Terra/Luna execution priority' 'A prioridade é minimizar custo em uma execução revisável ou maximizar qualidade na coordenação heterogênea?'
require_section_question_count "${output_file}" '## Unknown Terra/Luna execution priority' '1'
reject_section_pattern "${output_file}" '## Unknown Terra/Luna execution priority' '^> `(Sol|Terra|Luna) (Medium|High|XHigh|Max)` · '
require_section_text "${output_file}" '## Direct maximum-depth request without prior selective failure' '> `Sol XHigh` ·'
reject_section_pattern "${output_file}" '## Direct maximum-depth request without prior selective failure' '^> `Sol Max` · '
require_section_text "${output_file}" '## Final maximum-depth gate after failed selective analysis' '> `Sol Max` ·'

require_text "${evidence_file}" '# Current Strong-Model Policy Evidence'
require_text "${evidence_file}" 'Policy review date: **2026-07-31**.'
reject_pattern "${evidence_file}" 'Policy review date: \*\*2026-07-30\*\*\.'
require_text "${evidence_file}" 'generated at `2026-07-17T08:18:55.870582+00:00`'
require_text "${evidence_file}" '[Historical model evidence snapshot — 2026-07-20](model-evidence-2026-07-20.md)'
historical_hash="$(shasum -a 256 "${historical_evidence_file}" | awk '{print $1}')"
[[ "${historical_hash}" == '13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8' ]] || \
  fail "historical model evidence snapshot changed: ${historical_hash}"

require_text "${routing_cases_file}" '| MR-01 | Descoberta aberta de produto'
require_text "${routing_cases_file}" '| MR-01 | Descoberta aberta de produto | A ideia exige exploração e organização de contexto, sem trade-off técnico ou julgamento profissional ainda. | Recomendar `Sol Medium`'
require_text "${routing_cases_file}" '| MR-20 | Processamento estruturado em alto volume'
require_text "${routing_cases_file}" '| MR-26 | Exploração conversacional longa e revisável'
require_text "${routing_cases_file}" '| MR-27 | Elaboração longa, delimitada e revisável'
require_text "${routing_cases_file}" '| MR-11 | Pedido direto de Max sem falha seletiva anterior'
require_text "${routing_cases_file}" 'Recomendar `Sol XHigh` para a primeira investigação seletiva; não selecionar Max.'
require_text "${routing_cases_file}" '| MR-29 | Falha de Sol XHigh no risco crítico delimitado'
require_text "${routing_cases_file}" 'Recomendar `Sol Max` porque o risco crítico explicitamente delimitado permaneceu sem solução após Sol XHigh.'
require_text "${routing_cases_file}" '| MR-38 | Prioridade Terra/Luna desconhecida e decisiva'
require_text "${routing_cases_file}" 'Fazer exatamente uma pergunta focada entre cost-first e quality-first e não emitir rodapé de modelo antes da resposta.'
require_text "${routing_cases_file}" 'tolerante a latência, tokens, passos ou retries adicionais'
require_text "${multiturn_cases_file}" 'TWM-M22 — Prioridade de execução desconhecida suspende o rodapé'
require_text "${multiturn_cases_file}" 'fazer exatamente uma pergunta focada cost-first-versus-quality-first e não emitir rodapé de modelo até a resposta.'
require_text "${multiturn_cases_file}" 'tolerante a latência, tokens, passos ou retries adicionais'
require_text "${multiturn_cases_file}" 'TWM-M23 — Pedido direto de Max passa primeiro por profundidade seletiva'
require_text "${multiturn_cases_file}" 'lote cost-first, assíncrono, reversível, revisável e tolerante a latência, tokens, passos ou retries adicionais em `Luna Max`'
require_text "${multiturn_cases_file}" 'orientada por custo e tolerante a latência, tokens, passos ou retries adicionais.'
require_text "${cases_file}" 'TWM-19'
require_text "${cases_file}" 'TWM-20'
require_text "${multiturn_cases_file}" '**Esperado:** recomendar `Sol Medium` para a confirmação delimitada, `Sol Medium` para a exploração sem julgamento e `Sol High` para o julgamento profissional final.'

require_text "${readme_file}" '`Sol Max` requires an explicitly bounded critical risk that remains unresolved after a narrower selective route'
require_text "${readme_file}" '`Terra Max` requires a closed contract plus explicit quality-first priority for heterogeneous, interdependent execution'
require_text "${readme_file}" '`Luna Max` requires cost-first, asynchronous, reversible work reviewed before consequence and tolerant of extra latency, tokens, steps, or retries.'

require_text "${design_file}" '| Explicitly bounded critical risk that remains unresolved after a narrower selective route, normally `Sol XHigh` | `Sol Max` |'
reject_pattern "${design_file}" 'requiring explicitly requested maximum depth or unresolved failure'
require_text "${design_file}" 'no model footer is emitted until the required priority is known.'

reject_pattern "${price_research_file}" '2026-07-25T03:13:49Z|JSON was generated on 25|JSON foi gerado em 25/07|resultados de execução de 25/07'

reject_pattern "${research_file}" '\| Luna \| none/low \||\| Terra \| low/medium \||Sol continua como fallback'
require_text "${research_file}" '| Conversa sobre projeto, recuperação de contexto e arquitetura ainda em descoberta | Sol | medium |'
require_text "${research_file}" '| Contrato fechado, prioridade de qualidade e execução heterogênea interdependente | Terra | max |'
require_text "${research_file}" '| Trabalho cost-first, assíncrono, reversível, revisado antes de consequência e tolerante a execução adicional | Luna | max |'

echo 'Strong-model routing policy checks passed.'
