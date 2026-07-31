#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

repository_governance_pattern='\b(subagent|handoff|project-context|commit|push|sync)\b|\bapproval[[:space:]]+routing\b|\bnext-task[[:space:]]+routing\b'

has_repository_governance_vocabulary() {
  rg -qi -e "${repository_governance_pattern}" "$@"
}

require_file() {
  [[ -f "$1" ]] || fail "missing file: ${1#"${repo_root}/"}"
}

require_text() {
  local file="$1"
  local pattern="$2"
  grep -Fq -- "$pattern" "$file" || fail "missing text in ${file#"${repo_root}/"}: $pattern"
}

reject_text() {
  local file="$1"
  local pattern="$2"
  if grep -Fq -- "$pattern" "$file"; then
    fail "forbidden text in ${file#"${repo_root}/"}: $pattern"
  fi
}

require_sha256() {
  local file="$1"
  local expected="$2"
  local actual
  actual="$(shasum -a 256 "${file}" | awk '{print $1}')"
  [[ "${actual}" == "${expected}" ]] || fail "SHA-256 mismatch for ${file#"${repo_root}/"}: expected ${expected}, got ${actual}"
}

require_file "${repo_root}/scripts/candidate-manifest.sh"
require_file "${repo_root}/scripts/validate-structure.sh"
require_file "${repo_root}/scripts/sync-model-comparison.sh"
require_file "${repo_root}/scripts/verify-evidence-record.sh"
require_file "${repo_root}/scripts/verify-install-record.sh"
require_file "${repo_root}/tests/sync-model-comparison.sh"
require_file "${repo_root}/tests/verify-model-comparison-data.sh"
require_file "${repo_root}/tests/verify-install-record.sh"
require_file "${repo_root}/tests/current-model-documentation.sh"
require_file "${repo_root}/evals/evidence-run-template.md"
require_file "${repo_root}/evals/model-routing-evidence-template.md"
require_file "${repo_root}/evals/evidence-2026-07-19-evidence-based-routing.md"
require_file "${repo_root}/evals/evidence-2026-07-20-model-comparison-routing.md"
require_file "${repo_root}/evals/evidence-2026-07-20-contextual-model-portfolio.md"
require_file "${repo_root}/evals/evidence-2026-07-20-conversational-routing.md"
require_file "${repo_root}/evals/evidence-2026-07-30-strong-model-routing.md"
require_file "${repo_root}/evals/evidence-2026-07-31-luna-cost-routing.md"
require_file "${repo_root}/evals/install-2026-07-30-strong-model-routing.md"
require_file "${repo_root}/evals/install-2026-07-31-luna-cost-routing.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-20.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-20-final.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-20-contextual-portfolio.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-20-contextual-portfolio-final.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-20-conversational-routing.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-20-conversational-routing-final.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-30-strong-model-routing.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-30-strong-model-routing-final.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-31-luna-cost-routing.md"
require_file "${repo_root}/evals/runtime-captures-2026-07-31-luna-cost-routing-final.md"
require_file "${repo_root}/docs/research/assets/artificial-analysis-coding-index-2026-07-19.png"
require_file "${repo_root}/docs/research/assets/artificial-analysis-intelligence-cost-2026-07-19.png"
require_file "${repo_root}/docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json"
require_file "${repo_root}/docs/research/assets/artificial-analysis-model-pages-2026-07-31.json"
require_file "${repo_root}/docs/research/model-routing-three-source-verification-2026-07-19.md"

require_sha256 "${repo_root}/docs/research/assets/artificial-analysis-coding-index-2026-07-19.png" 'd0c93da184aef6abbb1c36bba9ec031c254184e2af42751cec4f5d164b242f32'
require_sha256 "${repo_root}/docs/research/assets/artificial-analysis-intelligence-cost-2026-07-19.png" '846653101b0963757832edd10aed75ea6d962d1870d07d3611a762bef722eefc'
require_sha256 "${repo_root}/docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json" '050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d'
require_sha256 "${repo_root}/docs/research/assets/artificial-analysis-model-pages-2026-07-31.json" 'acb5227d3825406968ebc0ca42841d46f5d1cf3b450123608f9edc06fa9ff3ce'
require_sha256 "${repo_root}/evals/runtime-captures-2026-07-20.md" 'e69f52d78c140a2a40c1f2c56e34970ee224b40a10fb02fd68e664f62adfe361'
require_sha256 "${repo_root}/evals/runtime-captures-2026-07-20-final.md" 'd9a0bb737b0a326d90e7ae4182fd306c307f1d48406c7213967da24d7f559a6a'

manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
grep -Fq 'CANDIDATE_ID=' <<<"${manifest}" || fail "candidate manifest has no candidate id"
grep -Fq 'PACKAGE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no package hash"
grep -Fq 'FILE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no file hashes"

skill_file="${repo_root}/skills/think-with-me/SKILL.md"
routing_file="${repo_root}/skills/think-with-me/references/model-routing.md"
evidence_file="${repo_root}/docs/research/model-routing-evidence-2026-07-17.md"
model_evidence_file="${repo_root}/skills/think-with-me/references/model-evidence.md"
historical_model_evidence_file="${repo_root}/skills/think-with-me/references/model-evidence-2026-07-20.md"
model_comparison_file="${repo_root}/skills/think-with-me/references/model-comparison.md"
output_file="${repo_root}/skills/think-with-me/references/output-contract.md"
metadata_file="${repo_root}/skills/think-with-me/agents/openai.yaml"
cases_file="${repo_root}/evals/think-with-me-cases.md"
multiturn_cases_file="${repo_root}/evals/think-with-me-multiturn-cases.md"
routing_cases_file="${repo_root}/evals/model-routing-cases.md"
trigger_cases_file="${repo_root}/evals/trigger-cases.md"
readme_file="${repo_root}/README.md"
continuity_spec_file="${repo_root}/docs/specs/2026-07-17-think-with-me-continuity-design.md"
routing_spec_file="${repo_root}/docs/specs/2026-07-18-model-routing-factual-correction.md"
release_runbook_file="${repo_root}/docs/release/skills-sh-publication.md"
workflow_file="${repo_root}/.github/workflows/validate.yml"

