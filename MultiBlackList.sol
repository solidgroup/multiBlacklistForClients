
interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

contract multiBlackListForClients {
    mapping (address => bool) blacklist public;
    address pairAddress;
    // The team need to add the factory address
    address pcsFactoryAddress = "";

    constructor(){
        // read create pair documentation - this function expect to get the pool's tokens.
        pairAddress = IUniswapV2Factory(pcsFactoryAddress).createPair(address(this), "tokenB address which will be in the pool");
        ......
    }

    function multiBlacklist(address[] memory addresses) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            require(addresses[i] != pairAddress, "Can't blacklist pair addres");
            blacklist[addresses[i]] = true;
        }
    }

    function multiRemoveFromBlacklist(address[] memory addresses) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            blacklist[addresses[i]] = false;
        }
    }

    function _transfer(address from, address to, uint256 amount){
        require(!blacklist[from] && !blacklist[to], "the address is blacklisted");
        
    }

}
