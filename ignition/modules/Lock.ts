import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const LockModule = buildModule("MultisigFactory", (m) => {

    const message ="Hello"

  const multisigFactory = m.contract("MultisigFactory",[message]);

  return { multisigFactory };
});

export default LockModule;
