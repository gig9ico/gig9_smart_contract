pragma solidity ^0.4.11;

import 'ERC223_interface.sol';

contract TokenGIG9 is ERC223Interface {
	
	uint public totalSupply;
	
	mapping (address => uint) balances;
    mapping (address => mapping (address => uint)) allowed;
	
	function balanceOf(address _owner) constant returns (uint balance) {
        return balances[_owner];
    }
	
    function transfer(address to, uint value){}
    
		if (balances[msg.sender] >= _value && _value > 0) {

			balances[msg.sender] -= _value;
            balances[_to] += _value;

            Transfer(msg.sender, _to, _value);
        
		}
    }

    function transfer(address to, uint value, bytes data){

		if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
        
			uint codeLength;

			assembly {
				codeLength := extcodesize(_to)
			}

			balances[_to] += _value;
			balances[_from] -= _value;

			if(codeLength>0) {
				
				ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
				receiver.tokenFallback(msg.sender, _value, _data);
			}

			Transfer(_from, _to, _value, _data);
			
		}
    }	
	
	event Transfer(address indexed from, address indexed to, uint value, bytes data);
}

