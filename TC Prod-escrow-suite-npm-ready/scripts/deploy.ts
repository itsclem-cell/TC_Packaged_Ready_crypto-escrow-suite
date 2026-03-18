import { ethers } from "hardhat";

async function main() {
  const feeRecipient = process.env.FEE_RECIPIENT;
  const defaultFeeBps = Number(process.env.DEFAULT_FEE_BPS ?? 50);

  if (!feeRecipient) {
    throw new Error("Missing FEE_RECIPIENT in environment");
  }

  const Factory = await ethers.getContractFactory("EscrowFactory");
  const factory = await Factory.deploy(feeRecipient, defaultFeeBps);
  await factory.waitForDeployment();

  console.log("EscrowFactory deployed to:", await factory.getAddress());
  console.log("Fee recipient:", feeRecipient);
  console.log("Default fee bps:", defaultFeeBps);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
