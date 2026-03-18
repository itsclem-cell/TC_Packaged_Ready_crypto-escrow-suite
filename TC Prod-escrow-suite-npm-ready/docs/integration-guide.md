# Integration Guide

## Typical integration flow

- Deploy factory
- Create escrow instance per transaction
- Store escrow address in application database
- Listen to contract events
- Update UI and notifications based on state

## Events to index

- Deposited
- ReleaseApproved
- RefundApproved
- DisputeRaised
- Released
- Refunded
