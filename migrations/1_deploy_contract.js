const Dummy_token = artifacts.require("Dummy");
const Tether_token = artifacts.require("Tether");
const staking_dapp = artifacts.require("staking_dapp");

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(Tether_token);
    const tether_token = await Tether_token.deployed();
    
    await deployer.deploy(Dummy_token);
    const dummy_token = await Dummy_token.deployed();

    await deployer.deploy(staking_dapp, dummy_token.address, tether_token.address);
    const staking_token = await staking_dapp.deployed();
    
    await dummy_token.transfer(staking_token.address, '100000000000000000');

    await tether_token.transfer(accounts[1], '100000000000000000');
}