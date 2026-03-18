# Escrow Lifecycle

1. Factory deploys escrow with payer, payee, amount, and deadlines.
2. Payer deposits funds.
3. Escrow becomes funded.
4. Settlement occurs via:
   - dual release approval
   - dual refund approval
   - timeout release
   - timeout refund
   - arbiter decision after dispute
5. Escrow reaches final state: released or refunded.
