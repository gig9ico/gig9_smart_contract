pragma solidity ^ 0.4.19;

contract IERC223 {
    function balanceOf(address who)public view returns(uint);

    function name()public view returns(string);
    function symbol()public view returns(string);
    function decimals()public view returns(uint);
    function totalSupply()public view returns(uint256);

    function transfer(address to, uint value)public returns(bool ok);
    function transfer(address to, uint value, bytes data)public returns(bool ok);
    function transfer(address to, uint value, bytes data, string custom_fallback)public returns(
        bool ok);
    event Transfer(
        address indexed from,
        address indexed to,
        uint value
    );
}
