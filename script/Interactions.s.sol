// SPDX-License-Identifier: MIT

// Fund
// Withdraw

pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    //llama a la funcion fund de FundMe
    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        //console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        //obtiene la direccion del ultimo FundMe
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed); //llama a la funcion que lo fundea
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    //llama a la funcion withdraw de FundMe
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        //obtiene la direccion del ultimo FundMe
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed); //llama a la funcion que lo withdrawea
        vm.stopBroadcast();
    }
}
