// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Scripting tool
import {Script} from "../lib/forge-std/src/Script.sol";

import {Minter} from "../contracts/Minter.sol";

contract InitialMintAndLock is Script {
    address private constant TEAM_MULTI_SIG = 0x13eeB8EdfF60BbCcB24Ec7Dd5668aa246525Dc51;

    // address to receive veNFT to be distributed to partners in the future
    address private constant FLOW_VOTER_EOA = 0xcC06464C7bbCF81417c08563dA2E1847c22b703a;
    address private constant ASSET_EOA = 0x1bAe1083CF4125eD5dEeb778985C1Effac0ecC06;

    // team member addresses
    address private constant DUNKS = 0x069e85D4F1010DD961897dC8C095FBB5FF297434;
    address private constant T0RB1K = 0x0b776552c1Aef1Dc33005DD25AcDA22493b6615d;
    address private constant CEAZOR = 0x06b16991B53632C2362267579AE7C4863c72fDb8;
    address private constant MOTTO = 0x78e801136F77805239A7F533521A7a5570F572C8;
    address private constant COOLIE = 0x03B88DacB7c21B54cEfEcC297D981E5b721A9dF1;

    // token amounts
    uint256 private constant ONE_MILLION = 1e24; // 1e24 == 1e6 (1m) ** 1e18 (decimals)
    uint256 private constant TWO_MILLION = 2e24; // 2e24 == 1e6 (1m) ** 1e18 (decimals)
    uint256 private constant THREE_MILLION = 3e24; // 3e24 == 1e6 (1m) ** 1e18 (decimals)
    uint256 private constant FOUR_MILLION = 4e24; // 4e24 == 1e6 (1m) ** 1e18 (decimals)

    // time
    uint256 private constant ONE_YEAR = 31_536_000;
    uint256 private constant TWO_YEARS = 63_072_000;
    uint256 private constant FOUR_YEARS = 126_144_000;

    Minter private minter;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // TODO: Fill address after mainnet deploy
        minter = Minter(0x41dc163DA8E280743585fde657cFC8937b0c7F9B);

        // Mint tokens and lock for veNFT
        // Mint for snapshot recipients, quants already 1.2x
        _singleInitialMintAndLock(0x56F662AADe12e5aB99C4dcb037d1274d0d5dcb94, 29897047241334700000000);
        _singleInitialMintAndLock(0x3a390b018fc3425d06FB84DCcdD140481A960939, 2452800000000000000000);
        _singleInitialMintAndLock(0xCb59280EB3983a4221263343EF184D2D0189De17, 158400000000000000000);
        _singleInitialMintAndLock(0x0d7BbDb6d0D82E896ECB8ED8Bc33aaBd20dE0dA9, 3506400000000000000000);
        _singleInitialMintAndLock(0x2ed284077cc25A3f400DAEA79714Ac4A5AC474aC, 613200000000000000000);
        _singleInitialMintAndLock(0x14989473630F117Dd5583B946B9B4733CD305e57, 6741600000000000000000);
        _singleInitialMintAndLock(0x6f5a8A35fb10EEcEF9128f407a0fe67B898556CF, 12554198211802100000000);
        _singleInitialMintAndLock(0x812B9c3Ea2c49beC95D0Bcda4Db39513baaee261, 1789008000000000000000);
        _singleInitialMintAndLock(0x80bb0D87DCe1a94329586Ce9C7d39692bBf44af6, 1200000000000000000000);
        _singleInitialMintAndLock(0x80bb0D87DCe1a94329586Ce9C7d39692bBf44af6, 120000000000000000000);
        _singleInitialMintAndLock(0x30B5a6e6f54507E0DEE280923234204B6A82664A, 195492000000000000000);
        _singleInitialMintAndLock(0x2e0692A3d9097931E9b7ba47035C8EA4A388f747, 7044000000000000000000);
        _singleInitialMintAndLock(0x57702217d1cDbf4DF7110ABD91832216310B4062, 1200000000000000000000);
        _singleInitialMintAndLock(0x09bAc567D73E8BC701a900D14C90c06644eA0156, 885600000000000000000);
        _singleInitialMintAndLock(0x4A228f14d2130E8E4636418B52aAF3D6b4E887D3, 4382400000000000000000);
        _singleInitialMintAndLock(0xd8b87A01980eB792e3BC030bDEc42Db2b9B5CBfc, 241200000000000000000);
        _singleInitialMintAndLock(0x25217b4A6138350350A2ce1f97A6B0111bbFdB56, 1200000000000000000000);
        _singleInitialMintAndLock(0x973872cA85cD7175b02FE24701438174901ED751, 1560000000000000000000);
        _singleInitialMintAndLock(0xB0720A40d6335dF0aC90fF9e4b755217632Ca78C, 1488000000000000000000);
        _singleInitialMintAndLock(0x3AA6605d87f611E43aD0a64740d6BeF9b80FCD2C, 6000000000000000000000);
        _singleInitialMintAndLock(0x135Cc51c0b07a8f70256e8DF398e6B916b402444, 360000000000000000000);
        _singleInitialMintAndLock(0x945a873B0E08a361458141f637031490cA01b9c1, 576000000000000000000);
        _singleInitialMintAndLock(0x464F6392E68Bc6093354E5bf12692e37F5e4113e, 1200000000000000000000);

        vm.stopBroadcast();
    }

    function _singleInitialMintAndLock(address owner, uint256 amount) private {
        Minter.Claim[] memory claim = new Minter.Claim[](1);
        claim[0] = Minter.Claim({claimant: owner, amount: amount, lockTime: FOUR_YEARS});
        minter.initialMintAndLock(claim, amount);
    }

    function _batchInitialMintAndLock(
        address owner,
        uint256 numberOfVotingEscrow,
        uint256 amountPerVotingEscrow,
        uint256 lockTime
    ) private {
        Minter.Claim[] memory claim = new Minter.Claim[](numberOfVotingEscrow);
        for (uint256 i; i < numberOfVotingEscrow; i++) {
            claim[i] = Minter.Claim({claimant: owner, amount: amountPerVotingEscrow, lockTime: lockTime});
        }
        minter.initialMintAndLock(claim, amountPerVotingEscrow * numberOfVotingEscrow);
    }
}
