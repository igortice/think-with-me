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

manifest="$(bash "${repo_root}/scripts/candidate-manifest.sh")"
grep -Fq 'CANDIDATE_ID=' <<<"${manifest}" || fail "candidate manifest has no candidate id"
grep -Fq 'PACKAGE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no package hash"
grep -Fq 'FILE_SHA256=' <<<"${manifest}" || fail "candidate manifest has no file hashes"

skill_file="${repo_root}/skills/think-with-me/SKILL.md"
routing_file="${repo_root}/skills/think-with-me/references/model-routing.md"
evidence_file="${repo_root}/docs/research/model-routing-evidence-2026-07-17.md"
output_file="${repo_root}/skills/think-with-me/references/output-contract.md"
metadata_file="${repo_root}/skills/think-with-me/agents/openai.yaml"
cases_file="${repo_root}/evals/think-with-me-cases.md"
multiturn_cases_file="${repo_root}/evals/think-with-me-multiturn-cases.md"
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
require_text "${output_file}" '`Terra High` ·'
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
require_text "${evidence_file}" 'DeepSWE v1.1'
require_text "${evidence_file}" 'Artificial Analysis Coding Index'
require_text "${output_file}" 'one question and your recommended answer'
require_text "${output_file}" '`Terra High` · connect the concrete next step to the decisive conversational evidence.'
require_text "${cases_file}" 'Compare A e B com estes fatos'
require_text "${cases_file}" 'inventar uma edição especulativa'
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

closing_template=$'> **Minha visão:** one clear conclusion about the subject and the decisive reason.\n>\n> **Próximo passo:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> `Terra High` · connect the concrete next step to the decisive conversational evidence.'
if ! rg -U -F -- "${closing_template}" "${output_file}" >/dev/null; then
  fail "output contract does not contain the literal Portuguese blockquote template"
fi

english_closing_template=$'> **My view:** one clear conclusion about the subject and the decisive reason.\n>\n> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> `Terra High` · connect the concrete next step to the decisive conversational evidence.'
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

if grep -Fq 'Public-release validation passed.' "${repo_root}/scripts/validate-skill.sh"; then
  fail "legacy validator still claims public-release validation"
fi

bash "${repo_root}/scripts/verify-evidence-record.sh"

echo "Evidence Gate v1 checks passed."
