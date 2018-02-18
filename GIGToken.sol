pragma solidity ^0.4.11;

contract GIGToken is StandardToken {

    string public name;
    string public symbol;
	uint8 public decimals;
    
    function ERC20Token() {
		
		balances[msg.sender] = totalSupply;
		
		updateGeneralInfo();
		updateSupplyInfo();
    }
	
	function updateGeneralInfo(){
	
		name = "GIG9";
		symbol = "GIG";
		decimals = 8;

	}
	
	function updateSupplyInfo(){

		// Hardcoding to reduce gas.
		
		totalSupply = 500000000			// 500,000,000;
		totalIssued = 268000000			// 268,000,000;
		
		block0Ethereum = 3000;
		block1Ethereum = 3000;
		block2Ethereum = 3000;
		block3Ethereum = 3000;
		block4Ethereum = 3000;
		block5Ethereum = 3000;
		block6Ethereum = 3000;
		block7Ethereum = 2000;
		block8Ethereum = 2000;
		
		token0@Ethereum = 11000;
		token1@Ethereum = 10000;
		token2@Ethereum =  9500;
		token3@Ethereum =  9000;
		token4@Ethereum =  8500;
		token5@Ethereum =  8000;
		token6@Ethereum =  7500;
		token7@Ethereum =  7300;
		token8@Ethereum =  7000;
	
		block0Issued = 33000000 	// 33,000,000
		block1Issued = 30000000 	// 30,000,000
		block2Issued = 28500000 	// 28,500,000
		block3Issued = 27000000 	// 27,000,000
		block4Issued = 25500000 	// 25,500,000
		block5Issued = 24000000 	// 24,000,000
		block6Issued = 22500000 	// 22,500,000
		block7Issued = 14600000 	// 14,600,000
		block8Issued = 14000000 	// 14,000,000
		
		teamIssued 			= 45560000 		// 45,560,000
		bountyScemeIssued 	= 3340000 		// 3,334,000
	}
	
    function () {
        throw;
    }
}