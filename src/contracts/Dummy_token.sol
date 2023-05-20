//SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.4.22 < 0.9.0;

contract Dummy {
    string public name = "Dummy Token";
    string public symbol = "DUM_TOKEN";
    uint public totalSupply = 100000000000000000;
    uint public decimal = 18;

    event Transfer(
        address indexed _from, 
        address indexed _to, 
        uint _value
    );

    event Approve(
        address indexed _owner, 
        address indexed _spender, 
        uint _value
    );

    mapping (address => uint256) public balance;
    mapping (address => mapping(address => uint256)) public allowance;

    constructor() {
        balance [msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns(bool){
        require(balance[msg.sender] >= _value);
        balance [msg.sender] -= _value;
        balance [_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve (address _spender, uint256 _value) public returns(bool _success){
        allowance[msg.sender][_spender] = _value;
        emit Approve(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(_value <= balance[_from]);
        require(_value <= allowance[_from][msg.sender]);
        balance[_from] -= _value;
        balance[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    
}