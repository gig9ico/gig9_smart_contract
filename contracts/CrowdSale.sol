pragma solidity ^ 0.4 .19;
import "./../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol";
import "./../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
contract ERC223 {
    function balanceOf(address who)public view returns(uint);

    function name()public view returns(string);
    function symbol()public view returns(string);
    function decimals()public view returns(uint);
    function totalSupply()public view returns(uint256);

    function transfer(address to, uint value)public returns(bool ok);
    function transfer(address to, uint value, bytes data)public returns(bool ok);
    function transfer(address to, uint value, bytes data, string custom_fallback)public returns(
        bool ok
    );
    function increaseBalance(address recieverAddr, uint256 _tokens)public returns(
        bool
    );
    function decreaseBalance(address recieverAddr, uint256 _tokens)public returns(
        bool
    );

}
contract CrowdSale is Ownable {
    using SafeMath for uint256; mapping(string => OffChainRecord)allOffchainRecords;
    //Smart Contract address of token
    ERC223 public tokenAddress; address[] public allContributors;
    // Amount of wei raised

    uint256 public weiRaised;
    //Wallet address where funds will go
    address public wallet; enum State {
        Active,
        Closed
    }
    event Closed();
    State public state;

    function CrowdSale()public {
        // constructor
        wallet = msg.sender;
        owner = msg.sender;
        state = State.Active;
    }

    function ()public payable {
        buyTokens();

    }

    function close()onlyOwner public {
        require(state == State.Active);
        state = State.Closed;
        emit Closed();
    }
    function updateTokenAddress(address _tokenAddr)external onlyOwner {
        tokenAddress = ERC223(_tokenAddr);
    }

    function check()public constant returns(uint256) {
        return tokenAddress.decimals();
    }
    function buyTokens()internal {
        uint256 weiAmount = msg.value;
        address _beneficiary = msg.sender;
        uint256 tokens = _getTokenAmount(weiAmount);
        tokenAddress.increaseBalance(_beneficiary, tokens);

        // update state
        weiRaised = weiRaised.add(weiAmount);
        _forwardFunds();
        _addContributor(msg.sender);
    }
   
 function _getTokenAmount(uint256 etherInWei)internal view returns(uint256 rate) {
        uint decimals = tokenAddress.decimals();
        if (decimals == 0) {
            decimals = 1;
        }
        if (weiRaised <= uint256(5000 ether)) {
            uint256 ethersLimit = uint256(4000 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 6800;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                uint256 firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 6800;
                uint256 firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                uint256 secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 6500;
                uint256 secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(10000 ether)) {
            ethersLimit = uint256(10000 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 6500;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 6500;
                firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 6300;
                secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(14000 ether)) {
            ethersLimit = uint256(14000 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 6300;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 6300;
                firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 6100;
                secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(18000 ether)) {
            ethersLimit =uint256(18000 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 6100;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 6100;
                firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 5900;
                secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(22000 ether)) {
            ethersLimit = uint256(22000 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 5900;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 5900;
                firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 5650;
                secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(26000 ether)) {
            ethersLimit =uint256(26000 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 5650;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 5650;
                firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 5350;
                secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(30000 ether)) {
            ethersLimit =uint256(30000 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 5350;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 5350;
                firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 5200;
                secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(33500 ether)) {
            ethersLimit = uint256(33500 ether);
            if (weiRaised + etherInWei <= ethersLimit) {
                rate = uint256(1 ether) / 5200;
                return etherInWei.div(rate) * (10 ** decimals);
            } else {
                firstHalfBalInWei = (ethersLimit - weiRaised);
                rate = uint256(1 ether) / 5200;
                firstHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                secondhalfBalInWei = etherInWei - firstHalfBalInWei;
                rate = uint256(1 ether) / 5000;
                secondHalfTokens = etherInWei.div(rate) * (10 ** decimals);
                return (firstHalfTokens + secondHalfTokens);
            }
        } else if (weiRaised <= uint256(37000 ether)) {
            rate = uint256(1 ether) / 5000;
            return etherInWei.div(rate) * (10 ** decimals);
        }

    }
    function _forwardFunds()internal {
        wallet.transfer(msg.value);
    }

    function updateWallet(address _wallet)external onlyOwner {
        require(_wallet != address(0));
        wallet = _wallet;
    }
    function getAllContributors()public constant returns(address[]) {
        return allContributors;
    }
    function _addContributor(address _contributor)internal returns(uint) {
        allContributors.push(_contributor);
        return allContributors.length;
    }

    struct OffChainRecord {
        string txHash;
        uint256 amountSent;
        string receiverAddress;
        uint txType;
        uint liveRate;
        address tokenRecieverAddress;
        uint256 totalTokens;

    }

        function getOffChainRecord(string offChainHash)public constant returns(
        uint256 amountSent,
        uint txType,
        uint liveRate,
        address tokenRecieverAddress,
        uint256 totalTokens
    ) {
        require(bytes(offChainHash).length > 0);
        OffChainRecord memory offChainRecord = allOffchainRecords[offChainHash];
        amountSent = offChainRecord.amountSent;
        txType = offChainRecord.txType;
        liveRate = offChainRecord.liveRate;
        tokenRecieverAddress = offChainRecord.tokenRecieverAddress;
        totalTokens = offChainRecord.totalTokens;
    }
    function addOffChainRecord(
        string txHash,
        string receiverAddress,
        uint256 amountSent,
        uint txType,
        uint liveRate,
        address tokenRecieverAddress,
        string offChainHash,
        uint256 totalTokens
    )external onlyOwner {
        OffChainRecord memory offChainRecord;
        offChainRecord.txHash = txHash;
        offChainRecord.amountSent = amountSent;
        offChainRecord.txType = txType;
        offChainRecord.liveRate = liveRate;
        offChainRecord.tokenRecieverAddress = tokenRecieverAddress;
        offChainRecord.receiverAddress = receiverAddress;
        offChainRecord.totalTokens = totalTokens;
        tokenAddress.increaseBalance(tokenRecieverAddress, totalTokens);
        allOffchainRecords[offChainHash] = offChainRecord;
    }

}
