pragma solidity ^0.4.16;

contract Crowdsale {
	
	address public beneficiary;
	
	enum state {Start, End, Success, Fail}；
	
	uint public fundingGoal;
	uint public startDate;
	uint public endDate;
	uint public amountRaised;
    bool fundingGoalReached; 
	bool crowdsaleClosed;
	
	mapping(address => uint256) public balanceOf;

    function Crowdsale (address _beneficiary, uint _fundingGoal， uint _startDate， uint _endDate) public{
        
		beneficiary = _beneficiary;
        fundingGoal = _fundingGoal;
		
		amountRaised = 0;
		fundingGoalReached = false;
		crowdsaleClosed = false;
		currentState = State.Start;
    }

    function () public payable {
	
        require(!isDeadLine);
		
        uint amount = msg.value;
	
		if(amount > 0.01){
		
			balanceOf[msg.sender] += amount;
			amountRaised += amount;
		
		}
        
		tokenReward.transfer(msg.sender, amount / price);
    }

    function checkGoalReached() public isDeadLine {
        
		if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
        }
		
        crowdsaleClosed = true;
    }

    function safeWithdrawal() public afterDeadline {
        
		uint amount = balanceOf[msg.sender];

		balanceOf[msg.sender] = 0;

		if (amount > 0) {
		
			if (msg.sender.send(amount)) {
			} else {
				balanceOf[msg.sender] = amount;
			}
		}
    }
	
	function removeContract() public isCreator() atEndOfLifecycle(){
		
		selfdestruct(msg.sender);		
	}
	
	function end() public{
	
		state = State.End;
		currentBalance = 0;
	}
}