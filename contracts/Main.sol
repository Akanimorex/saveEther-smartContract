// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SaveEther{
    address owner;

    mapping(address=>uint) balances;

    constructor(){
        owner =msg.sender;
    }

    event DepositSuccessful(address indexed user, uint256 indexed _amount );
    event WithdrawSuccessful(address indexed user, uint256 indexed _amount );
     event TransferSuccessful(address indexed user, uint256 indexed _amount );



    function deposit() external payable{
        //sanity check
        require(msg.sender != address(0), "address zero detected");
        require(msg.value > 0, "cannot deposit 0");

        balances[msg.sender] += msg.value;

        emit DepositSuccessful(msg.sender, msg.value);

    }

    function withdraw(uint256 _amount) external {

        require(msg.sender != address(0), "address zero detected");
        require(_amount > 0, "cannot withdraw  0");
        require(balances[msg.sender]>= _amount , "insufficient funds");

        balances[msg.sender] -= _amount;


        (bool success,) = msg.sender.call{value:_amount}("") ; //the transfer

        require(success, "failed withdrawal"); //if the  transfer dosent work

        emit WithdrawSuccessful(msg.sender, _amount);


    }

    function getContractBalance() external view returns(uint256) {

        return address(this).balance;

    }

    function myBalance() external view returns(uint256) {
        return  balances[msg.sender];

    }

    function transfer(uint256 _amount, address _to) external {
        //sanity check
        require(msg.sender != address(0), "address zero detected");
        require(_to != address(0), "address zero detected");
        require(_amount > 0, "cannot withdraw  0");
        require(balances[msg.sender]>= _amount , "insufficient funds");

    

        (bool success,)= _to.call{value:_amount}("");

        require(success,"transfer failed");

        balances[msg.sender] -= _amount; //update balance

        emit TransferSuccessful(_to,_amount);

    }
}



//read about the different ways to call transfer in ETH and why call is the best
