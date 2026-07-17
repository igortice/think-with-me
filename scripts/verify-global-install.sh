#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="${repo_root}/skills/think-with-me"
target_dir="${THINK_WITH_ME_GLOBAL_DIR:-${HOME}/.agents/skills/think-with-me}"

if [[ ! -d "${source_dir}" ]]; then
  echo "Source skill directory not found: ${source_dir}" >&2
  exit 1
fi

if [[ ! -d "${target_dir}" ]]; then
  echo "Global skill directory not found: ${target_dir}" >&2
  exit 1
fi

if diff -qr "${source_dir}" "${target_dir}"; then
  echo "Global think-with-me installation matches the repository source."
else
  echo "Global think-with-me installation differs from the repository source." >&2
  exit 1
fi
