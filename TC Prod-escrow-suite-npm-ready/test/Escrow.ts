import { expect } from "chai";
import { ethers } from "hardhat";

describe("Escrow", function () {
  it("creates, funds and releases with protocol fee", async function () {
    const [payer, payee, arbiter, feeRecipient] = await ethers.getSigners();
    const Escrow = await ethers.getContractFactory("Escrow");
    const now = Math.floor(Date.now() / 1000);
    const amount = ethers.parseEther("1");

    const escrow = await Escrow.deploy(
      payer.address,
      payee.address,
      arbiter.address,
      feeRecipient.address,
      amount,
      now + 3600,
      now + 7200,
      50
    );

    await escrow.connect(payer).deposit({ value: amount });

    const payeeBalanceBefore = await ethers.provider.getBalance(payee.address);
    const feeBalanceBefore = await ethers.provider.getBalance(feeRecipient.address);

    await escrow.connect(payer).approveRelease();
    await escrow.connect(payee).approveRelease();

    const fee = await escrow.feeAmount();
    const payout = await escrow.payoutAmount();

    expect(await escrow.state()).to.equal(3n);
    expect(await ethers.provider.getBalance(payee.address)).to.equal(payeeBalanceBefore + payout);
    expect(await ethers.provider.getBalance(feeRecipient.address)).to.equal(feeBalanceBefore + fee);
  });
});