require_text "${skill_file}" 'Use the language of the current user message'
require_text "${skill_file}" "Write all prose before the closing and the closing itself in that same language; examples and placeholder text never override the current user message's language."
require_text "${output_file}" "Write all prose before the closing and the closing itself in that same language; examples and placeholder text never override the current user message's language."
require_text "${skill_file}" 'never output Portuguese prose or labels'
require_text "${skill_file}" 'one continuous Markdown blockquote'
require_text "${skill_file}" 'For an English user message, use `My view` and `Next step` exactly, then render the model as an inline-code label:'
require_text "${skill_file}" 'Open [the output contract](references/output-contract.md) and'
require_text "${skill_file}" '[model routing](references/model-routing.md) before writing every closing.'
require_file "${model_comparison_file}"
require_text "${skill_file}" 'Open [model comparison](references/model-comparison.md) when the user'
require_text "${readme_file}" '## Which model should I use?'
require_text "${skill_file}" '## Which model should I use?'
require_text "${readme_file}" '## Cross-checked data'
require_text "${skill_file}" '## Cross-checked data'
require_text "${readme_file}" 'Last reviewed: **2026-07-31**.'
require_text "${skill_file}" 'Last reviewed: **2026-07-31**.'
require_text "${model_comparison_file}" 'Last reviewed: **2026-07-31**.'
require_text "${skill_file}" 'Do not output the three fields as ordinary paragraphs'
require_text "${skill_file}" 'one concrete next step'
require_text "${skill_file}" 'not a sequence, checklist, or bundle of actions'
require_text "${skill_file}" 'include your recommended answer'
require_text "${skill_file}" 'A short confirmation or approval on the same subject keeps the conversational mode active within that turn'
require_text "${skill_file}" 'identifies both the action and the expected change'
require_text "${skill_file}" 'announce that transition before executing it'
require_text "${skill_file}" 'does not end the decision thread'
require_text "${skill_file}" 'Separate source-supported facts from your inference'
require_text "${skill_file}" 'one short physical Markdown line'
require_text "${skill_file}" 'Model recommendation is derived only after'
require_text "${skill_file}" 'conversation health'
require_text "${skill_file}" 'Do not substitute generic product or effort names for the selected family and effort.'
require_text "${output_file}" '**Minha visão:**'
require_text "${output_file}" '**Próximo passo:**'
require_text "${output_file}" '**My view:**'
require_text "${output_file}" '**Next step:**'
require_text "${output_file}" '`Sol High` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) ·'
require_text "${output_file}" '`Próximo passo` contains at most one `?` character'
require_text "${routing_file}" 'Recommend exactly one model and effort for the immediate next step'
require_text "${routing_file}" '## Mandatory strong-model allowlist'
require_text "${routing_file}" 'Eligible configurations are exactly'
require_text "${routing_file}" '`Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max`, and `Luna Max`'
require_text "${routing_file}" 'No other family or effort pair is eligible for recommendation.'
require_text "${routing_file}" 'Recalculate whenever the immediate next step changes.'
require_text "${routing_file}" 'Use observable progress, repeated corrections, contradictions, friction'
require_text "${routing_file}" 'availability from host state that was not exposed.'
require_text "${routing_file}" 'as one configuration; never choose a family first'
require_text "${routing_file}" 'Quality-first heterogeneous agent execution, tool-heavy coordination'
require_text "${routing_file}" 'Explicitly bounded critical risk that remains unresolved after a narrower selective route, normally `Sol XHigh`'
require_text "${routing_file}" 'preserve the recommendation, report the mismatch'
require_text "${routing_file}" 'Do not average heterogeneous benchmarks'
require_text "${routing_file}" 'A benchmark row can remain visible for historical comparison'
require_text "${routing_file}" 'Official price is not total task cost.'
require_text "${routing_file}" 'Higher effort can increase token use'
require_text "${routing_file}" '`Sol Max` always'
require_text "${skill_file}" 'these six atomic pairs: `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max`, and `Luna Max`.'
require_text "${skill_file}" 'This is a hard allowlist, not a preference.'
require_text "${skill_file}" 'The skill recommends a pair; it does not select, retry, or replace the host model.'
require_text "${evidence_file}" 'Esta é fonte primária **para a metodologia do Artificial Analysis**, mas não é fonte primária do produto OpenAI nem substitui o DeepSWE'
require_text "${evidence_file}" 'A metodologia do AA não deve preencher lacunas do DeepSWE.'
require_file "${historical_model_evidence_file}"
require_sha256 "${historical_model_evidence_file}" '13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8'
require_text "${model_evidence_file}" '# Current Strong-Model Policy Evidence'
require_text "${routing_file}" 'Current policy reviewed: **2026-07-31**.'
require_text "${routing_file}" 'gpt-5-6-price-benchmark-routing-review-2026-07-31.md'
require_text "${model_evidence_file}" 'Policy review date: **2026-07-31**.'
reject_text "${model_evidence_file}" 'Policy review date: **2026-07-30**.'
require_text "${model_evidence_file}" '[Historical model evidence snapshot — 2026-07-20](model-evidence-2026-07-20.md)'
require_text "${model_evidence_file}" 'The skill recommends a pair; it cannot select, retry, replace, or verify the'
require_text "${model_evidence_file}" 'gpt-5-6-price-benchmark-routing-review-2026-07-31.md'
require_text "${model_comparison_file}" '# Model Matrix'
require_text "${model_comparison_file}" '## Which model should I use?'
require_text "${model_comparison_file}" '## Cross-checked data'
require_text "${model_comparison_file}" '| Sol XHigh | 70.73% | $4.70 | — | — |'
require_text "${model_comparison_file}" '| Terra Max | 69.62% | $3.96 | 54.95 | 152.99 s |'
require_text "${model_comparison_file}" '| Luna Max | 67.19% | $0.61 | 51.24 | 117.02 s |'
require_text "${model_comparison_file}" 'Luna Max and Terra Max costs apply the documented 31 July price overlay'
require_text "${model_comparison_file}" 'Do not combine the two benchmark scores into one ranking.'
require_text "${model_comparison_file}" '[Detailed evidence](model-evidence.md)'
reject_text "${model_comparison_file}" '<!-- MODEL_COMPARISON_START -->'
reject_text "${model_comparison_file}" '<!-- MODEL_COMPARISON_END -->'

