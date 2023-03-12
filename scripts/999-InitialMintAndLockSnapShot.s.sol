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
        _singleInitialMintAndLock(0xe9bCCEd88099FC4aacF78b7c43307E758E1a5382, 1200000000000000000000);
        _singleInitialMintAndLock(0x7206BC81E2C52441EEFfE120118aC880f4528dDA, 3049200000000000000000);
        _singleInitialMintAndLock(0x1448D297420799a0dEB4bE0C270E8ec310c8E8dD, 4800000000000000000);
        _singleInitialMintAndLock(0x75592081D5FC1c38d2da8098dfE535CaDBe39425, 12000000000000000000);
        _singleInitialMintAndLock(0x9105F56F58A9cDB0e2DFb8696197CFAF3E45b9F0, 2904000000000000000);
        _singleInitialMintAndLock(0x8DE3c3891268502F77DB7E876d727257DEc0F852, 40380000000000000000);
        _singleInitialMintAndLock(0x5D8A52e816b7A29789C32dD21A034caDDd2bC750, 60000000000000000000);
        _singleInitialMintAndLock(0x7074E05C39b41EDd1C16478856b5de54B3ac67D6, 1200000000000000000);
        _singleInitialMintAndLock(0xD016cCF7B485D658E063d2E7CB3Afef94Bf79548, 6000000000000000000);
        _singleInitialMintAndLock(0x7A8B83DaC270463895233Bb3932A799c12919f27, 4200000000000000000);
        _singleInitialMintAndLock(0xDE0187458364Eb836D5bF563721efD1ED14B9673, 337200000000000000000);
        _singleInitialMintAndLock(0xdDb3e886D78F180A0B435741901cE091cdd0a848, 165264000000000000000);
        _singleInitialMintAndLock(0x0b776552c1Aef1Dc33005DD25AcDA22493b6615d, 1200120000000000000000);
        _singleInitialMintAndLock(0x9BDbdb4A8f7f816C87a67F5281484ED902C6b942, 1800000000000000000);
        _singleInitialMintAndLock(0xf4E2152c622260A1f1f8E8B8c4C3C5065165Ce55, 118800000000000000000);
        _singleInitialMintAndLock(0xd204Bc46046FC0Cd3f074fF9B3Be7b5C59f0a150, 3475464000000000000000);
        _singleInitialMintAndLock(0xD7bb2EeE591CE19A54636600936eAB8a40f5a65C, 9600000000000000000);
        _singleInitialMintAndLock(0xEb0CeB1F89D1dd01bDFD2Ff9e145271d8FEEfB00, 192000000000000000000);
        _singleInitialMintAndLock(0x686Bd59caE3e78107515E87B2895cCBe27fb7D0A, 1800000000000000000000);
        _singleInitialMintAndLock(0xb245A959A3D2608e248239638a240c5FCFE20596, 856800000000000000000);
        _singleInitialMintAndLock(0xdDb3e886D78F180A0B435741901cE091cdd0a848, 246396000000000000000);
        _singleInitialMintAndLock(0x4A80f927126eC56c1E6773805fFa03A04216b293, 28406400000000000000000);
        _singleInitialMintAndLock(0xB1e22281E1BC8Ab83Da1CB138e24aCB004B5a4ca, 3600000000000000000000);
        _singleInitialMintAndLock(0x84A51c92a653dc0e6AE11C9D873C55Ee7Af62106, 2113200000000000000);
        _singleInitialMintAndLock(0x84A51c92a653dc0e6AE11C9D873C55Ee7Af62106, 2110800000000000000000);
        _singleInitialMintAndLock(0x3bE2a617a86DD49Bc8893ca04CEa2e5F444F9c12, 717600000000000000000);

        // set initializer to 0 so we can no longer mint more
        minter.startActivePeriod();

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
