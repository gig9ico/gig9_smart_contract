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


contract Validate{

    enum State { start, end, succeed, fail }
    
    uint minAmount;
     
    address creator;
	
	uint private amount; // In Ether.
	
	State state; 
	uint deadline;
	
	function Validate (address _creator, uint _deadline, uint _amount) public{
	    creator = _creator;
	    deadline = _deadline;
	}

    modifier isAmountMinimum() {
        
		require(msg.value > minAmount) ;
        _;

    }

    modifier inEtherMultipleOfPrice() {

		require(msg.value % minAmount == 0) ;
        _;
    
	}

    modifier isCreator() {
        
		require(msg.sender == creator) ;
        _;
		
    }
    
    modifier finish() {
        
		require(state == State.end || state == State.fail);
		_;
    }
	
	modifier isDeadLine() {
        
		require(now >= deadline);
		_;
    }
	
	

    modifier inState(State _state) {
        require(state == _state) ;
        _;
    }

     modifier isMinimum() {
        require(msg.value > priceInWei) ;
        _;
    }

    modifier inMultipleOfPrice() {
        require(msg.value%priceInWei == 0) ;
        _;
    }

    modifier isCreator() {
        require(msg.sender == creator) ;
        _;
    }

    
    modifier atEndOfLifecycle() {
        if(!((state == State.Failed || state == State.Successful) && completedAt + 1 hours < now)) {
            revert();
        }
        _;
    }
}
