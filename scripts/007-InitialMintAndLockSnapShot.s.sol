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
        _singleInitialMintAndLock(0x1C86E98A4CC451db8A502f31c14327D2B7CEC123, 339532320000000000000);
        _singleInitialMintAndLock(0x17114903eB90909D3058dAE24D583E5970030FFb, 5400000000000000000000);
        _singleInitialMintAndLock(0x17114903eB90909D3058dAE24D583E5970030FFb, 3829200000000000000000);
        _singleInitialMintAndLock(0xe12D731750E222eC53b001E00d978901B134CFC9, 332400000000000000000);
        _singleInitialMintAndLock(0x801612E860e40612cfbbdEF0133A2Fb6938f2f73, 48000000000000000000);
        _singleInitialMintAndLock(0xe12D731750E222eC53b001E00d978901B134CFC9, 2145600000000000000000);
        _singleInitialMintAndLock(0xE7A1C621Ed75EC40fe4c86605e60d2851287D14D, 146400000000000000000);
        _singleInitialMintAndLock(0xD1A0B66835D830e9ada42eEf436f3AA8005b20B5, 1896000000000000000000);
        _singleInitialMintAndLock(0x7Cb552152e2b28F9f6911c51B69B0d8D1FADafe1, 96000000000000000000);
        _singleInitialMintAndLock(0x249A49d3201C1B92a1029Aab1BC76a6Ca8f5FFf0, 248400000000000000000);
        _singleInitialMintAndLock(0xc27FD9D5113dE19EA89D0265Be9FD93F35f052c8, 2341200000000000000000);
        _singleInitialMintAndLock(0xf6301E682769A8b3ECdCe94b2419ba40A958D17e, 3085080000000000000000);
        _singleInitialMintAndLock(0xfe5a2B6Cf60e8A5c06a87c999E7944421653e0f3, 240000000000000000000);
        _singleInitialMintAndLock(0x0D0d6625F9A0B3370b4b69393E59fdD4d077BB38, 784800000000000000000);
        _singleInitialMintAndLock(0xbC82A7232c1f043e4cc608e0eC1510Cf50E28f64, 108000000000000000000);
        _singleInitialMintAndLock(0x35128c4263aA0213c59A897Fd31d8C837E8B71C8, 120000000000000000000);
        _singleInitialMintAndLock(0x7Cb552152e2b28F9f6911c51B69B0d8D1FADafe1, 12000000000000000000);
        _singleInitialMintAndLock(0xDE0187458364Eb836D5bF563721efD1ED14B9673, 240000000000000000000);
        _singleInitialMintAndLock(0x0a3043F9d2b1c6cCfc492EB59Af5156F378c57BD, 1200000000000000000);
        _singleInitialMintAndLock(0xAE886e2A6AA00e98C0C7b1e4885f94a2dB720690, 6240696000000000000000);
        _singleInitialMintAndLock(0x5fA275BA9F04BDC906084478Dbf41CBE29388C5d, 112800000000000000000);

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
