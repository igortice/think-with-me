# Runtime captures — strong-model routing baseline

Date: 2026-07-30
Candidate package: `ced936a55a1c69db1632224cedba0dabe097131c4434095ff6e06f5bef02285b`

These isolated runs received a skill attachment by name and path, but the host
did not attest which source bytes it loaded. They are retained as negative
source-fidelity evidence rather than candidate-policy failures.

## Baseline 1 — project and architecture discovery

- Agent: `019fb47d-3e46-7a73-9c6a-fe66665db461`
- Scenario: understand project components without choosing an architecture.
- Observed footer:

```md
> `Terra Max` · organizar a exploração contextual e revisável do fluxo atual antes de qualquer decisão.
```

- Result: **FAIL**. The candidate requires `Sol Medium`.

## Baseline 2 — structured high-volume processing

- Agent: `019fb47d-4961-78a3-9239-702519175bd0`
- Scenario: 800 independent extractions, fixed schema, no open judgment, cheap
  automatic validation.
- Observed footer:

```md
> `Luna Medium` · validar o lote piloto do schema fechado com checagem automática barata.
```

- Result: **FAIL**. The pair is outside the hard allowlist; the candidate
  requires `Luna Max`.

## Baseline 3 — heterogeneous agent execution

- Agent: `019fb47d-4646-78a0-be3e-200eb3794ed7`
- Scenario: architecture and acceptance contract closed; agents, tools,
  interdependent changes, and intermediate state remain.
- Observed footer:

```md
> `Sol High` · conduzir a execução interdependente com qualidade conservadora e direção já fechada.
```

- Result: **FAIL**. The candidate requires `Terra Max`.

## Diagnosis

The three outputs reproduce superseded routing despite the local candidate
already containing the new matrix. A later evaluator explicitly observed a
difference between repository source and host-loaded behavior. Therefore the
final run reads the exact local `SKILL.md`, `model-routing.md`, and
`output-contract.md` paths before responding, and global parity remains a
separate release gate.
