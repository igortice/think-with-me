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
output_file="${repo_root}/skills/think-with-me/references/output-contract.md"

require_text "${skill_file}" 'Use the language of the current user message'
require_text "${skill_file}" 'never output Portuguese prose or labels'
require_text "${skill_file}" 'one continuous Markdown blockquote'
require_text "${skill_file}" 'For an English user message, use `My view`, `Next step`, and `Model for the next step` exactly:'
require_text "${skill_file}" 'Open [the output contract](references/output-contract.md) before writing the closing'
require_text "${skill_file}" 'Do not output the three fields as ordinary paragraphs'
require_text "${skill_file}" 'one concrete next step'
require_text "${skill_file}" 'not a sequence, checklist, or bundle of actions'
require_text "${skill_file}" 'include your recommended answer'
require_text "${skill_file}" 'A short confirmation or approval keeps this conversational mode active'
require_text "${skill_file}" 'direct operational instruction that identifies the action to perform'
require_text "${skill_file}" 'announce that transition before executing it'
require_text "${skill_file}" 'one short physical Markdown line'
require_text "${skill_file}" 'Model recommendation is derived only after'
require_text "${skill_file}" 'conversation health'
require_text "${skill_file}" 'Do not substitute generic product or effort names for the selected family and effort.'
require_text "${output_file}" '**Minha visão:**'
require_text "${output_file}" '**Próximo passo:**'
require_text "${output_file}" '_Modelo para o próximo passo:'
require_text "${output_file}" '**My view:**'
require_text "${output_file}" '**Next step:**'
require_text "${output_file}" '_Model for the next step:'
require_text "${output_file}" '`Próximo passo` contains at most one `?` character'
require_text "${routing_file}" 'Recommend exactly one model and effort for the next step'
require_text "${routing_file}" 'Re-evaluate the recommendation whenever the conversation changes material phase'
require_text "${routing_file}" 'Conversation health modifies next-step fit'
require_text "${routing_file}" 'Never infer the active model'
require_text "${output_file}" 'one question and your recommended answer'
require_text "${output_file}" '_Modelo para o próximo passo: **Terra High**'
require_text "${output_file}" '_Model for the next step: **Terra High**'

closing_template=$'> **Minha visão:** one clear conclusion about the subject and the decisive reason.\n>\n> **Próximo passo:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> _Modelo para o próximo passo: **Terra High** — connect the concrete next step to the decisive conversational evidence._'
if ! rg -U -F -- "${closing_template}" "${output_file}" >/dev/null; then
  fail "output contract does not contain the literal Portuguese blockquote template"
fi

english_closing_template=$'> **My view:** one clear conclusion about the subject and the decisive reason.\n>\n> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.\n>\n> _Model for the next step: **Terra High** — connect the concrete next step to the decisive conversational evidence._'
if ! rg -U -F -- "${english_closing_template}" "${output_file}" >/dev/null; then
  fail "output contract does not contain the literal English blockquote template"
fi
if ! rg -U -F -- "${english_closing_template}" "${skill_file}" >/dev/null; then
  fail "public core does not contain the literal English blockquote template"
fi

if rg -n -i 'grilling|Minha visão|Próximo passo|Modelo para o próximo passo' "${skill_file}" >/dev/null; then
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
  local bold_delimiters
  local model_effort
  local reason

  footer_body="${footer#> }"
  if rg -qiP '\b(agora|depois|now|later)\b|\p{S}|->|=>|<-|<=|</?[A-Za-z][^>]*>' <<<"${footer_body}"; then
    return 1
  fi

  bold_delimiters="$(grep -o '\*\*' <<<"${footer}" | wc -l | tr -d ' ')"
  [[ "${bold_delimiters}" == "2" ]] || return 1

  model_effort="$(sed -E 's/^> _(Modelo para o próximo passo|Model for the next step): \*\*([^*]+)\*\*.*/\2/' <<<"${footer}")"
  [[ "${model_effort}" =~ ^(Terra|Sol|Luna)[[:space:]](None|Low|Medium|High|XHigh|Max)$ ]] || return 1

  reason="$(sed -nE 's/^> _(Modelo para o próximo passo|Model for the next step): \*\*[^*]+\*\* — (.*)\._$/\2/p' <<<"${footer}")"
  [[ -n "${reason}" && "${reason}" =~ [^[:space:]] ]] || return 1
  ! rg -qi '\b(Terra|Sol|Luna|None|Low|Medium|High|XHigh|Max)\b' <<<"${reason}"
}

model_footer_count=0
while IFS= read -r footer; do
  model_footer_count=$((model_footer_count + 1))
  model_footer_is_valid "${footer}" || fail "invalid model footer: ${footer}"
done < <(rg --no-filename '^> _Modelo para o próximo passo:' "${skill_file}" "${routing_file}" "${output_file}")
while IFS= read -r footer; do
  model_footer_count=$((model_footer_count + 1))
  model_footer_is_valid "${footer}" || fail "invalid model footer: ${footer}"
done < <(rg --no-filename '^> _Model for the next step:' "${skill_file}" "${routing_file}" "${output_file}")
[[ "${model_footer_count}" -gt 0 ]] || fail "no model footer examples found"

invalid_model_footers=(
  '> _Modelo para o próximo passo: **Sol High** — Agora fechar a regra._'
  '> _Modelo para o próximo passo: **Sol High** → **Luna Medium**._'
  '> <small>Modelo para o próximo passo: **Sol High** — fechar a regra.</small>'
  '> _Modelo para o próximo passo: **Sol High / Max** — fechar a regra._'
  '> _Modelo para o próximo passo: **Sol High** — Terra falhou e precisamos fechar._'
  '> _Modelo para o próximo passo: **Sol High** — terra falhou e precisamos fechar._'
  '> _Modelo para o próximo passo: **Sol High** — Max não resolveu o enquadramento._'
  '> _Modelo para o próximo passo: **Sol High** — fechar a regra ← sem transição._'
  '> _Modelo para o próximo passo: **Sol High** — fechar a regra ➡ sem transição._'
  '> _Modelo para o próximo passo: **Sol High** — fechar a regra ⬅ sem transição._'
  '> _Modelo para o próximo passo: **Sol High** — fechar a regra 🔄 sem transição._'
  '> _Modelo para o próximo passo: **Sol High** — _'
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
