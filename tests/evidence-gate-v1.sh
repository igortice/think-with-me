#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_file() {
  [[ -f "$1" ]] || fail "missing file: ${1#"${repo_root}/"}"
}

require_text() {
  local file="$1"
  local pattern="$2"
  grep -Fq -- "$pattern" "$file" || fail "missing text in ${file#"${repo_root}/"}: $pattern"
}

require_file "${repo_root}/scripts/candidate-manifest.sh"
require_file "${repo_root}/scripts/validate-structure.sh"
require_file "${repo_root}/scripts/verify-evidence-record.sh"
require_file "${repo_root}/evals/evidence-run-template.md"
require_file "${repo_root}/evals/model-routing-evidence-template.md"
require_file "${repo_root}/evals/evidence-2026-07-19-evidence-based-routing.md"

manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
grep -Fq 'CANDIDATE_ID=' <<<"${manifest}" || fail "candidate manifest has no candidate id"
grep -Fq 'PACKAGE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no package hash"
grep -Fq 'FILE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no file hashes"

skill_file="${repo_root}/skills/think-with-me/SKILL.md"
routing_file="${repo_root}/skills/think-with-me/references/model-routing.md"
evidence_file="${repo_root}/docs/research/model-routing-evidence-2026-07-17.md"
model_evidence_file="${repo_root}/skills/think-with-me/references/model-evidence.md"
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
require_text "${skill_file}" 'never output Portuguese prose or labels'
require_text "${skill_file}" 'one continuous Markdown blockquote'
require_text "${skill_file}" 'For an English user message, use `My view` and `Next step` exactly, then render the model as an inline-code label:'
require_text "${skill_file}" 'Open [the output contract](references/output-contract.md) before writing the closing'
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
require_text "${output_file}" '`Sol High` ·'
require_text "${output_file}" '`Próximo passo` contains at most one `?` character'
require_text "${routing_file}" 'Recommend exactly one model and effort for the next step'
require_text "${routing_file}" 'Re-evaluate the recommendation whenever the conversation changes material phase'
require_text "${routing_file}" 'Conversation health modifies next-step fit'
require_text "${routing_file}" 'Never infer the active model'
require_text "${routing_file}" 'GPT-5.5 High is the historical quality baseline'
require_text "${routing_file}" 'Sol High is the conservative quality floor'
require_text "${routing_file}" 'Treat family and effort as one atomic configuration'
require_text "${routing_file}" 'Do not average heterogeneous benchmarks'
require_text "${routing_file}" 'Terra has no preferred route in the current evidence snapshot'
require_text "${evidence_file}" 'Esta é fonte primária **para a metodologia do Artificial Analysis**, mas não é fonte primária do produto OpenAI nem substitui o DeepSWE'
require_text "${evidence_file}" 'A metodologia do AA não deve preencher lacunas do DeepSWE.'
require_text "${model_evidence_file}" 'This file is the versioned evidence source for model-routing policy.'
require_text "${model_evidence_file}" '## Artificial Analysis snapshot'
require_text "${model_evidence_file}" 'the Coding Index is a 50/50 aggregate of Terminal-Bench 2.1 and'
require_text "${model_evidence_file}" '## DeepSWE v1.1 snapshot'
require_text "${model_evidence_file}" '## Local behavioral evidence status'
require_text "${output_file}" 'one question and your recommended answer'
require_text "${output_file}" '`Sol High` · connect the concrete next step to the decisive conversational evidence.'
require_text "${cases_file}" 'Compare A e B com estes fatos'
require_text "${cases_file}" 'inventar uma edição especulativa'
require_text "${cases_file}" '11. A configuração é escolhida como o par indivisível `família + effort`; a resposta não escolhe uma família antes de avaliar o effort.'
require_text "${cases_file}" '12. Decisões abertas que exigem contexto ou julgamento preservam `Sol High` como piso conservador em relação ao baseline histórico `GPT-5.5 High`.'
require_text "${cases_file}" '13. Uma rota econômica só aparece quando o trabalho está delimitado, é barato verificar o resultado e custo, latência ou volume são materiais.'
require_text "${cases_file}" '14. Benchmarks de domínios ou harnesses diferentes não são somados nem usados para declarar equivalência universal.'
require_text "${cases_file}" '15. Empates e fontes divergentes preservam a opção conservadora até existir evidência local suficiente.'
require_text "${cases_file}" 'Permitir `Luna Medium` somente depois de eliminar configurações que não atingem o critério de qualidade e comparar o custo total da tarefa entre as restantes; registrar a justificativa econômica como evidência local e provisória para a transformação delimitada e verificável.'
require_text "${multiturn_cases_file}" 'TWM-M10 — Execução concluída retoma a decisão'
require_text "${multiturn_cases_file}" 'o relatório do resultado também termina no fechamento da skill'
require_text "${multiturn_cases_file}" 'TWM-M11 — Inspeção separa fato de inferência'
require_text "${skill_file}" 'This continuity applies only while the host has loaded this skill for the current turn.'
require_text "${skill_file}" 'This source does not guarantee that the host will load this skill on a later turn.'
require_text "${skill_file}" 'When a later turn explicitly invokes this skill, recover the same decision context without asking the user to restate it.'
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
require_text "${multiturn_cases_file}" 'permitir a rota econômica documentada e justificar boundedness, volume e verificação barata.'
require_file "${routing_cases_file}"
require_text "${routing_cases_file}" 'MR-01 | Descoberta aberta de produto'
require_text "${routing_cases_file}" 'MR-02 | Comparação contextual'
require_text "${routing_cases_file}" 'MR-03 | Especificação técnica'
require_text "${routing_cases_file}" 'MR-04 | Migração irreversível'
require_text "${routing_cases_file}" 'MR-05 | Correções repetidas de framing'
require_text "${routing_cases_file}" 'MR-06 | Reescrita curta já decidida sem pressão material de custo'
require_text "${routing_cases_file}" 'MR-07 | Extração de schema em alto volume'
require_text "${routing_cases_file}" 'MR-08 | Código de longo horizonte'
require_text "${routing_cases_file}" 'MR-09 | Discordância entre Artificial Analysis e DeepSWE'
require_text "${routing_cases_file}" 'MR-10 | Empate por intervalo de confiança'
require_text "${routing_cases_file}" 'MR-11 | Pedido explícito de raciocínio mais profundo'
require_text "${routing_cases_file}" 'MR-12 | Frustração sem ambiguidade adicional'
require_text "${routing_cases_file}" 'Uma economia só pode comparar custo total da tarefa depois de eliminar configurações que não atingem a qualidade requerida; toda justificativa econômica permanece evidência local e provisória.'
require_text "${routing_cases_file}" 'Permitir `Luna Medium` somente depois de eliminar configurações que não atingem o critério de qualidade e comparar o custo total da tarefa entre as restantes; registrar a justificativa econômica como evidência local e provisória.'
require_text "${routing_cases_file}" 'O turno anterior recomendou `Sol High`; direção e texto-alvo estão definidos, mas custo, latência e volume não são materiais.'
require_text "${routing_cases_file}" 'Manter `Sol High`; não há rota econômica justificada.'
require_text "${routing_cases_file}" 'Preservar `Sol High` até haver evidência local comparável.'
require_text "${routing_cases_file}" 'Preservar `Sol High` e pedir evidência local suficiente antes de reduzir.'
require_text "${routing_cases_file}" 'A configuração anterior é `Sol High`; resta reescrever uma única frase já aprovada, com critérios claros e sem novo risco ou ambiguidade.'
require_text "${routing_cases_file}" 'Manter `Sol High` e corrigir a comunicação; não escalar só pelo sentimento.'
require_text "${metadata_file}" 'display_name: "Think With Me"'
require_text "${metadata_file}" 'short_description: "Understand a decision before acting, choose the next step, and select a GPT-5.6 model"'
require_text "${metadata_file}" 'default_prompt: "Use $think-with-me to understand this conversation, give your view, recommend the immediate next step, and select the GPT-5.6 model for that step in my language."'
require_text "${metadata_file}" 'allow_implicit_invocation: true'
require_text "${trigger_cases_file}" 'TWM-T01'
require_text "${trigger_cases_file}" 'TWM-T08'
require_text "${trigger_cases_file}" 'TWM-T09'
require_text "${trigger_cases_file}" 'Auditoria de documentação e testes antes de decidir uma correção.'
require_text "${trigger_cases_file}" 'Uma descoberta positiva melhora a ativação; ela não garante'
require_text "${workflow_file}" '- run: sudo apt-get update && sudo apt-get install --yes ripgrep'
require_text "${workflow_file}" '- run: bash tests/evidence-gate-v1.sh'
require_text "${release_runbook_file}" 'bash tests/evidence-gate-v1.sh'
require_text "${release_runbook_file}" 'evals/think-with-me-multiturn-cases.md'
require_text "${release_runbook_file}" 'TWM-M12'
require_text "${release_runbook_file}" 'TWM-M13'
require_text "${release_runbook_file}" '`agentMessage.text`'
require_text "${release_runbook_file}" 'cópia candidata local, repositório GitHub e página do skills.sh'
require_text "${release_runbook_file}" 'skills/think-with-me/references/model-evidence.md'
require_text "${release_runbook_file}" 'evals/model-routing-cases.md'
require_text "${release_runbook_file}" 'evals/evidence-2026-07-19-evidence-based-routing.md'
require_text "${routing_spec_file}" '**Status atual da candidata:** não sincronizada globalmente.'

