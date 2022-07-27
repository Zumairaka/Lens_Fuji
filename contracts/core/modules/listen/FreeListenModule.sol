// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import {IListenModule} from '../../../interfaces/IListenModule.sol';
import {ModuleBase} from '../ModuleBase.sol';
import {FollowValidationModuleBase} from '../FollowValidationModuleBase.sol';

/**
 * @title FreeListenModule
 * @author Lens Protocol
 *
 * @notice This is a simple Lens ListenModule implementation, inheriting from the IListenModule interface.
 *
 * This module works by allowing all listeners.
 */
contract FreeListenModule is FollowValidationModuleBase, IListenModule {
    constructor(address hub) ModuleBase(hub) {}

    mapping(uint256 => mapping(uint256 => bool)) internal _followerOnlyByPublicationByProfile;

    /**
     * @dev There is nothing needed at initialization.
     */
    function initializePublicationListenModule(
        uint256 profileId,
        uint256 pubId,
        bytes calldata data
    ) external override onlyHub returns (bytes memory) {
        bool followerOnly = abi.decode(data, (bool));
        if (followerOnly) _followerOnlyByPublicationByProfile[profileId][pubId] = true;
        return data;
    }

    /**
     * @dev Processes a listen by:
     *  1. Ensuring the listener is a follower, if needed
     */
    function processListen(
        uint256 referrerProfileId,
        address listener,
        uint256 profileId,
        uint256 pubId,
        bytes calldata data
    ) external view override {
        if (_followerOnlyByPublicationByProfile[profileId][pubId])
            _checkFollowValidity(profileId, listener);
    }
}
