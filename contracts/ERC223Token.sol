pragma solidity ^ 0.4 .19;

import "./../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol";
import "./IERC223.sol";
import "./IContractReceiver.sol";

contract ERC223Token is IERC223 {

    mapping(address => uint)balances;

    string internal _name;
    string internal _symbol;
    uint internal _decimals;
    uint256 internal _totalSupply;
    using SafeMath for uint;

    // Function to access name of token .
    function name()public view returns(string) {
        return _name;
    }
    // Function to access symbol of token .
    function symbol()public view returns(string) {
        return _symbol;
    }
    // Function to access decimals of token .
    function decimals()public view returns(uint) {
        return _decimals;
    }
    // Function to access total supply of tokens .
    function totalSupply()public view returns(uint256) {
        return _totalSupply;
    }

    // Function that is called when a user or another contract wants to transfer
    // funds .
    function transfer(
        address _to,
        uint _value,
        bytes _data,
        string _custom_fallback
    )public returns(bool success) {
        require(_to != address(0));
        if (isContract(_to)) {
            if (balanceOf(msg.sender) < _value) 
                revert();
            balances[msg.sender] = balanceOf(msg.sender).sub(_value);
            balances[_to] = balanceOf(_to).add(_value);
            assert(_to.call.value(0)(
                bytes4(keccak256(_custom_fallback)),
                msg.sender,
                _value,
                _data
            ));
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return transferToAddress(_to, _value, _data);
        }
    }

    // Function that is called when a user or another contract wants to transfer
    // funds .
    function transfer(address _to, uint _value, bytes _data)public returns(
        bool success
    ) {

        if (isContract(_to)) {
            return transferToContract(_to, _value, _data);
        } else {
            return transferToAddress(_to, _value, _data);
        }
    }

    // Standard function transfer similar to ERC20 transfer with no _data . Added
    // due to backwards compatibility reasons .
    function transfer(address _to, uint _value)public returns(bool success) {

        // standard function transfer similar to ERC20 transfer with no _data added due
        // to backwards compatibility reasons
        bytes memory empty;
        if (isContract(_to)) {
            return transferToContract(_to, _value, empty);
        } else {
            return transferToAddress(_to, _value, empty);
        }
    }

    // assemble the given address bytecode. If bytecode exists then the _addr is a
    // contract.
    function isContract(address _addr)private view returns(bool is_contract) {
        uint length;
        assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        return (length > 0);
    }

    //function that is called when transaction target is an address
    function transferToAddress(address _to, uint _value, bytes _data)private returns(
        bool success
    ) {
        require(_value > 0);
        require(balanceOf(msg.sender) >= _value);
        balances[msg.sender] = balanceOf(msg.sender).sub(_value);
        balances[_to] = balanceOf(_to).add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    //function that is called when transaction target is a contract
    function transferToContract(address _to, uint _value, bytes _data)private returns(
        bool success
    ) {
        require(_value > 0);
        require(balanceOf(msg.sender) >= _value);
        balances[msg.sender] = balanceOf(msg.sender).sub(_value);
        balances[_to] = balanceOf(_to).add(_value);
        IContractReceiver receiver = IContractReceiver(_to);
        receiver.tokenFallback(msg.sender, _value, _data);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function balanceOf(address _owner)public view returns(uint balance) {
        return balances[_owner];
    }
}