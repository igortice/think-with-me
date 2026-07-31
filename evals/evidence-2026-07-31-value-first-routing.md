# Value-first model-routing evidence

Date: 2026-07-31

- `PACKAGE_SHA256`: `6d7ea4872704880360981b46b0b4947417b55e76c27ae52ab3f393a4b67f0b62`
- `CANDIDATE_ID`: `e2f65d4cbb5df58e25d5f1b0cf1e1303cc1c8028f79034417f1e04e2aa4044da`

## Static validation passed

LOCAL_CANDIDATE_STATUS: passed

The policy is restricted to `Luna Max`, `Sol Medium`, `Sol High`, `Terra Max`, `Sol XHigh`, and `Sol Max`. Selection applies latency and risk gates before choosing the cheapest configuration that meets the required quality floor.

## Runtime behavior passed

A fresh evaluator using only the globally installed skill produced the intended transition:

`Luna Max` → `Sol Medium` → `Sol High` → `Terra Max`

- `Luna Max`: ordinary non-consequential project understanding where extra startup delay is acceptable.
- `Sol Medium`: latency-sensitive, rapid conversational recovery.
- `Sol High`: consequential architectural judgment with clear trade-offs.
- `Terra Max`: quality-first execution with heterogeneous, interdependent agents and tools.

The residual-risk routes remain `Sol XHigh` for unresolved ambiguity and `Sol Max` only for bounded critical risk still unresolved after the narrower route.

## Global parity

GLOBAL_PARITY_STATUS: passed

`scripts/verify-global-install.sh` confirmed that the installed skill matches the repository package.

## Post-install runtime

POST_INSTALL_RUNTIME_STATUS: passed

Evaluator `019fb9a6-05df-7512-b93a-6641634e694e` exercised all four value/speed/judgment/execution transitions after installation.
