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
research_file="${repo_root}/docs/research/openai-model-claim-verification.md"

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

for file in \
  "${skill_file}" \
  "${routing_file}" \
  "${evidence_file}" \
  "${historical_evidence_file}" \
  "${output_file}" \
  "${metadata_file}" \
  "${routing_cases_file}" \
  "${multiturn_cases_file}" \
  "${research_file}"; do
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
require_text "${routing_file}" '| Final critical gate requiring explicitly requested maximum depth or unresolved failure after `Sol XHigh` | `Sol Max` |'
require_text "${routing_file}" '| Concrete residual ambiguity, conflicting constraints, repeated framing failure, or difficult-to-detect risk | `Sol XHigh` |'
require_text "${routing_file}" '| Architecture trade-off, technical specification, or other substantive professional judgment | `Sol High` |'
require_text "${routing_file}" '| Latency-sensitive interactive project conversation, context recovery, explanation, architecture discovery, or bounded reversible analysis without hidden judgment | `Sol Medium` |'
require_text "${routing_file}" '| Quality-first heterogeneous agent execution, tool-heavy coordination, or interdependent multi-step processing after the decision contract is closed | `Terra Max` |'
require_text "${routing_file}" '| Cost-first asynchronous work whose output is reversible and reviewed before consequence, including fixed-schema volume or open-ended long-horizon execution, when extra latency, tokens, steps, and retries are acceptable | `Luna Max` |'
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

require_text "${evidence_file}" '# Current Strong-Model Policy Evidence'
require_text "${evidence_file}" 'Policy review date: **2026-07-30**.'
require_text "${evidence_file}" '[Historical model evidence snapshot — 2026-07-20](model-evidence-2026-07-20.md)'
historical_hash="$(shasum -a 256 "${historical_evidence_file}" | awk '{print $1}')"
[[ "${historical_hash}" == '13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8' ]] || \
  fail "historical model evidence snapshot changed: ${historical_hash}"

require_text "${routing_cases_file}" '| MR-01 | Descoberta aberta de produto'
require_text "${routing_cases_file}" '| MR-01 | Descoberta aberta de produto | A ideia exige exploração e organização de contexto, sem trade-off técnico ou julgamento profissional ainda. | Recomendar `Sol Medium`'
require_text "${routing_cases_file}" '| MR-20 | Processamento estruturado em alto volume'
require_text "${routing_cases_file}" '| MR-26 | Exploração conversacional longa e revisável'
require_text "${routing_cases_file}" '| MR-27 | Elaboração longa, delimitada e revisável'
require_text "${multiturn_cases_file}" '**Esperado:** recomendar `Sol Medium` para a confirmação delimitada, `Sol Medium` para a exploração sem julgamento e `Sol High` para o julgamento profissional final.'

reject_pattern "${research_file}" '\| Luna \| none/low \||\| Terra \| low/medium \||Sol continua como fallback'
require_text "${research_file}" '| Conversa sobre projeto, recuperação de contexto e arquitetura ainda em descoberta | Sol | medium |'
require_text "${research_file}" '| Agents, coordenação e processamento pesado com etapas heterogêneas | Terra | max |'
require_text "${research_file}" '| Lote estruturado, repetível e validável automaticamente | Luna | max |'

echo 'Strong-model routing policy checks passed.'
