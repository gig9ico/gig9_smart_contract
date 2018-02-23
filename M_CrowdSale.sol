pragma solidity ^0.4.16;

import "./M_Token.sol";

contract Crowdsale {
	
	// Contract
	Token public token;
	
	// Object
	mapping(address => uint256) public balanceOf;
    address public creator;
    address public beneficiary;
    
	// Value
	uint public fundingGoal;
	uint public minimumPurchasedAmount;
	
	uint milliEtherToWei = 1000000000000000;
	uint etherToWei      = 1000000000000000000;
	
	// Date
	uint public startDate;
	uint public endDate;
	
	// State
	bool crowdsaleStarted;
	bool crowdsaleClosed;
	bool fundingGoalReached; 
    uint public amountRaised;
    
	enum State { start, end, succeed, fail }
	State currentState;
	
	// Supply Information
	uint totalSupply        = 268000000;		// 268,000,000;
	uint totalReceived      = 25000000;
    uint teamIssued	        = 45560000;		// 45,560,000
	uint bountySchemeIssued = 3340000; 		// 3,334,000
	
	uint block0 = 3000000;
	uint block1 = 3000000;
	uint block2 = 3000000;
	uint block3 = 3000000;
	uint block4 = 3000000;
	uint block5 = 3000000;
	uint block6 = 3000000;
	uint block7 = 2000000;
	uint block8 = 2000000;
	
	uint block0First = 0;
	uint block1First = 3000000;
	uint block2First = 6000000;
	uint block3First = 9000000;
	uint block4First = 12000000;
	uint block5First = 15000000;
	uint block6First = 18000000;
	uint block7First = 21000000;
	uint block8First = 23000000;
	
	uint block0Exchanged = 11000;
	uint block1Exchanged = 10000;
	uint block2Exchanged =  9500;
	uint block3Exchanged =  9000;
	uint block4Exchanged =  8500;
	uint block5Exchanged =  8000;
	uint block6Exchanged =  7500;
	uint block7Exchanged =  7300;
	uint block8Exchanged =  7000;
	
	event EtherTransfer(address from, uint amount);
	event TokenTransfer(address to, uint amount);
	event MinimumPurchasedEtherViolation(address to, uint amount);
	event GoalReached();
	
    function Crowdsale (string _tokenName, string _tokenSymbol, uint8 _tokenDecimals, uint8 _totalSupply,
						uint _minimumPurchasedAmount, uint _revenue, uint _fundingGoal, 
						address _creator, address _beneficiary, uint _startDate, uint _endDate) public{
        
		// Contract
		token = new Token(_tokenName,  _tokenSymbol, _tokenDecimals, _totalSupply);
		
		// Object
		creator = _creator;
		beneficiary = _beneficiary;
        fundingGoal = _fundingGoal;
		
		// Value
		minimumPurchasedAmount = _minimumPurchasedAmount;
		
		// State
		amountRaised = 0;
		fundingGoalReached = false;
		crowdsaleClosed = false;
		
		currentState = State.start;
    }

    function () public payable{
	
		uint amount = msg.value / milliEtherToWei;
	
	    uint tentativeAmountRaised = amount + amountRaised;
	
	    if(amount > minimumPurchasedAmount){
	        
	        if(tentativeAmountRaised >= block0First && tentativeAmountRaised < block1First){
	            token.transfer(amount * block0Exchanged);
                amountRaised =  amount + amountRaised;
   	        }
	        
	    } else {
			MinimumPurchasedEtherViolation(msg.sender, amount);
		}
 }
    
        
    
    function checkGoalReached() public isDeadLine {
        
		if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
			GoalReached();
        }
    }

    function safeWithdrawal() public isDeadLine {
        
		uint amount = balanceOf[msg.sender];

		balanceOf[msg.sender] = 0;

		if (amount > 0) {
		
			if (msg.sender.send(amount)) {
			} else {
				balanceOf[msg.sender] = amount;
			}
		}
    }
	
	function removeContract() public isCreator() finish(){
		selfdestruct(msg.sender);	
	}
		
	// Validation code start here.

    modifier inEtherMultipleOfPrice() {
		require(msg.value % minimumPurchasedAmount == 0) ;
        _;
	}

    modifier isCreator() {
		require(msg.sender == creator) ;
        _;		
    }
    
    modifier finish() {
		require(currentState == State.end || currentState == State.fail);
		_;
    }
	
	modifier isDeadLine() {
		require(now >= endDate);
		_;
    }
}