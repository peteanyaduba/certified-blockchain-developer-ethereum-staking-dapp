const stakingDapp = artifacts.require('staking_dapp');

module.exports = async function (callback){
    let stakingdapp = await stakingDapp.deployed();

    await stakingdapp.issueDummy();

    console.log("dummy token issue");
    callback();
}