bash "${repo_root}/scripts/sync-model-comparison.sh" --check

public_comparison_rows=(
  '| Sol Max | 72.67% | $8.39 | — | — |'
  '| Sol XHigh | 70.73% | $4.70 | — | — |'
  '| Terra Max | 69.62% | $3.96 | 54.95 | 152.99 s |'
  '| Sol High | 69.40% | $3.47 | 55.87 | 13.25 s |'
  '| Luna Max | 67.19% | $0.61 | 51.24 | 117.02 s |'
  '| Sol Medium | 61.06% | $1.86 | 53.59 | 4.31 s |'
)
for row in "${public_comparison_rows[@]}"; do
  require_text "${model_comparison_file}" "${row}"
  require_text "${readme_file}" "${row}"
  require_text "${skill_file}" "${row}"
done

public_comparison_notes=(
  'Luna Max and Terra Max costs apply the documented 31 July price overlay'
  'Do not combine the two benchmark scores into one ranking.'
  '| Ordinary conversation, project understanding, research, or reversible analysis when extra startup delay is acceptable | `Luna Max` |'
  '| Fast interactive conversation or rapid context recovery | `Sol Medium` |'
)
for note in "${public_comparison_notes[@]}"; do
  require_text "${model_comparison_file}" "${note}"
  require_text "${readme_file}" "${note}"
  require_text "${skill_file}" "${note}"
done

stale_artificial_analysis_rows=(
  '| Sol XHigh | 78.3 | 57.7 | $0.68 |'
  '| Sol Max | 77.4 | 58.9 | $1.04 |'
  '| Sol High | 77.2 | 55.9 | $0.46 |'
  '| Terra Max | 76.7 | 55.0 | $0.55 |'
  '| Sol Medium | 76.3 | 53.6 | $0.31 |'
  '| GPT-5.5 High | 71.6 | 53.1 | $0.67 |'
  '| Luna Max | 71.4 | 51.2 | $0.21 |'
  '| Terra XHigh | 70.6 | 51.6 | $0.32 |'
  '| Luna XHigh | 68.6 | 49.1 | $0.15 |'
  '| Terra High | 67.1 | 49.0 | $0.24 |'
)
for row in "${stale_artificial_analysis_rows[@]}"; do
  reject_text "${model_comparison_file}" "${row}"
  reject_text "${readme_file}" "${row}"
  reject_text "${skill_file}" "${row}"
done

