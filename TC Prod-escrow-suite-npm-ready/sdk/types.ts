export type EscrowRole = "payer" | "payee" | "arbiter";

export interface EscrowConfig {
  payer: string;
  payee: string;
  arbiter: string;
  amount: bigint;
  releaseAfter: bigint;
  refundAfter: bigint;
}
