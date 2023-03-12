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
        // 3. Mint for future partners
        _batchInitialMintAndLock({
            owner: ASSET_EOA,
            numberOfVotingEscrow: 4,
            amountPerVotingEscrow: THREE_MILLION,
            lockTime: FOUR_YEARS
        });

        _batchInitialMintAndLock({
            owner: TEAM_MULTI_SIG,
            numberOfVotingEscrow: 18,
            amountPerVotingEscrow: THREE_MILLION,
            lockTime: FOUR_YEARS
        });

        _batchInitialMintAndLock({
            owner: ASSET_EOA,
            numberOfVotingEscrow: 4,
            amountPerVotingEscrow: TWO_MILLION,
            lockTime: FOUR_YEARS
        });

        _batchInitialMintAndLock({
            owner: TEAM_MULTI_SIG,
            numberOfVotingEscrow: 14,
            amountPerVotingEscrow: TWO_MILLION,
            lockTime: FOUR_YEARS
        });

        _batchInitialMintAndLock({
            owner: TEAM_MULTI_SIG,
            numberOfVotingEscrow: 15,
            amountPerVotingEscrow: ONE_MILLION,
            lockTime: FOUR_YEARS
        });

        _batchInitialMintAndLock({
            owner: ASSET_EOA,
            numberOfVotingEscrow: 5,
            amountPerVotingEscrow: ONE_MILLION,
            lockTime: TWO_YEARS
        });

        _batchInitialMintAndLock({
            owner: ASSET_EOA,
            numberOfVotingEscrow: 5,
            amountPerVotingEscrow: ONE_MILLION,
            lockTime: ONE_YEAR
        });

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
