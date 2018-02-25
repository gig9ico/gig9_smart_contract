pragma solidity ^0.4.16;

import "./LAssert.sol";
import "./TGCrowdSaleGetters.sol";

contract UnitTest {

    event Log(address a);
    event Log(bool b);
    event Log(uint i);
    event Log(bytes b);
    
    CrowdSaleGetters crowdSaleGetters;
    address _address1;

    function UnitTest() {
        
        //* parameters - for eg. "GIG9", "GIG", 8, "0xC7B38600299ab2657c6F341310DAdD9E1ba7398a", 1521072000, 1529020800
        
        _address1 = 0xC7B38600299ab2657c6F341310DAdD9E1ba7398a;

        crowdSaleGetters = new CrowdSaleGetters("GIG9", "GIG", 8, 0xC7B38600299ab2657c6F341310DAdD9E1ba7398a, 1521072000, 1529020800);

        // Send 1 ether to the crowdsale contract Address
        // _address1.transfer(1);

        //Log(crowdsale.getCurrentState());
        
    }
   
   function initialTesting() public{
       
       Assert.equal(crowdSaleGetters.isCurrentStateStart(), true, "State should be = start");
       
       Token token = crowdSaleGetters.getToken();
       Assert.equal(token.balanceOf(token.getCreator()), 268000000, "Balance of creator should be 268000000");
       
   }

}