require_text "${readme_file}" '[model matrix](skills/think-with-me/references/model-comparison.md)'
require_text "${skill_file}" '[model matrix](references/model-comparison.md)'
require_text "${repo_root}/docs/research/model-routing-three-source-verification-2026-07-19.md" 'assets/deepswe-v1.1-leaderboard-2026-07-20.json'
require_text "${repo_root}/docs/research/model-routing-three-source-verification-2026-07-19.md" '050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d'
require_text "${output_file}" 'one question and your recommended answer'
require_text "${output_file}" '`Sol High` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · connect the concrete next step to the decisive conversational evidence.'
require_text "${output_file}" 'Quando o usuário informa explicitamente que configurações anteriores não restauraram a convergência e ainda restam correções repetidas, use esse resultado como evidência em vez de recomendar apenas pela categoria da tarefa.'
require_text "${output_file}" '**Minha visão:** a regra está compreendida, mas os erros anteriores de enquadramento mostram que o contrato final ainda exige julgamento preciso.'
require_text "${output_file}" 'executar um lote piloto representativo no formato único, com critérios prévios de aprovação'
require_text "${output_file}" '`Sol XHigh` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · investigar falhas de integridade difíceis de detectar antes de autorizar a migração.'
require_text "${cases_file}" 'Compare A e B com estes fatos'
require_text "${cases_file}" 'inventar uma edição especulativa'
require_text "${cases_file}" '11. A configuração é escolhida como o par indivisível `família + effort`; a resposta não escolhe uma família antes de avaliar o effort.'
require_text "${cases_file}" '12. Toda recomendação usa somente um dos seis pares permitidos: `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max` ou `Luna Max`.'
require_text "${cases_file}" '13. Conversa comum, entendimento de projeto e descoberta sem julgamento usam `Luna Max` quando a espera adicional é aceitável; recuperação rápida de contexto e interação sensível à latência usam `Sol Medium`; julgamento profissional usa `Sol High`.'
require_text "${cases_file}" '14. `Luna Max` é a rota padrão de valor para trabalho comum não consequencial. Em execução consequencial cost-first, exige reversibilidade, revisão antes de consequência e tolerância a latência, tokens, passos ou retries adicionais; nenhum julgamento profissional fica dentro dela.'
require_text "${cases_file}" '15. Benchmarks de domínios ou harnesses diferentes não são somados nem usados para declarar equivalência universal.'
require_text "${cases_file}" '16. Empates e fontes divergentes preservam a opção conservadora até existir evidência local suficiente.'
require_text "${cases_file}" '18. `Terra Max` exige contrato e critérios de aceite fechados, prioridade quality-first explícita e execução heterogênea interdependente; heterogeneidade isolada não decide a rota.'
require_text "${cases_file}" '19. `Sol Max` exige sempre um risco crítico explicitamente delimitado que permaneceu sem solução depois de uma rota seletiva mais estreita, normalmente `Sol XHigh`; pedido de profundidade máxima, importância, novidade ou urgência não pula essa falha anterior.'
require_text "${cases_file}" 'Recomendar `Luna Max` para o processamento homogêneo somente sob todas essas condições; exigir critérios de qualidade, retries e custo total antes de ampliar o volume.'
require_text "${cases_file}" 'TWM-19'
require_text "${cases_file}" 'TWM-20'
require_text "${multiturn_cases_file}" 'TWM-M10 — Execução concluída retoma a decisão'
require_text "${multiturn_cases_file}" 'o relatório do resultado também termina no fechamento da skill'
require_text "${multiturn_cases_file}" 'TWM-M11 — Inspeção separa fato de inferência'
require_text "${multiturn_cases_file}" 'Assistente recomenda A e Sol High.'
require_text "${multiturn_cases_file}" 'A conversa comum usa Sol High.'
require_text "${multiturn_cases_file}" 'recomendar Sol XHigh porque o risco irreversível inclui falhas de integridade difíceis de detectar'
require_text "${multiturn_cases_file}" 'A conversa avaliou alternativas dentro da allowlist forte.'
require_text "${skill_file}" 'This continuity applies only while the host has loaded this skill for the current turn.'
require_text "${skill_file}" 'This source does not guarantee that the host will load this skill on a later turn.'
require_text "${skill_file}" 'When a later turn explicitly invokes this skill, recover the same decision context without asking the user to restate it.'
require_text "${skill_file}" 'Preserve the exact unresolved dependency from the earlier turn; do not silently replace it with a different concern.'
require_text "${skill_file}" 'keep monitoring or acceptance metrics in the prose as conditions; do not append them as a second action in `Próximo passo`.'
require_text "${skill_file}" 'For an executable comparison step, use one action verb only; do not attach measuring, recording, monitoring, or promotion as a gerund or follow-on verb.'
require_text "${skill_file}" 'A benchmark cost may be reported as an observation, but it cannot make a route “economic” for another domain.'
require_text "${output_file}" 'only applies when the skill is loaded for that response'
require_text "${readme_file}" 'does not keep itself loaded in later turns'
require_text "${readme_file}" 'A new explicit invocation reactivates the skill without resetting the conversation context.'
require_text "${continuity_spec_file}" '## Ativação entre turnos depende do host'
require_text "${continuity_spec_file}" 'A nova menção explícita reativa o contrato sem zerar o contexto.'
require_text "${routing_spec_file}" 'somente enquanto a skill estiver carregada no turno atual'
require_text "${cases_file}" 'TWM-14'
require_text "${cases_file}" 'o host não carregou a skill'
require_text "${cases_file}" 'TWM-15'
require_text "${cases_file}" '`agentMessage.text`'
require_text "${multiturn_cases_file}" 'TWM-M12 — Ausência de nova menção não reativa a skill'
require_text "${multiturn_cases_file}" 'o host não a carrega'
require_text "${multiturn_cases_file}" 'não atribui essa resposta à candidata'
require_text "${multiturn_cases_file}" 'TWM-M13 — Nova menção retoma o contexto'
require_text "${multiturn_cases_file}" 'não precisa repetir o contexto'
require_text "${multiturn_cases_file}" 'resumo normalizado de `wait_threads`'
require_text "${multiturn_cases_file}" 'TWM-M14 — Direção aceita não reduz qualidade por si só'
require_text "${multiturn_cases_file}" 'preservar o piso de qualidade porque ainda existe julgamento substantivo.'
require_text "${multiturn_cases_file}" 'TWM-M15 — Economia delimitada e verificável'
require_text "${multiturn_cases_file}" 'permitir Luna Max apenas para um piloto representativo que cumpra prioridade cost-first, operação assíncrona, reversibilidade, revisão antes de consequência e tolerância a execução adicional'
require_file "${routing_cases_file}"
require_text "${routing_cases_file}" 'MR-01 | Descoberta aberta de produto'
require_text "${routing_cases_file}" 'MR-02 | Comparação contextual'
require_text "${routing_cases_file}" 'MR-03 | Especificação técnica'
require_text "${routing_cases_file}" 'MR-04 | Migração irreversível'
require_text "${routing_cases_file}" 'MR-05 | Correções repetidas de framing'
require_text "${routing_cases_file}" 'MR-06 | Reescrita curta já decidida'
require_text "${routing_cases_file}" 'MR-07 | Extração de schema em alto volume'
require_text "${routing_cases_file}" 'MR-08 | Execução de código de longo horizonte'
require_text "${routing_cases_file}" 'MR-09 | Discordância entre Artificial Analysis e DeepSWE'
require_text "${routing_cases_file}" 'MR-10 | Intervalos sobrepostos'
require_text "${routing_cases_file}" 'MR-11 | Pedido direto de Max sem falha seletiva anterior'
require_text "${routing_cases_file}" 'Recomendar `Sol XHigh` para a primeira investigação seletiva; não selecionar Max.'
require_text "${routing_cases_file}" 'MR-12 | Frustração sem nova ambiguidade'
require_text "${routing_cases_file}" 'MR-13 | Análise delimitada com economia material'
require_text "${routing_cases_file}" 'MR-14 | Análise delimitada sem economia material'
require_text "${routing_cases_file}" 'MR-15 | Julgamento substantivo'
require_text "${routing_cases_file}" 'MR-16 | Ambiguidade residual após análise comum'
require_text "${routing_cases_file}" 'MR-17 | Portfólio histórico visível'
require_text "${routing_cases_file}" 'MR-18 | Alternativas próximas na prosa'
require_text "${routing_cases_file}" 'MR-19 | Pedido de qualidade versus preço'
require_text "${routing_file}" 'For a task involving agents, route only the current step.'
require_text "${routing_file}" 'Ordinary non-consequential conversation, project understanding, research, explanation'
require_text "${routing_file}" 'Latency-sensitive conversation, rapid context recovery'
require_text "${routing_file}" 'When the subject is resolved, do not invent work for the footer.'
require_text "${routing_file}" 'Higher effort can increase token use'
require_text "${routing_cases_file}" 'MR-20 | Processamento estruturado em alto volume'
require_text "${routing_cases_file}" 'MR-21 | Agents e ferramentas'
require_text "${routing_cases_file}" 'MR-22 | Arquitetura ainda em descoberta'
require_text "${routing_cases_file}" 'MR-23 | Arquitetura com trade-off'
require_text "${routing_cases_file}" 'MR-24 | Nenhum default permanente'
require_text "${multiturn_cases_file}" 'TWM-M16 — O próximo passo muda a configuração elegível'
require_text "${routing_cases_file}" 'MR-25 | Assunto resolvido sem pendência inventada'
require_text "${routing_cases_file}" 'MR-26 | Exploração conversacional longa e revisável'
require_text "${routing_cases_file}" 'MR-27 | Elaboração longa, delimitada e revisável'
require_text "${routing_cases_file}" 'MR-28 | Julgamento profissional compacto'
require_text "${routing_cases_file}" 'MR-29 | Falha de Sol XHigh no risco crítico delimitado'
require_text "${routing_cases_file}" 'Recomendar `Sol Max` porque o risco crítico explicitamente delimitado permaneceu sem solução após Sol XHigh.'
require_text "${routing_cases_file}" 'MR-30 | Allowlist forte sem downgrade silencioso'
require_text "${routing_cases_file}" 'MR-31 | Agents com decisão ainda aberta'
require_text "${routing_cases_file}" 'MR-32 | Indisponibilidade da configuração recomendada'
require_text "${routing_cases_file}" 'MR-33 | Exploração aberta assíncrona e de longo horizonte'
require_text "${routing_cases_file}" 'Recomendar `Luna Max` para a execução aberta de longo horizonte orientada por custo.'
require_text "${routing_cases_file}" 'MR-34 | Exploração ampla interativa de projeto'
require_text "${routing_cases_file}" 'Recomendar `Sol Medium` para a conversa interativa e sensível à latência.'
require_text "${routing_cases_file}" 'MR-35 | Execução heterogênea com contrato fechado e prioridade na qualidade'
require_text "${routing_cases_file}" 'Recomendar `Terra Max` para a execução quality-first.'
require_text "${routing_cases_file}" 'MR-36 | Workflow barato com julgamento profissional consequencial'
require_text "${routing_cases_file}" 'Recomendar `Sol High`, não `Luna Max`.'
require_text "${routing_cases_file}" 'MR-37 | Ambiguidade residual após investigação seletiva falha'
require_text "${routing_cases_file}" 'Recomendar `Sol XHigh` antes de considerar `Sol Max`.'
require_text "${routing_cases_file}" 'MR-38 | Prioridade Terra/Luna desconhecida e decisiva'
require_text "${routing_cases_file}" 'Fazer exatamente uma pergunta focada entre cost-first e quality-first e não emitir rodapé de modelo antes da resposta.'
require_text "${multiturn_cases_file}" 'TWM-M17 — A forma da conversa muda a recomendação'
require_text "${multiturn_cases_file}" 'TWM-M18 — Indisponibilidade pertence ao host'
require_text "${multiturn_cases_file}" 'TWM-M19 — Conversa interativa vira lote assíncrono revisável'
require_text "${multiturn_cases_file}" 'recomendar `Luna Max` para o lote cost-first'
require_text "${multiturn_cases_file}" 'TWM-M20 — Lote Luna encontra limite de julgamento consequencial'
require_text "${multiturn_cases_file}" 'recomendar `Sol High` para o julgamento consequencial.'
require_text "${multiturn_cases_file}" 'TWM-M21 — Preferência muda de custo para qualidade após o contrato fechar'
require_text "${multiturn_cases_file}" 'recomendar `Terra Max` para a execução quality-first com contrato fechado.'
require_text "${multiturn_cases_file}" 'TWM-M22 — Prioridade de execução desconhecida suspende o rodapé'
require_text "${multiturn_cases_file}" 'TWM-M23 — Pedido direto de Max passa primeiro por profundidade seletiva'
require_text "${routing_cases_file}" 'Recomendar `Luna Max` para o lote homogêneo e validável sob todas as condições.'
require_text "${routing_cases_file}" 'Recomendar `Terra Max` para a execução quality-first.'
require_text "${routing_cases_file}" 'Recomendar `Luna Max` pela relação custo-qualidade observada.'
require_text "${routing_cases_file}" 'Preservar a recomendação, reportar o mismatch e exigir uma escolha explícita do host dentro da allowlist.'
require_text "${metadata_file}" 'display_name: "Think With Me"'
require_text "${metadata_file}" 'short_description: "Understand a decision before acting, choose the next step, and select a GPT-5.6 model"'
require_text "${metadata_file}" 'default_prompt: "Use $think-with-me to understand this conversation, give your view, recommend the immediate next step, and select exactly one allowed GPT-5.6 pair'
require_text "${metadata_file}" 'Sol Medium, Sol High, Sol XHigh, Sol Max, Terra Max, or Luna Max'
require_text "${metadata_file}" 'allow_implicit_invocation: true'
require_text "${repo_root}/evals/model-routing-evidence-template.md" 'Candidate source requested explicitly:'
require_text "${repo_root}/evals/model-routing-evidence-template.md" 'Runtime source fidelity (`verified by host` / `host-unverified`):'
require_text "${repo_root}/evals/evidence-run-template.md" 'Fonte solicitada explicitamente:'
require_text "${repo_root}/evals/evidence-run-template.md" 'Fidelidade da fonte em runtime (`verificada pelo host` / `não verificada pelo host`):'
require_text "${trigger_cases_file}" 'TWM-T01'
require_text "${trigger_cases_file}" 'TWM-T08'
require_text "${trigger_cases_file}" 'TWM-T09'
require_text "${trigger_cases_file}" 'Auditoria de documentação e testes antes de decidir uma correção.'
require_text "${trigger_cases_file}" 'Uma descoberta positiva melhora a ativação; ela não garante'
require_text "${workflow_file}" '- run: sudo apt-get update && sudo apt-get install --yes jq ripgrep'
require_text "${workflow_file}" '- run: bash tests/evidence-gate-v1.sh'
require_text "${repo_root}/tests/verify-model-comparison-data.sh" 'command -v jq'
require_text "${release_runbook_file}" 'bash tests/evidence-gate-v1.sh'
require_text "${release_runbook_file}" 'evals/think-with-me-multiturn-cases.md'
require_text "${release_runbook_file}" 'TWM-M12'
require_text "${release_runbook_file}" 'TWM-M13'
require_text "${release_runbook_file}" '`agentMessage.text`'
require_text "${release_runbook_file}" 'cópia candidata local, repositório GitHub e página do skills.sh'
require_text "${release_runbook_file}" 'skills/think-with-me/references/model-evidence.md'
require_text "${release_runbook_file}" 'skills/think-with-me/references/model-comparison.md'
require_text "${release_runbook_file}" '`MR-19`'
require_text "${release_runbook_file}" '`Model quality and cost at a glance`'
require_text "${release_runbook_file}" 'DeepSWE v1.1'
require_text "${release_runbook_file}" 'Artificial Analysis'
require_text "${release_runbook_file}" 'as duas tabelas renderizadas na página individual da skill'
require_text "${release_runbook_file}" '## Atualização das tabelas de modelos'
require_text "${release_runbook_file}" 'bash scripts/sync-model-comparison.sh --check'
require_text "${release_runbook_file}" 'snapshot histórico imutável'
require_text "${release_runbook_file}" 'evals/model-routing-cases.md'
require_text "${release_runbook_file}" 'evals/evidence-2026-07-20-model-comparison-routing.md'
require_text "${release_runbook_file}" 'evals/evidence-2026-07-30-strong-model-routing.md'
require_text "${release_runbook_file}" 'evals/install-2026-07-30-strong-model-routing.md'
require_text "${routing_spec_file}" '**Status histórico em 2026-07-18:** candidata não sincronizada globalmente naquele ciclo.'
require_text "${readme_file}" '`Luna Max` is the default value route for ordinary non-consequential work when startup delay is acceptable.'

