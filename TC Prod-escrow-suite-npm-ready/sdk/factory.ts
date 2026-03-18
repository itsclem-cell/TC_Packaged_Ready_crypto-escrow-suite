import { Contract } from "ethers";

export class EscrowFactorySDK {
  constructor(private contract: Contract) {}

  async createEscrow(
    payer: string,
    payee: string,
    arbiter: string,
    amount: bigint,
    releaseAfter: bigint,
    refundAfter: bigint
  ) {
    return this.contract.createEscrow(
      payer,
      payee,
      arbiter,
      amount,
      releaseAfter,
      refundAfter
    );
  }

  async feeRecipient() {
    return this.contract.feeRecipient();
  }

  async defaultFeeBps() {
    return this.contract.defaultFeeBps();
  }
}
