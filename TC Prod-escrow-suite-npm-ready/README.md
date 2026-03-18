# EVM Escrow Suite

Production-grade programmable escrow infrastructure for EVM-compatible applications.

This repository provides a modular escrow system for conditional payments across marketplaces, services, and global commerce. It includes native asset and ERC-20 escrow flows, arbiter-driven dispute resolution, timeout-based settlement, a factory deployment pattern, and a lightweight TypeScript SDK.

## Package status

This repo is ready to publish as an npm package after you update these placeholders in `package.json`:

- `@YOUR_NPM_USERNAME/evm-escrow-suite`
- `YOUR_GITHUB_USERNAME`

## Install

```bash
npm install @YOUR_NPM_USERNAME/evm-escrow-suite
```

## What the package exports

- `EscrowSDK`
- `EscrowFactorySDK`
- `escrowAbi`
- `factoryAbi`
- shared SDK types

## Quick start

```ts
import { ethers } from "ethers";
import {
  EscrowSDK,
  EscrowFactorySDK,
  escrowAbi,
  factoryAbi
} from "@YOUR_NPM_USERNAME/evm-escrow-suite";

const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
const signer = new ethers.Wallet(process.env.PRIVATE_KEY!, provider);

const escrow = new ethers.Contract("0xYourEscrow", escrowAbi, signer);
const sdk = new EscrowSDK(escrow);

await sdk.approveRelease();
```

## Publish

The fastest route for an open-source public package is the public npm registry.

See `PUBLISHING.md` for the exact steps and which option to choose.

## Repository structure

```text
contracts/          Solidity contracts
sdk/                TypeScript SDK
abi/                ABI exports
scripts/            Deployment scripts
test/               Hardhat tests
docs/               Integration and architecture docs
examples/           Example frontend/backend stubs
```

## Security notice

This is infrastructure for handling value. Do not use in production without a proper review, full local test run, and external audit.

## License

MIT
