pragma solidity ^0.4.16;

import "./MCrowdSale.sol";

contract CrowdSaleGetters is CrowdSale {
    
    function CrowdSaleGetters (string _tokenName, string _tokenSymbol, uint8 _tokenDecimals, 
					    address _creator, uint _startDate, uint _endDate) 
	    CrowdSale( _tokenName, _tokenSymbol, _tokenDecimals, _creator, _startDate, _endDate) public {}
    
    function getToken() public view returns (Token){
        return token;
    }
    
    function getThisContractAddress() public view returns (address){
        return this;
    }
    
    function isCurrentStateStart()  public view returns(bool){
        return currentState == State.start;
    }
}
