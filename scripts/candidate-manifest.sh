#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_root="${repo_root}/skills/think-with-me"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

cd "${repo_root}"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "must run inside a Git repository"
[[ -d "${skill_root}" ]] || fail "missing skill package: skills/think-with-me"

base_commit="$(git rev-parse HEAD)"
branch="$(git branch --show-current)"
branch="${branch:-detached}"
changed_files="$({ git diff --name-only HEAD; git ls-files --others --exclude-standard; } | LC_ALL=C sort -u)"
if [[ -n "${changed_files}" ]]; then
  candidate_scope="worktree"
else
  candidate_scope="clean_commit"
  changed_files="$(git ls-files)"
fi

package_hashes="$(
  cd "${skill_root}"
  find . -type f -print | LC_ALL=C sort | while IFS= read -r file; do
    hash="$(shasum -a 256 "${file}" | awk '{print $1}')"
    printf '%s  %s\n' "${hash}" "${file#./}"
  done
)"
package_sha256="$(printf '%s\n' "${package_hashes}" | shasum -a 256 | awk '{print $1}')"

file_hashes="$(
  while IFS= read -r file; do
    [[ -f "${file}" ]] || continue
    hash="$(shasum -a 256 "${file}" | awk '{print $1}')"
    printf '%s  %s\n' "${hash}" "${file}"
  done <<<"${changed_files}"
)"
[[ -n "${file_hashes}" ]] || fail "candidate contains no regular files"

candidate_id="$(printf 'base=%s\npackage=%s\nfiles=%s\n' "${base_commit}" "${package_sha256}" "${file_hashes}" | shasum -a 256 | awk '{print $1}')"

printf 'CANDIDATE_FORMAT=1\n'
printf 'BASE_COMMIT=%s\n' "${base_commit}"
printf 'BRANCH=%s\n' "${branch}"
printf 'CANDIDATE_SCOPE=%s\n' "${candidate_scope}"
printf 'PACKAGE_SHA256=%s\n' "${package_sha256}"
printf 'CANDIDATE_ID=%s\n' "${candidate_id}"
while IFS= read -r entry; do
  printf 'FILE_SHA256=%s\n' "${entry}"
done <<<"${file_hashes}"
