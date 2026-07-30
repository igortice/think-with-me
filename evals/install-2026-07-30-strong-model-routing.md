# Global installation verification — strong-model routing

Date: 2026-07-30
Candidate package: `ced936a55a1c69db1632224cedba0dabe097131c4434095ff6e06f5bef02285b`

## Synchronization

The previous global installation differed from the candidate in `SKILL.md`,
`agents/openai.yaml`, `model-evidence.md`, `model-routing.md`, and
`output-contract.md`, and it did not contain
`model-evidence-2026-07-20.md`.

Before synchronization, the installed directory was copied to the temporary,
recoverable backup:

```text
/private/tmp/think-with-me-global-backup.urJpHj
```

The validated package was then copied to the global installation. The command
`bash scripts/verify-global-install.sh` passed, and independent SHA-256 checks
matched for `SKILL.md`, `model-routing.md`, and the immutable historical
snapshot.

## Post-install runtime

Fresh isolated name-based invocations loaded the global skill and did not read
the repository, evals, or tests.

| Scenario | Agent | Expected | Observed |
| --- | --- | --- | --- |
| Project and architecture discovery without judgment | `019fb484-a4b6-7982-8b32-b328f6b8ac7a` | `Sol Medium` | `Sol Medium` |
| Heterogeneous agents, tools, and interdependent execution | `019fb484-a7c3-7af3-8ee4-a92099262d86` | `Terra Max` | `Terra Max` |
| Homogeneous fixed-schema volume with automatic validation | `019fb484-a63c-79e2-8236-5c600ceba347` | `Luna Max` | `Luna Max` |

## Result

GLOBAL_PARITY_STATUS: passed
POST_INSTALL_RUNTIME_STATUS: passed

The stale routes reproduced before synchronization were not reproduced after
global parity. This record does not claim a commit, push, public publication,
or skills.sh refresh.
