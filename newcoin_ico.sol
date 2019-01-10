// Newcoin ICO

pragma solidity ^0.5.0;

contract NewcoinIco {
  
    uint public maxNewcoin = 1000000;

    // USD to Newcoin conversion rate
    uint public usdToNewcoin = 1000;
    uint public totalNewcoinBought = 0;

    // Mapping from the investor address to its equity in Newcoin and USD
    mapping(address => uint) equityNewcoin;
    mapping(address => uint) equityUsd;
    
    // Check if an investor can buy Newcoin
    modifier canBuyNewcoin(uint usdInvested) {
        require (usdInvested * usdToNewcoin + totalNewcoinBought <= maxNewcoin);
        _;
    }

    // Get the equity in Newcoin of an investor
    function equityInNewcoin(address investor) external view returns (uint) {
        return equityNewcoin[investor];
    }

    // Get the equity in USD of an investor
    function equityInUsd(address investor) external view returns (uint) {
        return equityUsd[investor];
    }

    function buyNewcoin(address investor, uint usdInvested) external
    canBuyNewcoin(usdInvested) {
        uint newcoinBought = usdInvested * usdToNewcoin;
        equityNewcoin[investor] += newcoinBought;
        equityUsd[investor] = equityNewcoin[investor] / 1000;
        totalNewcoinBought += newcoinBought;
    }

    function sellNewcoin(address investor, uint newcoinSold) external {
        equityNewcoin[investor] -= newcoinSold;
        equityUsd[investor] = equityNewcoin[investor] / 1000;
        totalNewcoinBought -= newcoinSold;
    }

}