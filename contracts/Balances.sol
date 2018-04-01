pragma solidity ^ 0.4 .4;
import "./../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol";
import "./../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./ERC223Token.sol";

contract Balances is Ownable,
ERC223Token {
    mapping(address => bool)public modules;
    using SafeMath for uint256; address public tokenTransferAddress;  
     function Balances()public {
        // constructor
    }
    // Address where funds are collected

    function updateModuleStatus(address _module, bool status)public onlyOwner {
        require(_module != address(0));
        modules[_module] = status;
    }

    function updateTokenTransferAddress(address _tokenAddr)public onlyOwner {
        require(_tokenAddr != address(0));
        tokenTransferAddress = _tokenAddr;

    }

    modifier onlyModule() {
        require(modules[msg.sender] == true);
        _;
    }

    function increaseBalance(address recieverAddr, uint256 _tokens)onlyModule public returns(
        bool
    ) {
        require(recieverAddr != address(0));
        require(balances[tokenTransferAddress] >= _tokens);
        balances[tokenTransferAddress] = balances[tokenTransferAddress].sub(_tokens);
        balances[recieverAddr] = balances[recieverAddr].add(_tokens);
        return true;
    }
    function decreaseBalance(address recieverAddr, uint256 _tokens)onlyModule public returns(
        bool
    ) {
        require(recieverAddr != address(0));
        require(balances[recieverAddr] >= _tokens);
        balances[recieverAddr] = balances[recieverAddr].sub(_tokens);
        balances[tokenTransferAddress] = balances[tokenTransferAddress].add(_tokens);
        return true;
    }

   
}
