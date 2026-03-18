# Security Model

## Assumptions

- Private keys are securely managed by participants
- The arbiter is trusted if configured
- Supported tokens behave as expected

## Controls

- Explicit state machine
- Role-based access checks
- Reentrancy guard on fund-moving paths
- Exact amount matching on deposit

## Production recommendations

- Independent audit
- Fuzz testing and invariants
- Token allowlists
- Monitoring and alerting
