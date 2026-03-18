# Threat Model

## Considered risks

- Reentrancy on settlement
- Malicious or non-standard token behavior
- Arbiter collusion or misconfiguration
- Deadline misuse or poor UX around timeout windows
- Integration-level assumptions that do not match contract state

## Mitigations

- State update before transfer
- Minimal role surface area
- Event indexing for independent verification
- Clear documentation of finality and timeout paths