if rg -Fq 'Only an explicit topic change or closure ends that continuity.' "${skill_file}"; then
  fail 'core skill still promises lifecycle control that belongs to the host'
fi

if rg -Fq 'First choose by next-step fit:' "${routing_file}"; then
  fail 'routing still chooses a family role before an atomic configuration'
fi

if rg -Fq 'Select the family first, then the effort.' "${routing_file}"; then
  fail 'routing still selects family before effort'
fi

if rg -Fq 'Sol XHigh and Max improve DeepSWE Pass@1' "${model_evidence_file}"; then
  fail 'model evidence overstates overlapping DeepSWE point estimates as improvement'
fi

if rg -Fq 'Apply these five policy states' "${routing_file}" ||
   rg -Fq 'No preferred route: Terra' "${routing_file}" ||
   rg -Fq 'must not expose a catalog of alternatives' "${routing_file}"; then
  fail 'routing still enforces the superseded closed-list policy'
fi

if rg -Fq 'Assistente recomenda A e Terra High.' "${multiturn_cases_file}" ||
   rg -Fq 'A conversa comum usa Terra High.' "${multiturn_cases_file}" ||
   rg -Fq 'A conversa avaliou alternativas em Terra High.' "${multiturn_cases_file}" ||
   rg -Fq 'recomendar somente Sol High para esse próximo passo' "${multiturn_cases_file}"; then
  fail 'multiturn fixtures still encode the superseded Terra baseline or block selective depth'
