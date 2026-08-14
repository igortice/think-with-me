# Progressive-disclosure model-routing evidence

Date: 2026-08-14

- `PACKAGE_SHA256`: `49469f80f8857dcae42e0c6b486ab973aa6b6969f8ca81ddbeff0cbe953165e2`

## Static validation passed

LOCAL_CANDIDATE_STATUS: passed

The six eligible pairs and their routing boundaries are unchanged. The
synchronization regression proves that README receives the complete public
comparison while `SKILL.md` receives only the reviewed routing summary.
`strong-model-routing-policy.sh` continues to cover `Luna Max`, `Sol Medium`,
`Sol High`, `Terra Max`, `Sol XHigh`, and `Sol Max` without keyword-only
routing.

## Runtime behavior passed

The routing transition remains:

`Luna Max` → `Sol Medium` → `Sol High` → `Terra Max`

The residual-risk routes remain `Sol XHigh` for unresolved ambiguity and
`Sol Max` only for bounded critical risk left unresolved after the narrower
selective route. This candidate changes progressive disclosure and generated
projections, not those behavioral boundaries.

## Global parity

GLOBAL_PARITY_STATUS: passed

`scripts/verify-global-install.sh` confirmed that the installed skill matches
the repository package byte for byte.

## Post-install runtime

POST_INSTALL_RUNTIME_STATUS: passed

The installed `SKILL.md` contains `MODEL_ROUTING_SUMMARY_START`, the six-route
summary, and no `Cross-checked data` section. The installed
`references/model-comparison.md` contains the complete benchmark table and no
technical synchronization marker. The local routing and documentation
regression suites passed against the same package.
