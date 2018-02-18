pragma solidity ^0.4.16;

contract Validate{

	function Validate(
		
		address creator,
		State state,
		uint amount; // In Wei.
		
	)
	
    modifier isAmountMinimum() {
        
		require(msg.value > amount) ;
        _;

    }

    modifier inWeiMultipleOfPrice() {

		require(msg.value%weiAmount == 0) ;
        _;
    
	}

    modifier isCreator() {
        
		require(msg.sender == creator) ;
        _;
		
    }
    
    modifier finish() {
        
		require(state == State.End || state == State.Fail)
		_;
    }
	
	modifier isDeadLine() {
        
		require(now >= deadline)
		_;
    }
}