pragma solidity ^0.4.16;

import "./LAssert.sol";
import "./TGCrowdSaleGetters.sol";

contract UnitTest {

    event Log(address a);
    event Log(bool b);
    event Log(uint i);
    event Log(bytes b);
    
    CrowdSaleGetters crowdSaleGetters;
    address creator;
    Token token;

    function UnitTest() {
        
        //* parameters - for eg. "GIG9", "GIG", 8, "0xC7B38600299ab2657c6F341310DAdD9E1ba7398a", 1521072000, 1529020800
        
        ////_address1 = 0x449a46d0aE23612f059FA848702C2DF830F5ED4E;

        //crowdSaleGetters = new CrowdSaleGetters("GIG9", "GIG", 8, 0x449a46d0aE23612f059FA848702C2DF830F5ED4E, 1521072000, 1529020800);

        // Send 1 ether to the crowdsale contract Address
        // _address1.transfer(1);

        //Log(crowdsale.getCurrentState());
        
        
    }
   
   function initialTesting() public{
       
       //Assert.equal(crowdSaleGetters.isCurrentStateStart(), true, "State should be = start");
       
       //token = crowdSaleGetters.getToken();
       //Assert.equal(token.balanceOf(token.getCreator()), 268000000, "Balance of creator should be 268000000");
       //creator = crowdSaleGetters.getCreator();
       
   }

    function getToken() public view returns (Token){
        return token;
    }
    
    function getCreator() public view returns (address){
        return creator;
    }
    
}