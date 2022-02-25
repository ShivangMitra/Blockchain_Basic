contract zephcoin_ico {
    uint256 public max_zephcoins = 1000000;

    uint256 public usd_to_zephcoins = 1000;

    uint256 public total_zephcoins_bought = 0;

    mapping(address => uint256) equity_zephcoins;
    mapping(address => uint256) equity_usd;

    modifier can_buy_zephcoins(uint256 usd_invested) {
        require(
            usd_invested * usd_to_zephcoins + total_zephcoins_bought <=
                max_zephcoins
        );
        _;
    }

    function equity_in_zephcoin(address investor)
        external
        constant
        returns (uint256)
    {
        return equity_zephcoins[investor];
    }

    function equity_in_usd(address investor)
        external
        constant
        returns (uint256)
    {
        return equity_usd[investor];
    }

    function buy_zephcoins(address investor, uint256 usd_invested)
        external
        can_buy_zephcoins(usd_invested)
    {
        uint256 zephcoins_bought = usd_invested * usd_to_zephcoins;
        equity_zephcoins[investor] += zephcoins_bought;
        equity_usd[investor] = equity_zephcoins[investor] / 1000;
        total_zephcoins_bought += zephcoins_bought;
    }

    function sell_zephcoins(address investor, uint256 zephcoins_sold) external {
        equity_zephcoins[investor] -= zephcoins_sold;
        equity_usd[investor] = equity_zephcoins[investor] / 1000;
        total_zephcoins_bought -= zephcoins_sold;
    }
}
