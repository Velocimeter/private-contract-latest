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
        _singleInitialMintAndLock(0x5fA275BA9F04BDC906084478Dbf41CBE29388C5d, 120000000000000000000);
        _singleInitialMintAndLock(0x5fA275BA9F04BDC906084478Dbf41CBE29388C5d, 62400000000000000000);
        _singleInitialMintAndLock(0xC9eebecb1d0AfF4fb2B9978516E075A33639892C, 1200000000000000000000);
        _singleInitialMintAndLock(0x865D7eb5db37cc02ec209DD778f4e3851a421A20, 364800000000000000000);
        _singleInitialMintAndLock(0xd0441C0B63f6c97D56e9490B3fdd1c45F89D3678, 5806800000000000000000);
        _singleInitialMintAndLock(0xb0916C38861dCeef1A62A77887e573861FFb5d63, 14400000000000000000);
        _singleInitialMintAndLock(0xbA00D84Ddbc8cAe67C5800a52496E47A8CaFcd27, 21493200000000000000000);
        _singleInitialMintAndLock(0xD40846A19fdC9c8255DCcD18BcBB261BDBF5e4db, 338040000000000000000);
        _singleInitialMintAndLock(0xFe36AacBCF5677a4A04288764C16acb4220894b9, 1200000000000000000000);
        _singleInitialMintAndLock(0x4c890Dc20f7D99D0135396A08d07d1518a45a1DD, 1200000000000000000);
        _singleInitialMintAndLock(0xbA00D84Ddbc8cAe67C5800a52496E47A8CaFcd27, 19147200000000000000000);
        _singleInitialMintAndLock(0xD40846A19fdC9c8255DCcD18BcBB261BDBF5e4db, 2815200000000000000000);
        _singleInitialMintAndLock(0x5fA275BA9F04BDC906084478Dbf41CBE29388C5d, 122400000000000000000);
        _singleInitialMintAndLock(0xD40846A19fdC9c8255DCcD18BcBB261BDBF5e4db, 978000000000000000000);
        _singleInitialMintAndLock(0x9505F160A9a74ad532d674De4F200484e0049b43, 1489680000000000000000);
        _singleInitialMintAndLock(0x9505F160A9a74ad532d674De4F200484e0049b43, 1489680000000000000000);
        _singleInitialMintAndLock(0xb6fB12999a09eFfdbcC6F60776331eacCc42E539, 60000000000000000000000);
        _singleInitialMintAndLock(0xb6fB12999a09eFfdbcC6F60776331eacCc42E539, 60000000000000000000000);
        _singleInitialMintAndLock(0x0a3043F9d2b1c6cCfc492EB59Af5156F378c57BD, 14164800000000000000000);
        _singleInitialMintAndLock(0xD26eA7412FB75D5E4c8c9F3EE7b1dfFf64440eE8, 31200000000000000000);
        _singleInitialMintAndLock(0xDE0187458364Eb836D5bF563721efD1ED14B9673, 6000000000000000000);
        _singleInitialMintAndLock(0x859Fc918Cf1322686FeC52A30E4A9eA388DF876D, 12000000000000000000);

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
