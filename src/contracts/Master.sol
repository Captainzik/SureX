// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "./handlers/Core.sol";
import "./handlers/Policies.sol";

contract SureXMaster is Core, Policies {
    constructor(
        uint useOpsRateBIPS,
        uint useDefaultRiskRateBIPS,
        uint useOverdueFeeRateBIPS
    ) Core(
        useOpsRateBIPS
    ) Policies(
        useDefaultRiskRateBIPS,
        useOverdueFeeRateBIPS
    ){}
}
