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
        _singleInitialMintAndLock(0xd0cC9738866cd82B237A14c92ac60577602d6c18, 1200000000000000000);
        _singleInitialMintAndLock(0x38dAEa6f17E4308b0Da9647dB9ca6D84a3A7E195, 24000000000000000000000);
        _singleInitialMintAndLock(0xaA970e6bD6E187492f8327e514c9E8c36c81f11E, 24000000000000000000000);
        _singleInitialMintAndLock(0xa66e216b038d0F4121bf9A218dABbf4759375f5E, 1200000000000000000000);
        _singleInitialMintAndLock(0xC9eebecb1d0AfF4fb2B9978516E075A33639892C, 1025088000000000000000);
        _singleInitialMintAndLock(0xe9335fabfB4536bE78D539D759a29e1AFE7455A6, 3508800000000000000000);
        _singleInitialMintAndLock(0x37FC9Dc092E8a30A63A1567C9ac9738A7D4A08ed, 1200000000000000000000);
        _singleInitialMintAndLock(0x0496cbAD3B943cc246Aa793AB069bFC5516961Ef, 1200000000000000000000);
        _singleInitialMintAndLock(0xaA970e6bD6E187492f8327e514c9E8c36c81f11E, 12000000000000000000000);
        _singleInitialMintAndLock(0x3aE6a0e8Ec1Edd305553686387dC85Ff8D16AC51, 1014000000000000000000);
        _singleInitialMintAndLock(0xED20BC9f8BE737572d7e40237023C7A8FEA3449e, 61044000000000000000);
        _singleInitialMintAndLock(0x6c7286c5AB525ccD92c134c0dCDfDdfcA018B048, 600000000000000000000);
        _singleInitialMintAndLock(0x5Be66f4095f89BD18aBE4aE9d2acD5021EC433Bc, 900000000000000000000);
        _singleInitialMintAndLock(0xB1fC41Cbad16caFDfC2ED196c7fe515DfB6a1577, 3762240000000000000000);
        _singleInitialMintAndLock(0x2Ba838E42126aC349D01c3D1FAc85a36266151a4, 36000000000000000000);
        _singleInitialMintAndLock(0x609470c2f08FF626078bA64Ceb905d73b155089d, 840000000000000000000);
        _singleInitialMintAndLock(0x947D9bcDc2C34Df8587630CAf45b2a2bf07c88cB, 6000000000000000000000);
        _singleInitialMintAndLock(0x82619EDe0ac5d964a0711613cFf5446ED3fF85Dc, 1200000000000000000);
        _singleInitialMintAndLock(0x707c4603FB72996FF95AB91f571516aFC0F3Fe1b, 70608000000000000000);
        _singleInitialMintAndLock(0x7E3b6f966f3666F77813db84DD352173749D24d8, 600000000000000000000);
        _singleInitialMintAndLock(0x037B21279931E628b11b4507b9F7870B15dE1C17, 787824000000000000000);
        _singleInitialMintAndLock(0x3C2d6d7144241F1F1203c29C124585e55B58975E, 240000000000000000000);

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