if rg -Fq 'Only an explicit topic change or closure ends that continuity.' "${skill_file}"; then
  fail 'core skill still promises lifecycle control that belongs to the host'
fi

if rg -Fq 'First choose by next-step fit:' "${routing_file}"; then
  fail 'routing still chooses a family role before an atomic configuration'
fi

if rg -Fq 'Select the family first, then the effort.' "${routing_file}"; then
  fail 'routing still selects family before effort'
fi

if rg -Fq '**Status:** implementada, validada e sincronizada globalmente' "${routing_spec_file}"; then
  fail 'historical routing spec presents an older global synchronization as the current candidate state'
fi

closing_template=$'> **Minha visão:** one clear conclusion about the subject and the decisive reason.\n>\n> **Próximo passo:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> `Sol High` · connect the concrete next step to the decisive conversational evidence.'
if ! rg -U -F -- "${closing_template}" "${output_file}" >/dev/null; then
  fail "output contract does not contain the literal Portuguese blockquote template"
fi

english_closing_template=$'> **My view:** one clear conclusion about the subject and the decisive reason.\n>\n> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> `Sol High` · connect the concrete next step to the decisive conversational evidence.'
if ! rg -U -F -- "${english_closing_template}" "${output_file}" >/dev/null; then
  fail "output contract does not contain the literal English blockquote template"
