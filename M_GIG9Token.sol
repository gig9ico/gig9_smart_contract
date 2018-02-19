pragma solidity ^0.4.11;

import "./ERC223_Interface.sol";
import "./ERC223ReceivingContract.sol";

contract TokenGIG9 is ERC223_Interface {
	
	tokenFormat
    minDeposit
    tokenNo
    tokenRate
    creatorAddress
    fundAddress
    totalSupply
    decimalNumber
    startDate
    endDate
    fundingGoal

	balances[msg.sender] = 1;
    uint256 public totalSupply = 1;
    string public name = "GTG9";
    uint8 public decimals = 8;
    
    mapping (address => uint256) public balanceOf;
	mapping (address => mapping (address => uint256)) public allowance;
	mapping (address => bool) public frozenAccount;
	
	event Transfer(address indexed from, address indexed to, uint256 value);
	event FrozenFund(address target, bool frozen);

	function TokenGIG9(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUnits, address centralAdmin) TCoin (0, tokenName, tokenSymbol, decimalUnits ) public {
		
		if(centralAdmin != 0)
			admin = centralAdmin;
		else
			admin = msg.sender;
			
		balanceOf[admin] = initialSupply;
		totalSupply = initialSupply;	
	}
	
     function mintToken(address target, uint256 mintedAmount) onlyAdmin public {
		
		balanceOf[target] += mintedAmount;
		totalSupply += mintedAmount;
		
		Transfer(0, this, mintedAmount);
		Transfer(this, target, mintedAmount);
	}

	function freezeAccount(address target, bool freeze) onlyAdmin public {
		frozenAccount[target] = freeze;
		FrozenFund(target, freeze);
	}
	
	 /// @dev Ends the funding period and sends the ETH home
    function finalize() external {
     
      if (isFinalized) throw;
      if (msg.sender != ethFundDeposit) throw; // locks finalize to the ultimate ETH owner
      if(totalSupply < tokenCreationMin) throw;      // have to sell minimum to move to operational
      if(block.number <= fundingEndBlock && totalSupply != tokenCreationCap) throw;
     
      isFinalized = true;
      if(!ethFundDeposit.send(this.balance)) throw;  // send the eth to Brave International
    }
}