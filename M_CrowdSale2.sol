
contract Gig9CrowdSale isValidate{

	enum state {Start, End, Success, Fail}
	
	State public currentState = State.Start;
	
	struct Sales{
        uint amount;
        address buyer;
    }

	/***
	 * Pre ICO information.
	 */
	
	// Address
	address public creator;
    address public beneficiary; // Need to ask Malik on this.
    
	// Important Date
	uint public startDate; // 15th March 2018
	uint public endDate; // Need to ask Malik on this.
    
	uint public priceInWei = 0.01 // Need to confirm with Malik
    	
	/***
	 * ICO information.
	 */
	 
	// The Amount of money raised
	uint public totalRaised;
	
	// The current balance
    uint public currentBalance;
    
    // Token
	token public tokenReward;
 
	function myContract() {
        creator = msg.sender;
    }
	
	Contribute public(){
	
        totalRaised += msg.value;
        currentBalance = totalRaised;


        if(fundingMaximumTargetInWei != 0){
            
            tokenReward.transfer(msg.sender, amountInWei / priceInWei);
        }
        else{
            tokenReward.mintToken(msg.sender, amountInWei / priceInWei);
        }
	}
 
	function reachGoal() public {
       
		if (totalRaised >= fundingMaximumTargetInWei || totalRaised >= fundingMinimumTargetInWei && isDeadLine) {
			payOut();
		} 
    }
	
	function payOut()
     
		if(!beneficiary.send(this.balance)) {
			revert();
		}
	}
	
	function end() public{
	
		state = State.End;
		currentBalance = 0;
	}

}