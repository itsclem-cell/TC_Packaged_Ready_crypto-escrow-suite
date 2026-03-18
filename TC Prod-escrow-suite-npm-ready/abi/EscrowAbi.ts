export const escrowAbi = [
  "function deposit() payable",
  "function approveRelease()",
  "function approveRefund()",
  "function raiseDispute()",
  "function arbiterRelease()",
  "function arbiterRefund()",
  "function releaseByTimeout()",
  "function refundByTimeout()"
] as const;