fi

if rg -Fq '**Status:** implementada, validada e sincronizada globalmente' "${routing_spec_file}"; then
  fail 'historical routing spec presents an older global synchronization as the current candidate state'
fi

closing_template=$'> **Minha visão:** one clear conclusion about the subject and the decisive reason.\n>\n> **Próximo passo:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> `Sol High` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · connect the concrete next step to the decisive conversational evidence.'
if ! rg -U -F -- "${closing_template}" "${output_file}" >/dev/null; then
  fail "output contract does not contain the literal Portuguese blockquote template"
fi

english_closing_template=$'> **My view:** one clear conclusion about the subject and the decisive reason.\n>\n> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> `Sol High` ([View matrix](/absolute/path/to/think-with-me/references/model-comparison.md)) · connect the concrete next step to the decisive conversational evidence.'
if ! rg -U -F -- "${english_closing_template}" "${output_file}" >/dev/null; then
  fail "output contract does not contain the literal English blockquote template"
fi
if ! rg -U -F -- "${english_closing_template}" "${skill_file}" >/dev/null; then
  fail "public core does not contain the literal English blockquote template"
fi

if rg -n -i 'grilling|^> \*\*(Minha visão|Próximo passo):\*\*|Modelo para o próximo passo|Model for the next step' "${skill_file}" >/dev/null; then
  fail "public core contains internal or language-specific copy"
fi

if rg -n '^> \*\*(Minha visão|My view):\*\*.*\?' "${skill_file}" "${output_file}" >/dev/null; then
  fail "the localized view field must not contain a question"
fi

if rg -n -F '**Meu ponto de vista:**' "${skill_file}" "${output_file}" >/dev/null; then
  fail "legacy point-of-view label still exists in the active contract"
fi

if rg -n -F '**Modelo para continuar:**' "${skill_file}" "${output_file}" >/dev/null; then
  fail "legacy verbose model label still exists in the active contract"
fi

if printf '%s\n' 'asynchronous' | has_repository_governance_vocabulary; then
  fail 'repository-governance matcher rejects asynchronous'
fi

for governance_phrase in subagent handoff project-context commit push sync 'approval routing' 'next-task routing'; do
  if ! printf '%s\n' "${governance_phrase}" | has_repository_governance_vocabulary; then
    fail "repository-governance matcher missed ${governance_phrase}"
  fi
done

if rg -n -i -e "${repository_governance_pattern}" \
  "${skill_file}" "${routing_file}" "${output_file}" >/dev/null; then
  fail "installable contract still contains orchestration or repository-governance vocabulary"
fi

if rg -n -F '**Modelo:** Terra High.' "${skill_file}" "${output_file}" >/dev/null; then
  fail "legacy context-free model line still exists in the active contract"
fi

if rg -n -F '_Se mudar:_' "${skill_file}" "${routing_file}" "${output_file}" >/dev/null; then
  fail "legacy second-line model alternatives still exist in the active contract"
fi

