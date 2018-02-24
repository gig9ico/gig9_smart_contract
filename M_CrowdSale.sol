pragma solidity ^0.4.16;

import "./M_Token.sol";

contract Crowdsale {
	
	// Contract
	Token public token;
	
	// Constant
	uint public minimumPurchasedAmount;
	address public creator;
    
	// Value
	uint public bountySchemeTransfered;
	
	// Date
	uint public startDate;
	uint public endDate;
	
	// State
	uint public amountRaised;
    
	enum State { start, end, succeedEarlier }
	State currentState;
	
	event EtherTransferToContract(address from, uint amount);
	event TokenTransferFromCOntract(address to, uint amount);
	event MinimumPurchasedEtherViolation(address to, uint amount);
	event GoalReached();
	
	// *** Supply Information (All supply information is hardcoded). ***
	
	// Conversion
	uint tokenUnit = 100;  // Current token unit;
	uint milliUnit = 1000000000000000;
	uint weiUnit   = 1000000000000000000;
	
	uint totalSupply        = 268000000;		// 268,000,000;
	uint teamIssued	        = 45560000;		// 45,560,000
	uint bountySchemeIssued = 3340000; 		// 3,334,000
	
	// 1 unit = 0.01 Ether
	uint block0 = 300000;
	uint block1 = 300000;
	uint block2 = 300000;
	uint block3 = 300000;
	uint block4 = 300000;
	uint block5 = 300000;
	uint block6 = 300000;
	uint block7 = 200000;
	uint block8 = 200000;
	
	// First Ether in blocks.
	uint block0First = 0;
	uint block1First = 300000;
	uint block2First = 600000;
	uint block3First = 900000;
	uint block4First = 1200000;
	uint block5First = 1500000;
	uint block6First = 1800000;
	uint block7First = 2100000;
	uint block8First = 2300000;
	
	// 0.01 Ether can exchange how many token?
	uint block0ExchangeRatio = 110;
	uint block1ExchangeRatio = 100;
	uint block2ExchangeRatio =  95;
	uint block3ExchangeRatio =  90;
	uint block4ExchangeRatio =  85;
	uint block5ExchangeRatio =  80;
	uint block6ExchangeRatio =  75;
	uint block7ExchangeRatio =  73;
	uint block8ExchangeRatio =  70;
	
	/**
        Sample constructor parameters
        "GTG", "GTG", 8, 1, "0xC7B38600299ab2657c6F341310DAdD9E1ba7398a", "0xC7B38600299ab2657c6F341310DAdD9E1ba7398a", 1521072000, 1529020800
    */
        
    function Crowdsale (string _tokenName, string _tokenSymbol, uint8 _tokenDecimals, 
						uint _minimumPurchasedAmount, address _creator, 
						uint _startDate, uint _endDate) public {
        
		// Contract
		token = new Token(_tokenName,  _tokenSymbol, _tokenDecimals, totalSupply);
		
		// Constant
		minimumPurchasedAmount = _minimumPurchasedAmount;
		
		// Value
		amountRaised = 0;
		bountySchemeTransfered = 0;
		
		creator = _creator;
		
		// Date
		startDate = _startDate;
		endDate = _endDate;
		
		currentState = State.start;
    }

    function () public payable{
	    sell();
    }
    
    /**
     * Most important method.
     */
    
    function sell() isSaleActive{
        
		uint amount = msg.value / weiUnit * tokenUnit;
	    uint tentativeAmountRaised = amount + amountRaised;
	
	    if(amount > minimumPurchasedAmount){
	        
	        if(tentativeAmountRaised >= block0First && tentativeAmountRaised < block1First){
	            token.transfer(msg.sender, amount * block0ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
   	        if(tentativeAmountRaised >= block1First && tentativeAmountRaised < block2First){
	            token.transfer(msg.sender, amount * block1ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
   	        if(tentativeAmountRaised >= block2First && tentativeAmountRaised < block3First){
	            token.transfer(msg.sender, amount * block2ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
   	        if(tentativeAmountRaised >= block3First && tentativeAmountRaised < block4First){
	            token.transfer(msg.sender, amount * block3ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
   	        if(tentativeAmountRaised >= block4First && tentativeAmountRaised < block5First){
	            token.transfer(msg.sender, amount * block4ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
   	        if(tentativeAmountRaised >= block5First && tentativeAmountRaised < block6First){
	            token.transfer(msg.sender, amount * block5ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
   	        if(tentativeAmountRaised >= block6First && tentativeAmountRaised < block7First){
	            token.transfer(msg.sender, amount * block6ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
   	        if(tentativeAmountRaised >= block7First && tentativeAmountRaised < block8First){
	            token.transfer(msg.sender, amount * block7ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
   	        }
   	        
	    } else {
			MinimumPurchasedEtherViolation(msg.sender, amount);
		}
    }

    // To let creator to transfer bountyScheme to the contributor
    
    function bountrySchemetTransfer(address contributor, uint amountInToken) public isCreator{
        
        uint tentativeTotalBountySchemeSent = tentativeTotalBountySchemeSent + amountInToken;
        
        if(tentativeTotalBountySchemeSent <= bountySchemeIssued){
           token.transfer(contributor, amountInToken);
           bountySchemeTransfered = tentativeTotalBountySchemeSent;
        }
        
    }
    
    function checkStatus() public {
        
        if (amountRaised >= totalSupply){
            currentState = State.succeedEarlier;
        }
        
        if(now >= endDate){
            token.safeWithdrawal();
            currentState = State.end;
        }
    }
		
	/**
	 * Validation
	 */

    modifier isCreator() {
		require(msg.sender == creator) ;
        _;		
    }
    
    modifier isSaleActive() {
		require(currentState == State.start);
		_;
    }
    
    modifier isSaleFinish() {
		require(currentState == State.end || currentState == State.succeedEarlier);
		_;
    }
}