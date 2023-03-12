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
        _singleInitialMintAndLock(0x97294B51BF128E6988c7747E0696Ed7F7CfEe993, 1856040000000000000000);
        _singleInitialMintAndLock(0x945a873B0E08a361458141f637031490cA01b9c1, 805200000000000000000);
        _singleInitialMintAndLock(0x865D7eb5db37cc02ec209DD778f4e3851a421A20, 329760000000000000000);
        _singleInitialMintAndLock(0x97c98D6ab8DBbfe6ba464BD7a849d376DA1bB540, 180000000000000000000);
        _singleInitialMintAndLock(0x55e1490a1878D0B61811726e2cB96560022E764c, 86880000000000000000);
        _singleInitialMintAndLock(0x97Db0E57b1C315a08cc889Ed405ADB100D7F137d, 1327116000000000000000);
        _singleInitialMintAndLock(0xc45D05CDc809d20c7B14959E8cd4a1199E3e966F, 1419144000000000000000);
        _singleInitialMintAndLock(0xEfce38f31Ebeb9637E85D3487595261FDf6ebeEb, 174600000000000000000);
        _singleInitialMintAndLock(0x5A1a3dff949225E39767Ca981218756DB47C7d8c, 60000000000000000000);
        _singleInitialMintAndLock(0xd286a9bB11d2165915E3bf6D1c79aadEBe30f605, 90900000000000000000);
        _singleInitialMintAndLock(0xBd1E1Cc9613B510d1669D1e79Fd0115C70a4C7be, 480000000000000000000);
        _singleInitialMintAndLock(0xBd1E1Cc9613B510d1669D1e79Fd0115C70a4C7be, 547200000000000000000);
        _singleInitialMintAndLock(0xC438E5d32f9381b59072b9a0c730Cbac41575A4E, 6000000000000000000000);
        _singleInitialMintAndLock(0x1E480827489E3eA19f82EF213b67200A76C0DF58, 360000000000000000000);
        _singleInitialMintAndLock(0x0D69BF20A4A00cbebC569E4beF27a78DcB4C0880, 240000000000000000000);
        _singleInitialMintAndLock(0x1E480827489E3eA19f82EF213b67200A76C0DF58, 1492800000000000000000);
        _singleInitialMintAndLock(0x908E8E8084d660f8f9054AA8Ad1B31380d04B08F, 85572000000000000000);
        _singleInitialMintAndLock(0xdDb3e886D78F180A0B435741901cE091cdd0a848, 1862400000000000000000);
        _singleInitialMintAndLock(0x90F15E09B8Fb5BC080B968170C638920Db3A3446, 120000000000000000000000);
        _singleInitialMintAndLock(0xbC82A7232c1f043e4cc608e0eC1510Cf50E28f64, 217200000000000000000);
        _singleInitialMintAndLock(0x56E30aF541D4d54b96770Ecc1a9113F02FEe3bf1, 18917688000000000000000);
        _singleInitialMintAndLock(0x20cE0C0f284219f4E0B68804a8333A782461674c, 30000000000000000000);

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
