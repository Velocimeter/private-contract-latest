// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {WrappedExternalBribe} from 'contracts/WrappedExternalBribe.sol';
import 'contracts/interfaces/ITurnstile.sol';

contract WrappedExternalBribeFactory {
    address public constant TURNSTILE = 0xEcf044C5B4b867CFda001101c617eCd347095B44;
    uint256 public immutable csrNftId;
    address public voter;
    mapping(address => address) public oldBribeToNew;
    address public last_bribe;

    event VoterSet(address indexed setter, address indexed voter);

    constructor(uint256 _csrNftId) {
        ITurnstile(TURNSTILE).assign(_csrNftId);
        csrNftId = _csrNftId;
    }

    function createBribe(address existing_bribe) external returns (address) {
        require(
            oldBribeToNew[existing_bribe] == address(0),
            "Wrapped bribe already created"
        );
        last_bribe = address(new WrappedExternalBribe(voter, existing_bribe, csrNftId));
        oldBribeToNew[existing_bribe] = last_bribe;
        return last_bribe;
    }

    function setVoter(address _voter) external {
        require(voter == address(0), "Already initialized");
        voter = _voter;
        emit VoterSet(msg.sender, _voter);
    }
}
