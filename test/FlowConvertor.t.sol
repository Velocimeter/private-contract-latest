pragma solidity 0.8.13;

import "forge-std/Test.sol";
import {Flow} from "../contracts/Flow.sol";
import {FlowConvertor} from "../contracts/FlowConvertor.sol";
import {IFlow} from "../contracts/interfaces/IFlow.sol";

contract FlowConvertorTest is Test {
    address private constant FLOW_V1 = 0x2Baec546a92cA3469f71b7A091f7dF61e5569889;
    address private constant TEAM_MULTI_SIG = 0x13eeB8EdfF60BbCcB24Ec7Dd5668aa246525Dc51;

    address private constant INITIAL_SUPPLY_RECIPIENT = address(1);
    address private constant REDEEMER = address(2);
    uint256 private constant FLOW_V1_BALANCE = 1_000e18;
    Flow private flow;
    FlowConvertor private flowConvertor;

    function setUp() public {
        vm.createSelectFork("https://mainnode.plexnode.org:8545");

        flow = new Flow({initialSupplyRecipient: INITIAL_SUPPLY_RECIPIENT, csrRecipient: TEAM_MULTI_SIG});
        flowConvertor = new FlowConvertor({_v1: FLOW_V1, _v2: address(flow)});

        vm.prank(INITIAL_SUPPLY_RECIPIENT);
        flow.transfer(address(flowConvertor), 50e24);

        deal(FLOW_V1, REDEEMER, FLOW_V1_BALANCE);
    }

    function testRedeem() public {
        vm.startPrank(REDEEMER);
        IFlow(FLOW_V1).approve(address(flowConvertor), FLOW_V1_BALANCE);
        flowConvertor.redeem(FLOW_V1_BALANCE);
        vm.stopPrank();

        assertEq(flow.balanceOf(REDEEMER), FLOW_V1_BALANCE);
        assertEq(IFlow(FLOW_V1).balanceOf(REDEEMER), 0);
    }

    function testRedeemTo() public {
        vm.startPrank(REDEEMER);
        IFlow(FLOW_V1).approve(address(flowConvertor), FLOW_V1_BALANCE);
        address customRecipient = address(3);
        flowConvertor.redeemTo(customRecipient, FLOW_V1_BALANCE);
        vm.stopPrank();

        assertEq(flow.balanceOf(customRecipient), FLOW_V1_BALANCE);
        assertEq(IFlow(FLOW_V1).balanceOf(REDEEMER), 0);
    }
}
