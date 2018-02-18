pragma solidity ^0.4.16;

contract Validate{

    enum state { start, end, succeed, fail }
    
    uint private minAmount;
     
    address private creator;
	uint private amount; // In Ether.
	
	function Validate (address creator, uint amount) public{
	    this.creator = creator;
	    this.amount = amount;
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
        
		require(state == State.End || state == State.Fail);
		_;
    }
	
	modifier isDeadLine() {
        
		require(now >= deadline);
		_;
    }
}