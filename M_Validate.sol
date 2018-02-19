pragma solidity ^0.4.16;

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
}