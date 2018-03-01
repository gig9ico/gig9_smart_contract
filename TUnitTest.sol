pragma solidity ^0.4.16;

import "./LAssert.sol";
import "./TGCrowdSaleGetters.sol";

contract UnitTest {

    event Log(address a);
    event Log(bool b);
    event Log(uint i);
    event Log(bytes b);
    
    CrowdSale crowdSale;
    address _address1;
    Token token;

    function UnitTest() {
        
        //* parameters - for eg. "GIG9", "GIG", 8, "0xC7B38600299ab2657c6F341310DAdD9E1ba7398a", 1521072000, 1529020800
        
        crowdSale = new CrowdSale (0x8c6aac465302d9f6262b2907f00c62350cf6fd74 ,  1521072000,  1529020800);

        // Send 1 ether to the crowdsale contract Address
        // _address1.transfer(1);

        //Log(crowdsale.getCurrentState());
        
    }
   
   function initialTesting() public{
       
       //Assert.equal(crowdSaleGetters.isCurrentStateStart(), true, "State should be = start");
       
       token = crowdSale.getToken();
       Assert.equal(token.balanceOf(token.getCreator()), 268000000, "Balance of creator should be 268000000");
       
   }

    function getToken() public view returns (Token){
        return token;
    }
    
    function getCreator() public view returns (address){
        return token.getCreator();
    }
    
   function transfer() public payable{
       
     //crowdSaleGetters.transfer();
     0x449a46d0aE23612f059FA848702C2DF830F5ED4E.transfer(0.01 ether);
    }
    
    event LOG(address sender, uint value);
    
}