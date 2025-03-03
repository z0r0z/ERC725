// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

// modules
import {ERC725XInitAbstract} from "./ERC725XInitAbstract.sol";
import {ERC725YInitAbstract} from "./ERC725YInitAbstract.sol";
import {ERC725XCore} from "./ERC725XCore.sol";
import {ERC725YCore} from "./ERC725YCore.sol";

// constants
import {_INTERFACEID_ERC725X, _INTERFACEID_ERC725Y} from "./constants.sol";

/**
 * @title Inheritable Proxy Implementation of ERC725 bundle
 * @author Fabian Vogelsteller <fabian@lukso.network>
 * @dev Bundles ERC725XInit and ERC725YInit together into one smart contract
 */
abstract contract ERC725InitAbstract is ERC725XInitAbstract, ERC725YInitAbstract {
    function _initialize(address _newOwner)
        internal
        virtual
        override(ERC725XInitAbstract, ERC725YInitAbstract)
        onlyInitializing
    {
        ERC725XInitAbstract._initialize(_newOwner);
        ERC725YInitAbstract._initialize(_newOwner);
    }

    // NOTE this implementation has not by default: receive() external payable {}

    /* Overrides functions */

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC725XCore, ERC725YCore)
        returns (bool)
    {
        return
            interfaceId == _INTERFACEID_ERC725X ||
            interfaceId == _INTERFACEID_ERC725Y ||
            super.supportsInterface(interfaceId);
    }
}
