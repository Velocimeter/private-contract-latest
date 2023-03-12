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
        _singleInitialMintAndLock(0xd7F1BfBfA430FFEE78511E37772cAdaFF63A9A23, 1200000000000000000);
        _singleInitialMintAndLock(0xCba1A275e2D858EcffaF7a87F606f74B719a8A93, 300000000000000000000000);
        _singleInitialMintAndLock(0x4A401Ee7Fef089CD20D183fE2510d7BD38294728, 241200000000000000000);
        _singleInitialMintAndLock(0xFe36AacBCF5677a4A04288764C16acb4220894b9, 1200000000000000000000);
        _singleInitialMintAndLock(0x707c4603FB72996FF95AB91f571516aFC0F3Fe1b, 61398000000000000000);
        _singleInitialMintAndLock(0xAA1742ab92c694934b97Ab9F557E565Bd2217BFf, 120000000000000000000);
        _singleInitialMintAndLock(0xE524D29daf6D7CDEaaaF07Fa1aa7732a45f330B3, 1080000000000000000000);
        _singleInitialMintAndLock(0x8E07Ab8Fc9E5F2613b17a5E5069673d522D0207a, 120000000000000000000);
        _singleInitialMintAndLock(0x9DEB607b7E92096df55b02aA563e82F612fD0DEf, 1670256000000000000000);
        _singleInitialMintAndLock(0x7798Ba9512B5A684C12e31518923Ea4221A41Fb9, 1712160000000000000000);
        _singleInitialMintAndLock(0x868CBfd33ec93B451c510125E4D9f1AB1E42fcD2, 1680396000000000000000);
        _singleInitialMintAndLock(0xAB63953B631336bD204fdcF126e2a010A47b1A36, 780000000000000000000);
        _singleInitialMintAndLock(0x7074E05C39b41EDd1C16478856b5de54B3ac67D6, 1200000000000000000);
        _singleInitialMintAndLock(0x479dE30A1E7e53657C437a6d36ae6389B290B5Fb, 3600000000000000000000);
        _singleInitialMintAndLock(0xb8920e475E32B807cE51e0eF823fE070D7D96e8C, 528000000000000000000);
        _singleInitialMintAndLock(0xb0916C38861dCeef1A62A77887e573861FFb5d63, 27600000000000000000);
        _singleInitialMintAndLock(0x707c4603FB72996FF95AB91f571516aFC0F3Fe1b, 27634800000000000000);
        _singleInitialMintAndLock(0xDEb3994785Bfc8863e808df0E0C43C9C0058d7c9, 571440000000000000000);
        _singleInitialMintAndLock(0x4CE69fd760AD0c07490178f9a47863Dc0358cCCD, 600000000000000000000);
        _singleInitialMintAndLock(0x6F106e0ef498a594CCE8280976822fA3798A35cb, 2429760000000000000000);
        _singleInitialMintAndLock(0x9b25235ee2e5564F50810E03eA5F91976A8EE6fA, 4705200000000000000000);
        _singleInitialMintAndLock(0xEFa9bEbE299dE7AcAECa6876E1E4f5508eEeF2db, 7200000000000000000);

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
