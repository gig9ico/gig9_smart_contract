pragma solidity ^0.4.16;

import "./MToken.sol";

contract CrowdSale {
	
	// Contractr
	Token public token;
    
	// Date
	uint public startDate;
	uint public endDate;
	
	// Amount in Ether * 100
	uint public amountRaised;
	
	// Amount in Token
    uint public bountySchemeTokenTransferred;
	
	// State and boolean
	enum State { start, end, succeedEarlier }
	State currentState;
	
	bool isTokenTransferredToTeam;
	bool isTokenBountySchemeFinishTransferred;
	bool isTokenAllBurned;
	
	//Event
	event EtherTransferToContract(address from, uint amount);
	event TokenTransferFromContract(address to, uint amount);
	
	event AmountRaised();
	event AmountRaisedAfterCurrentPuchased();
	
	event MinimumPurchasedEtherViolation(address to, uint amount);
	event AllTokensSoldViolation();
	event GoalReached();
	
	// *** Supply Information (All supply information is hardcoded). ***
	
	// Conversion
	uint tokenUnit = 100;  // Current token unit;
	uint milliUnit = 1000000000000000;
	uint weiUnit   = 1000000000000000000;
	
	uint totalSupply        = 268000000;	// 268,000,000;
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
	uint block0First = 100;
	uint block1First = 300100;
	uint block2First = 600100;
	uint block3First = 900100;
	uint block4First = 1200100;
	uint block5First = 1500100;
	uint block6First = 18000100;
	uint block7First = 21000100;
	uint block8First = 23000100;
	
	// 0.01 Ether can exchange how many tokens?
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
	 * constructor
	 * parameters - for eg. "GIG9", "GIG", 8, "0xC7B38600299ab2657c6F341310DAdD9E1ba7398a", 1521072000, 1529020800
     */
        
    function CrowdSale (address _creator , uint _startDate, uint _endDate) public {
        
		token = Token( _creator);
		amountRaised = 0;
		bountySchemeTokenTransferred = 0;
		startDate = _startDate;
		endDate = _endDate;
		currentState = State.start;
    }

    /**
     * Run when there is any buyer. 
     */

    function () public payable{
	    sellToken();
    }
    
    /**
     * Depending on different blocks, how many TOKENS are sold base on the ETHER quantitiy.
     */
    
    function sellToken() isSaleActive public payable{
        
        AmountRaised();
        
		uint amount = msg.value / weiUnit * tokenUnit;
	    uint tentativeAmountRaised = amountRaised + amount;
	
	    // 1 == minimumPurchaseAmount which is equivalent to 0.01 Ether
	    if(amount >= 1){ 
	        
	        if(tentativeAmountRaised >= block0First && tentativeAmountRaised < block1First){
	            
	            token.transfer(msg.sender, amount * block0ExchangeRatio);
	            amountRaised =  tentativeAmountRaised;
	            
	            EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block0ExchangeRatio);
                
   	        } else if(tentativeAmountRaised >= block1First && tentativeAmountRaised < block2First){
   	            
	            token.transfer(msg.sender, amount * block1ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
            
	            EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block1ExchangeRatio);

   	        } else if(tentativeAmountRaised >= block2First && tentativeAmountRaised < block3First){
	            
	            token.transfer(msg.sender, amount * block2ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
                
                EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block2ExchangeRatio);
	            
   	        } else if(tentativeAmountRaised >= block3First && tentativeAmountRaised < block4First){
	            
	            token.transfer(msg.sender, amount * block3ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
                
                EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block3ExchangeRatio);
   	        
   	        } else if(tentativeAmountRaised >= block4First && tentativeAmountRaised < block5First){
	            
	            token.transfer(msg.sender, amount * block4ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
                
                EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block4ExchangeRatio);
   	        
   	        } else if(tentativeAmountRaised >= block5First && tentativeAmountRaised < block6First){
	            
	            token.transfer(msg.sender, amount * block5ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
                
                EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block5ExchangeRatio);
	            
   	        } else if(tentativeAmountRaised >= block6First && tentativeAmountRaised < block7First){
	            
	            token.transfer(msg.sender, amount * block6ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
                
                EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block6ExchangeRatio);
   	        
   	        } else if(tentativeAmountRaised >= block7First && tentativeAmountRaised < block8First){
	            
	            token.transfer(msg.sender, amount * block7ExchangeRatio);
                amountRaised =  tentativeAmountRaised;
                
                EtherTransferToContract(msg.sender, amount);
	            TokenTransferFromContract(msg.sender, amount * block7ExchangeRatio);
	            
   	        } else {
   	            AllTokensSoldViolation();
   	        }
   	        
   	        AmountRaisedAfterCurrentPuchased();
   	        
	    } else {
	        
			MinimumPurchasedEtherViolation(msg.sender, amount);
			//revert();
		}
    }
    
    function run() public {
        
        if (amountRaised >= totalSupply){
            currentState = State.succeedEarlier;
        }
        
        if(now >= endDate){
            currentState = State.end;
        }
    }
    
    /**
     * The function below is executed when the sale is end.
     */
    
    // Let creator to have 17% of total tokens.
    
    function teamTransfer(uint amountInToken) private isCreator isSaleFinish{
        token.teamTransfer(amountInToken);
        isTokenTransferredToTeam = true;
    }
    
    // let creator to transfer bountyScheme tokens to the contributor.
    
    function bountySchemeTransfer(address contributor, uint amountInToken) public isCreator isSaleFinish{
        
        uint tentativeTotalBountySchemeSent = bountySchemeTokenTransferred + amountInToken;
        
        if(tentativeTotalBountySchemeSent <= bountySchemeIssued){
           
           token.transfer(contributor, amountInToken);
           bountySchemeTokenTransferred = tentativeTotalBountySchemeSent;
           
        } else {
            isTokenBountySchemeFinishTransferred = true;
        }
    }
    
    function burnToken() public isCreator isSaleFinish isTokenReadyToBurned{
        token.burnToken();
        isTokenAllBurned = true;
    }
    
    function removeContract() public isCreator isSaleFinish isContractReadyToBeRemoved{
        token.removeContract();        
    }
    
	/**
	 * Validation
	 */

    modifier isCreator() {
		require(msg.sender == token.getCreator()) ;
        _;		
    }
    
    modifier isSaleActive(){
		require(currentState == State.start);
		_;
    }
    
    modifier isSaleFinish() {
		require(currentState == State.end || currentState == State.succeedEarlier);
		_;
    }
    
    modifier isTokenReadyToBurned(){
        require(isTokenTransferredToTeam && isTokenBountySchemeFinishTransferred);
        _;
    }
    
    modifier isContractReadyToBeRemoved(){
        require(isTokenTransferredToTeam && isTokenBountySchemeFinishTransferred && isTokenAllBurned);
        _;
    }
}