model_footer_is_valid() {
  local footer="$1"
  local model_effort
  local link_label
  local link_target
  local reason

  [[ "${footer}" =~ ^\>\ \`([^\`]+)\`\ \(\[(.+)\]\((.+)\)\)\ ·\ (.+)$ ]] || return 1
  model_effort="${BASH_REMATCH[1]}"
  link_label="${BASH_REMATCH[2]}"
  link_target="${BASH_REMATCH[3]}"
  reason="${BASH_REMATCH[4]}"

  if [[ "${link_target}" == \<*\> ]]; then
    link_target="${link_target#<}"
    link_target="${link_target%>}"
  fi

  if rg -qiP '\b(agora|depois|now|later)\b|\p{S}|—|->|=>|<-|<=|</?[A-Za-z][^>]*>' <<<"${reason}"; then
    return 1
  fi

  [[ "${model_effort}" =~ ^(Sol[[:space:]](Medium|High|XHigh|Max)|Terra[[:space:]]Max|Luna[[:space:]]Max)$ ]] || return 1
  [[ -n "${link_label}" && "${link_label}" =~ [^[:space:]] ]] || return 1
  [[ "${link_target}" == /*/references/model-comparison.md ]] || return 1
  [[ "${link_target}" != *://* ]] || return 1
  [[ -n "${reason}" && "${reason}" =~ [^[:space:]] ]] || return 1
  ! rg -q '\*\*|_|—' <<<"${reason}"
  ! rg -qi '\b(Terra|Sol|Luna|None|Low|Medium|High|XHigh|Max)\b' <<<"${reason}"
}

model_footer_count=0
while IFS= read -r footer; do
  model_footer_count=$((model_footer_count + 1))
  model_footer_is_valid "${footer}" || fail "invalid model footer: ${footer}"
done < <(rg --no-filename '^> `(Terra|Sol|Luna) (None|Low|Medium|High|XHigh|Max)` \(' "${skill_file}" "${routing_file}" "${output_file}")
[[ "${model_footer_count}" -gt 0 ]] || fail "no model footer examples found"

invalid_model_footers=(
  '> `Sol High` · Agora fechar a regra.'
  '> `Sol High` → `Luna Medium` · fechar a regra.'
  '> <small>`Sol High` · fechar a regra.</small>'
  '> `Sol High / Max` · fechar a regra.'
  '> `Sol High` · Terra falhou e precisamos fechar.'
  '> `Sol High` · terra falhou e precisamos fechar.'
  '> `Sol High` · Max não resolveu o enquadramento.'
  '> `Sol High` · fechar a regra ← sem transição.'
  '> `Sol High` · fechar a regra ➡ sem transição.'
  '> `Sol High` · fechar a regra ⬅ sem transição.'
  '> `Sol High` · fechar a regra 🔄 sem transição.'
  '> `Sol High` · '
  '> `Sol High` ([Ver matriz](references/model-comparison.md)) · fechar a regra.'
  '> `Sol High` ([Ver matriz](https://github.com/igortice/think-with-me/blob/main/skills/think-with-me/references/model-comparison.md)) · fechar a regra.'
  '> `Sol High` ([Ver matriz](/absolute/path/to/other.md)) · fechar a regra.'
)
for footer in "${invalid_model_footers[@]}"; do
  if model_footer_is_valid "${footer}"; then
    fail "model footer validator accepted invalid fixture: ${footer}"
  fi
done

if rg -n '^> .*<br>|  $' "${skill_file}" "${routing_file}" "${output_file}" >/dev/null; then
  fail "model contract permits an explicit Markdown or HTML line break"
fi

if rg -n -F 'require_text "${skill_root}/SKILL.md"' "${repo_root}/scripts/validate-structure.sh" >/dev/null; then
  fail "structural validation duplicates semantic contract assertions"
fi

require_text "${repo_root}/scripts/validate-structure.sh" 'Structural validation passed.'
require_text "${repo_root}/scripts/validate-structure.sh" 'references/model-evidence.md'
require_text "${repo_root}/scripts/validate-structure.sh" 'references/model-comparison.md'
bash "${repo_root}/tests/sync-model-comparison.sh"
bash "${repo_root}/tests/verify-model-comparison-data.sh"
bash "${repo_root}/tests/verify-install-record.sh"
bash "${repo_root}/tests/current-model-documentation.sh"
latest_evidence_file="${repo_root}/evals/evidence-2026-07-31-value-first-routing.md"
latest_install_file="${repo_root}/evals/install-2026-07-31-value-first-routing.md"

require_text "${repo_root}/scripts/verify-evidence-record.sh" 'evals/evidence-2026-07-31-value-first-routing.md'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Static validation passed"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Runtime behavior passed"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Global parity"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Post-install runtime"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_top_level_line "LOCAL_CANDIDATE_STATUS: passed"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_top_level_line "GLOBAL_PARITY_STATUS: passed"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_top_level_line "POST_INSTALL_RUNTIME_STATUS: passed"'

require_text "${latest_evidence_file}" '`Luna Max` → `Sol Medium` → `Sol High` → `Terra Max`'
require_text "${latest_evidence_file}" '`Sol XHigh` for unresolved ambiguity'
require_text "${latest_evidence_file}" '`Sol Max` only for bounded critical risk'
require_text "${latest_evidence_file}" 'GLOBAL_PARITY_STATUS: passed'
require_text "${latest_evidence_file}" 'POST_INSTALL_RUNTIME_STATUS: passed'

if grep -Fq 'Public-release validation passed.' "${repo_root}/scripts/validate-skill.sh"; then
  fail "legacy validator still claims public-release validation"
fi

if rg -n -F '../../../docs/' "${repo_root}/skills/think-with-me" >/dev/null; then
  fail 'installable skill contains links that escape to repository-only docs'
fi

if rg -n '^\+#{1,6}[[:space:]]' "${readme_file}" "${skill_file}" >/dev/null; then
  fail 'public documentation contains a diff marker before a Markdown heading'
fi

verifier_script="${repo_root}/scripts/verify-evidence-record.sh"
if ! bash -c '
  source "$1"
  declare -F has_heading_in_file >/dev/null
  declare -F has_top_level_line_in_file >/dev/null
  declare -F verify_package_hashes >/dev/null
' _ "${verifier_script}"; then
  fail "evidence verifier does not expose its parsers through a source-safe internal interface"
fi

source "${verifier_script}"
parser_fixture_dir="$(mktemp -d "${TMPDIR:-/tmp}/think-with-me-evidence-parser.XXXXXX")"
trap 'rm -rf -- "${parser_fixture_dir}"' EXIT

mixed_fence_fixture="${parser_fixture_dir}/mixed-fence.md"
printf '%s\n' \
  '````markdown' \
  '~~~text' \
  '## Runtime behavior passed' \
  '~~~' \
  '```markdown' \
  '## Runtime behavior passed' \
  '```' \
  '````not-a-close' \
  '## Runtime behavior passed' \
  '````' >"${mixed_fence_fixture}"
if has_heading_in_file "${mixed_fence_fixture}" "## Runtime behavior passed"; then
  fail "evidence heading parser accepted a heading inside mixed or nested Markdown fences"
fi

top_level_heading_fixture="${parser_fixture_dir}/top-level-heading.md"
printf '%s\n' \
  '~~~text' \
  '## Runtime behavior passed' \
  '~~~' \
  '## Runtime behavior passed' >"${top_level_heading_fixture}"
has_heading_in_file "${top_level_heading_fixture}" "## Runtime behavior passed" || \
  fail "evidence heading parser rejected a genuine top-level heading"

fenced_provenance_fixture="${parser_fixture_dir}/fenced-provenance.md"
printf '%s\n' \
  '```text' \
  'No Task 4 evidence-gate implementation commit, push, publication, or global synchronization preceded this evidence record.' \
  '```' >"${fenced_provenance_fixture}"
if has_top_level_line_in_file "${fenced_provenance_fixture}" \
  'No Task 4 evidence-gate implementation commit, push, publication, or global synchronization preceded this evidence record.'; then
  fail "evidence parser accepted fenced-only provenance"
fi

indented_pending_heading_fixture="${parser_fixture_dir}/indented-pending-heading.md"
printf '%s\n' '  ## Runtime behavior pending' >"${indented_pending_heading_fixture}"
has_heading_in_file "${indented_pending_heading_fixture}" "## Runtime behavior pending" || \
  fail "evidence heading parser ignored a top-level heading indented by up to three spaces"

current_package_hash="$(sed -n 's/^PACKAGE_SHA256=//p' <<<"${manifest}")"
require_text "${latest_install_file}" 'Candidate id: `ea12e1f07447b0f65428026700903a32ea30d8c376214aa100aa01761193b352`'
require_text "${latest_install_file}" 'Backup: `/private/tmp/think-with-me-global-backup.iBs8zm`'
require_text "${latest_install_file}" 'Evaluator: `019fb9d6-7bc5-77e3-af6d-4924ca5b314a`'
require_text "${latest_install_file}" '/Users/igortice/.agents/skills/think-with-me/references/model-comparison.md'
require_text "${latest_install_file}" '`Luna Max` → `Sol Medium` → `Sol High` → `Terra Max`'
bash "${repo_root}/scripts/verify-install-record.sh" \
  "${latest_install_file}" \
  "${current_package_hash}"
conflicting_package_hash='0000000000000000000000000000000000000000000000000000000000000000'

valid_hash_fixture="${parser_fixture_dir}/valid-hashes.md"
printf '%s\n' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" >"${valid_hash_fixture}"
( verify_package_hashes "${valid_hash_fixture}" "${current_package_hash}" ) || \
  fail "evidence hash parser rejected repeated current structured hashes"

conflicting_hash_fixture="${parser_fixture_dir}/conflicting-hash.md"
printf '%s\n' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  "- \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" >"${conflicting_hash_fixture}"
if ( verify_package_hashes "${conflicting_hash_fixture}" "${current_package_hash}" ) 2>/dev/null; then
  fail "evidence hash parser accepted conflicting structured hashes"
fi

star_hash_fixture="${parser_fixture_dir}/star-hash.md"
printf '%s\n' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  "* \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" >"${star_hash_fixture}"
if ( verify_package_hashes "${star_hash_fixture}" "${current_package_hash}" ) 2>/dev/null; then
  fail "evidence hash parser accepted a conflicting asterisk field"
fi

plus_hash_fixture="${parser_fixture_dir}/plus-hash.md"
printf '%s\n' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  "+ \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" >"${plus_hash_fixture}"
if ( verify_package_hashes "${plus_hash_fixture}" "${current_package_hash}" ) 2>/dev/null; then
  fail "evidence hash parser accepted a conflicting plus field"
fi

indented_hash_fixture="${parser_fixture_dir}/indented-hashes.md"
printf '%s\n' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  " - \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" \
  "  - \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" \
  "   - \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" >"${indented_hash_fixture}"
if ( verify_package_hashes "${indented_hash_fixture}" "${current_package_hash}" ) 2>/dev/null; then
  fail "evidence hash parser accepted conflicting fields indented by one to three spaces"
fi

fenced_old_hash_fixture="${parser_fixture_dir}/fenced-old-hash.md"
printf '%s\n' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  '```text' \
  "* \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" \
  "+ \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" \
  "   - \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" \
  '```' >"${fenced_old_hash_fixture}"
( verify_package_hashes "${fenced_old_hash_fixture}" "${current_package_hash}" ) || \
  fail "evidence hash parser rejected an old hash that appears only inside a fence"

indented_code_fixture="${parser_fixture_dir}/indented-code.md"
printf '%s\n' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  "    - \`PACKAGE_SHA256\`: \`${conflicting_package_hash}\`" \
  '    ## Runtime behavior pending' >"${indented_code_fixture}"
( verify_package_hashes "${indented_code_fixture}" "${current_package_hash}" ) || \
  fail "evidence hash parser rejected a historical hash inside an indented code block"
if has_heading_in_file "${indented_code_fixture}" "## Runtime behavior pending"; then
  fail "evidence heading parser accepted a heading inside an indented code block"
fi

raw_only_hash_fixture="${parser_fixture_dir}/raw-only-hash.md"
printf '%s\n' \
  "The current package hash is ${current_package_hash}." \
  '```text' \
  "- \`PACKAGE_SHA256\`: \`${current_package_hash}\`" \
  '```' >"${raw_only_hash_fixture}"
if ( verify_package_hashes "${raw_only_hash_fixture}" "${current_package_hash}" ) 2>/dev/null; then
  fail "evidence hash parser accepted a current hash found only in prose or raw output"
fi

malformed_hash_fixture="${parser_fixture_dir}/malformed-hash.md"
printf '%s\n' \
  "Current hash: ${current_package_hash}" \
  '- `PACKAGE_SHA256`: `1234`' >"${malformed_hash_fixture}"
if ( verify_package_hashes "${malformed_hash_fixture}" "${current_package_hash}" ) 2>/dev/null; then
  fail "evidence hash parser accepted a malformed structured hash"
fi

bash "${repo_root}/scripts/verify-evidence-record.sh"

echo "Evidence Gate v1 checks passed."
