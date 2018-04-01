pragma solidity ^ 0.4 .19;

import "./../node_modules/zeppelin-solidity/contracts/lifecycle/Pausable.sol";
import "./../node_modules/zeppelin-solidity/contracts/lifecycle/Destructible.sol";
import "./Balances.sol";

contract Gig9 is Balances,
Pausable,
Destructible {
    
    function Gig9(string name, string symbol, uint decimals, uint256 totalSupply)public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _totalSupply = totalSupply * (10 ** _decimals);
        owner = msg.sender;
        balances[owner] = _totalSupply;
        tokenTransferAddress = owner;
    }

    function ()public {
        revert();

    }

   

}