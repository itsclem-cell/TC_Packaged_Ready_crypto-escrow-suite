import { Contract } from "ethers";

export class EscrowSDK {
  constructor(private contract: Contract) {}

  async deposit(amount: bigint) {
    return this.contract.deposit({ value: amount });
  }

  async approveRelease() {
    return this.contract.approveRelease();
  }

  async approveRefund() {
    return this.contract.approveRefund();
  }

  async raiseDispute() {
    return this.contract.raiseDispute();
  }

  async feeAmount() {
    return this.contract.feeAmount();
  }

  async payoutAmount() {
    return this.contract.payoutAmount();
  }

  async feeBps() {
    return this.contract.feeBps();
  }

  async feeRecipient() {
    return this.contract.feeRecipient();
  }
}
