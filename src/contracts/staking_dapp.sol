//SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.4.22 < 0.9.0;
import "./Dummy_token.sol";
import "./Tether_token.sol";

contract staking_dapp{
    string public name = "staking_dapp";
    address public owner;
    Dummy public dummy_token;
    Tether public tether_token;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaked;
    mapping(address => bool) public isStaking;

    constructor (Dummy _dummyToken, Tether _tetherToken) {
        dummy_token = _dummyToken;
        tether_token = _tetherToken;
        owner = msg.sender;

    }

    function stakeToken(uint _amount) public{
        require(_amount > 0, "amount cannot be zero");
        tether_token.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }

        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    function unstakeToken() public {
        uint balance = stakingBalance[msg.sender];
        require (balance > 0, "staking balance is zero");
        tether_token.transfer(msg.sender, balance);
        stakingBalance[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }

    function issueDummy() public {
        require(msg.sender == owner, "caller must be the owner for this function");
        for (uint i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if (balance > 0){
                dummy_token.transfer (recipient, balance);
            }
        }
    }
}



