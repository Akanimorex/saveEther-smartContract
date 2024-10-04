import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const TokenModule = buildModule("ProposalContract", (m) => {

  const proposal = m.contract("ProposalContract");

  return { proposal };
});

export default TokenModule;