fi
if ! rg -U -F -- "${english_closing_template}" "${skill_file}" >/dev/null; then
  fail "public core does not contain the literal English blockquote template"
fi

if rg -n -i 'grilling|Minha visão|Próximo passo|Modelo para o próximo passo|Model for the next step' "${skill_file}" >/dev/null; then
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

if rg -n -i 'subagent|handoff|project-context|commit|push|sync|approval routing|next-task routing' \
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
  local footer_body
  local model_effort
  local reason

  [[ "${footer}" =~ ^\>\ \`([^\`]+)\`\ ·\ (.+)$ ]] || return 1
  model_effort="${BASH_REMATCH[1]}"
  reason="${BASH_REMATCH[2]}"
  footer_body="${footer#> }"

  if rg -qiP '\b(agora|depois|now|later)\b|\p{S}|—|->|=>|<-|<=|</?[A-Za-z][^>]*>' <<<"${reason}"; then
    return 1
  fi

  [[ "${model_effort}" =~ ^(Terra|Sol|Luna)[[:space:]](None|Low|Medium|High|XHigh|Max)$ ]] || return 1
  [[ -n "${reason}" && "${reason}" =~ [^[:space:]] ]] || return 1
  ! rg -q '\*\*|_|—' <<<"${footer}"
  ! rg -qi '\b(Terra|Sol|Luna|None|Low|Medium|High|XHigh|Max)\b' <<<"${reason}"
}

model_footer_count=0
while IFS= read -r footer; do
  model_footer_count=$((model_footer_count + 1))
  model_footer_is_valid "${footer}" || fail "invalid model footer: ${footer}"
done < <(rg --no-filename '^> `(Terra|Sol|Luna) (None|Low|Medium|High|XHigh|Max)` · ' "${skill_file}" "${routing_file}" "${output_file}")
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
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'evals/evidence-2026-07-19-evidence-based-routing.md'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Static validation passed"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'reject_heading "## Runtime behavior pending"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Runtime behavior passed"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Independent review"'
require_text "${repo_root}/scripts/verify-evidence-record.sh" 'require_heading "## Global parity"'

if grep -Fq 'Public-release validation passed.' "${repo_root}/scripts/validate-skill.sh"; then
  fail "legacy validator still claims public-release validation"
fi

verifier_script="${repo_root}/scripts/verify-evidence-record.sh"
if ! bash -c '
  source "$1"
  declare -F has_heading_in_file >/dev/null
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

indented_pending_heading_fixture="${parser_fixture_dir}/indented-pending-heading.md"
printf '%s\n' '  ## Runtime behavior pending' >"${indented_pending_heading_fixture}"
has_heading_in_file "${indented_pending_heading_fixture}" "## Runtime behavior pending" || \
  fail "evidence heading parser ignored a top-level heading indented by up to three spaces"

current_package_hash="$(sed -n 's/^PACKAGE_SHA256=//p' <<<"${manifest}")"
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
