// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

/**
 * @title IListenModule
 * @author SoundIt Protocol
 *
 * @notice This is the standard interface for all Lens-compatible ListenModules.
 */
interface IListenModule {
    /**
     * @notice Initializes data for a given publication being published. This can only be called by the hub.
     *
     * @param profileId The token ID of the profile publishing the publication.
     * @param pubId The associated publication's LensHub publication ID.
     * @param data Arbitrary data __passed from the user!__ to be decoded.
     *
     * @return bytes An abi encoded byte array encapsulating the execution's state changes. This will be emitted by the
     * hub alongside the listen module's address and should be consumed by front ends.
     */
    function initializePublicationListenModule(
        uint256 profileId,
        uint256 pubId,
        bytes calldata data
    ) external returns (bytes memory);

    /**
     * @notice Processes a listen action for a given publication, this can only be called by the hub.
     *
     * @param referrerProfileId The LensHub profile token ID of the referrer's profile (only different in case of mirrors).
     * @param listener The listener address.
     * @param profileId The token ID of the profile associated with the publication being listened.
     * @param pubId The LensHub publication ID associated with the publication being listened.
     * @param data Arbitrary data __passed from the listener!__ to be decoded.
     */
    function processListen(
        uint256 referrerProfileId,
        address listener,
        uint256 profileId,
        uint256 pubId,
        bytes calldata data
    ) external;
}
