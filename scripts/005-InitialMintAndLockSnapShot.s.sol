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
        _singleInitialMintAndLock(0x3C2d6d7144241F1F1203c29C124585e55B58975E, 240000000000000000000);
        _singleInitialMintAndLock(0xc742a9458c4Cc6f6498007ffC81266Cd3a3f578A, 28800000000000000000);
        _singleInitialMintAndLock(0x891C16d225e4Fd30d0874Bf2E139B0c11a459a07, 1351200000000000000000);
        _singleInitialMintAndLock(0x5FE1521173F553084eD21e5CbeDE7233b5fE1AA7, 120000000000000000000);
        _singleInitialMintAndLock(0x540A6992368aA24dd6baD1DB8BF4982e6183Caf3, 892536000000000000000);
        _singleInitialMintAndLock(0x20cE0C0f284219f4E0B68804a8333A782461674c, 30000000000000000000);
        _singleInitialMintAndLock(0x41a6ac7f4e4DBfFEB934f95F1Db58B68C76Dc4dF, 43788000000000000000);
        _singleInitialMintAndLock(0x9665B6F0CF162792851A902E452248B16F2f4b5A, 1692540023765800000000);
        _singleInitialMintAndLock(0x9665B6F0CF162792851A902E452248B16F2f4b5A, 978720000000000000000);
        _singleInitialMintAndLock(0x02706C602c59F86Cc2EbD9aE662a25987A7C7986, 198000000000000000000);
        _singleInitialMintAndLock(0x5FE1521173F553084eD21e5CbeDE7233b5fE1AA7, 480000000000000000000);
        _singleInitialMintAndLock(0x15Eb585735334Db4B0B75919e5990E6391863B39, 34800000000000000000);
        _singleInitialMintAndLock(0x96FCa82BB2ce4c5A700a14581412366CC05dd6fA, 3600000000000000000000);
        _singleInitialMintAndLock(0xb00d51d3992BC412f783D0e21EDcf952Ce651D91, 1824000000000000000);
        _singleInitialMintAndLock(0x56BbBDD8d9e939EC047E3a61907a4caF4d90d231, 4645200000000000000000);
        _singleInitialMintAndLock(0x274949b0dB377742A46074f75749E953A8da45A7, 5545200000000000000000);
        _singleInitialMintAndLock(0xDc43D0c0497FBf3BB3cf43dcAFaCe9c116d5dd21, 120000000000000000000);
        _singleInitialMintAndLock(0xAf79312EB821871208ac76A80c8E282f8796964e, 768000000000000000000);
        _singleInitialMintAndLock(0xe4ec13946CE37ae7b3EA6AAC315B486DAD7766F2, 774000000000000000000);
        _singleInitialMintAndLock(0xB3dDC2A5B4EbDb7640191906Bd4195E23e17142c, 1800000000000000000000);
        _singleInitialMintAndLock(0xb0FabE3bCAC50F065DBF68C0B271118DDC005402, 24000000000000000000000);
        _singleInitialMintAndLock(0x6fE4aceD57AE0b50D14229F3d40617C8b7d2F2E1, 2230332000000000000000);
        _singleInitialMintAndLock(0xd264bC31A13D962c22967f02e44DAdD8Bbf25232, 240000000000000000000);
        _singleInitialMintAndLock(0xbFB5458071867Bc00985BC6c13EE400327Ac5F97, 60000000000000000000);

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
