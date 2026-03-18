// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Escrow} from "./Escrow.sol";

contract EscrowFactory {
    address[] public escrows;
    address public immutable feeRecipient;
    uint16 public immutable defaultFeeBps;

    event EscrowCreated(
        address indexed escrow,
        address indexed payer,
        address indexed payee,
        uint256 amount,
        uint16 feeBps,
        address feeRecipient
    );

    constructor(address _feeRecipient, uint16 _defaultFeeBps) {
        require(_defaultFeeBps <= Escrow.MAX_FEE_BPS(), "Fee too high");
        if (_defaultFeeBps > 0) require(_feeRecipient != address(0), "Invalid feeRecipient");
        feeRecipient = _feeRecipient;
        defaultFeeBps = _defaultFeeBps;
    }

    function createEscrow(
        address payer,
        address payee,
        address arbiter,
        uint256 amount,
        uint256 releaseAfter,
        uint256 refundAfter
    ) external returns (address) {
        Escrow escrow = new Escrow(
            payer,
            payee,
            arbiter,
            feeRecipient,
            amount,
            releaseAfter,
            refundAfter,
            defaultFeeBps
        );
        escrows.push(address(escrow));
        emit EscrowCreated(address(escrow), payer, payee, amount, defaultFeeBps, feeRecipient);
        return address(escrow);
    }

    function getEscrows() external view returns (address[] memory) {
        return escrows;
    }
}
