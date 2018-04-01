pragma solidity ^ 0.4.19;

contract IContractReceiver {
    function IContractReceiver()public {
        // constructor
    }
    function tokenFallback(address _from, uint _value, bytes _data)public pure;
}
