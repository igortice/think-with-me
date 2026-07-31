# Value-first model-routing evidence

Date: 2026-07-31

- `PACKAGE_SHA256`: `c72c06877a4eeeeb0a18ca3349d2068db2509c5478c52dd2baddc632ee93090c`
- `CANDIDATE_ID`: `86af68c87bd37876e2eb024af4f2e57285bd3a6f945dd02e2b8cdf600ca22648`

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

Evaluator `019fb9d6-7bc5-77e3-af6d-4924ca5b314a` exercised all four value/speed/judgment/execution transitions after installation. Every footer linked `View matrix` to the absolute installed path `/Users/igortice/.agents/skills/think-with-me/references/model-comparison.md`.

The routing contract is unchanged in the marker-cleanup candidate. A fresh
post-install local check verified global byte parity and confirmed that the
linked matrix contains its two user-facing sections without either technical
synchronization marker.
