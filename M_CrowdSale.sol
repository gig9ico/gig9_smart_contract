pragma solidity ^0.4.16;

import "./M_Token.sol";

contract Crowdsale {
	
	mapping(address => uint256) balanceOf;
    address creator;

	// Contract
	Token token;
	
	// Object
	address public beneficiary;
	
	// Value
	uint public fundingGoal;
	uint minimumPurchasedEtherAmount;
	
	// Date
	uint public startDate;
	uint public endDate;
	
	// State
	uint public amountRaised;
    bool fundingGoalReached; 
	bool crowdsaleClosed;
	
	enum State { start, end, succeed, fail }
	State currentState;
	
	uint currentBlock;	
	
	// Supply information 
	
	uint totalSupply = 500000000;			// 500,000,000;
	uint totalIssued = 268000000;			// 268,000,000;
		
	uint block0Ethereum = 3000;
	uint block1Ethereum = 3000;
	uint block2Ethereum = 3000;
	uint block3Ethereum = 3000;
	uint block4Ethereum = 3000;
	uint block5Ethereum = 3000;
	uint block6Ethereum = 3000;
	uint block7Ethereum = 2000;
	uint block8Ethereum = 2000;
		
	uint token0Ethereum = 11000;
	uint token1Ethereum = 10000;
	uint token2Ethereum =  9500;
	uint token3Ethereum =  9000;
	uint token4Ethereum =  8500;
	uint token5Ethereum =  8000;
	uint token6Ethereum =  7500;
	uint token7Ethereum =  7300;
	uint token8Ethereum =  7000;
	
	uint block0Issued = 33000000; 			// 33,000,000
	uint block1Issued = 30000000; 			// 30,000,000
	uint block2Issued = 28500000; 			// 28,500,000
	uint block3Issued = 27000000; 			// 27,000,000
	uint block4Issued = 25500000; 			// 25,500,000
	uint block5Issued = 24000000; 			// 24,000,000
	uint block6Issued = 22500000; 			// 22,500,000
	uint block7Issued = 14600000; 			// 14,600,000
	uint block8Issued = 14000000; 			// 14,000,000
		
	uint teamIssued	= 45560000; 				// 45,560,000
	uint bountySchemeIssued = 3340000; 		// 3,334,000
	
	event Log(string message);
	event Transfer(address to, uint amount);
	event GoalReached();
	
    function Crowdsale (string _tokenName, string _tokenSymbol, uint8 _tokenDecimals, uint _totalSupply,
						uint _minimumPurchasedEtherAmount, uint _fundingGoal, 
						address _creator, address _beneficiary, uint _startDate, uint _endDate) public{
        
		// Contract
		//token = new Token(_tokenName,  _tokenSymbol, _tokenDecimals, _totalSupply);
		
		// Object
		creator = _creator;
		beneficiary = _beneficiary;
        fundingGoal = _fundingGoal;
		
		// Value
		minimumPurchasedEtherAmount = _minimumPurchasedEtherAmount;
		
		// State
		amountRaised = 0;
		currentBlock = 0;
		fundingGoalReached = false;
		crowdsaleClosed = false;
		
		currentState = State.start;
    }

    function () public payable{
	
		uint amount = msg.value;
	
		if(msg.value > minimumPurchasedEtherAmount){
			
			amountRaised += amount;
			// Need transfer feature.
			Transfer(msg.sender, amount);
			
		} else {
			//console.log("MinimumPurchaseAmountViolation. " + msg.sender + " " + amount);
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
		Log("Contract is removed");
	}
		
	// Validation code start here.

    modifier inEtherMultipleOfPrice() {
		require(msg.value % minimumPurchasedEtherAmount == 0) ;
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