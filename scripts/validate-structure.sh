#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_root="${repo_root}/skills/think-with-me"
skills_ref_source="${SKILLS_REF_SOURCE:-git+https://github.com/agentskills/agentskills.git@38a2ff82958afee88dadf4831509e6f7e9d8ef4e#subdirectory=skills-ref}"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

require_file() {
  [[ -f "$1" ]] || fail "missing required file: ${1#"${repo_root}/"}"
}

require_file "${repo_root}/README.md"
require_file "${repo_root}/LICENSE"
require_file "${skill_root}/SKILL.md"
require_file "${skill_root}/agents/openai.yaml"
require_file "${skill_root}/references/model-routing.md"
require_file "${skill_root}/references/output-contract.md"

expected_manifest=$'SKILL.md\nagents/openai.yaml\nreferences/model-routing.md\nreferences/output-contract.md'
actual_manifest="$(cd "${skill_root}" && find . -type f -print | sed 's#^./##' | LC_ALL=C sort)"
[[ "${actual_manifest}" == "${expected_manifest}" ]] || fail "installable package contains unexpected or missing files"

bash -n "${repo_root}/scripts/candidate-manifest.sh"
bash -n "${repo_root}/scripts/verify-evidence-record.sh"
bash -n "${repo_root}/scripts/validate-structure.sh"
bash -n "${repo_root}/scripts/validate-skill.sh"
bash -n "${repo_root}/tests/evidence-gate-v1.sh"

uvx --from "${skills_ref_source}" skills-ref validate "${skill_root}"

echo "Structural validation passed."
