// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Escrow is ReentrancyGuard {
    enum State {
        AwaitingDeposit,
        Funded,
        Disputed,
        Released,
        Refunded
    }

    uint256 public constant MAX_FEE_BPS = 1_000; // 10%

    address public immutable payer;
    address public immutable payee;
    address public immutable arbiter;
    address public immutable feeRecipient;
    uint256 public immutable amount;
    uint256 public immutable releaseAfter;
    uint256 public immutable refundAfter;
    uint16 public immutable feeBps;

    State public state;
    bool public payerApprovedRelease;
    bool public payeeApprovedRelease;
    bool public payerApprovedRefund;
    bool public payeeApprovedRefund;

    event Deposited(address indexed from, uint256 amount);
    event ReleaseApproved(address indexed by);
    event RefundApproved(address indexed by);
    event DisputeRaised(address indexed by);
    event Released(address indexed to, uint256 grossAmount, uint256 feeAmount, address indexed feeRecipient);
    event Refunded(address indexed to, uint256 amount);

    modifier onlyPayer() {
        require(msg.sender == payer, "Not payer");
        _;
    }

    modifier onlyArbiter() {
        require(msg.sender == arbiter, "Not arbiter");
        _;
    }

    modifier inState(State expected) {
        require(state == expected, "Invalid state");
        _;
    }

    constructor(
        address _payer,
        address _payee,
        address _arbiter,
        address _feeRecipient,
        uint256 _amount,
        uint256 _releaseAfter,
        uint256 _refundAfter,
        uint16 _feeBps
    ) {
        require(_payer != address(0), "Invalid payer");
        require(_payee != address(0), "Invalid payee");
        require(_arbiter != address(0), "Invalid arbiter");
        require(_amount > 0, "Invalid amount");
        require(_releaseAfter > block.timestamp, "Bad releaseAfter");
        require(_refundAfter > _releaseAfter, "Bad refundAfter");
        require(_feeBps <= MAX_FEE_BPS, "Fee too high");
        if (_feeBps > 0) require(_feeRecipient != address(0), "Invalid feeRecipient");

        payer = _payer;
        payee = _payee;
        arbiter = _arbiter;
        feeRecipient = _feeRecipient;
        amount = _amount;
        releaseAfter = _releaseAfter;
        refundAfter = _refundAfter;
        feeBps = _feeBps;
        state = State.AwaitingDeposit;
    }

    function deposit() external payable onlyPayer inState(State.AwaitingDeposit) {
        require(msg.value == amount, "Incorrect deposit");
        state = State.Funded;
        emit Deposited(msg.sender, msg.value);
    }

    function approveRelease() external inState(State.Funded) {
        require(msg.sender == payer || msg.sender == payee, "Unauthorized");
        if (msg.sender == payer) payerApprovedRelease = true;
        if (msg.sender == payee) payeeApprovedRelease = true;
        emit ReleaseApproved(msg.sender);
        if (payerApprovedRelease && payeeApprovedRelease) _release();
    }

    function approveRefund() external inState(State.Funded) {
        require(msg.sender == payer || msg.sender == payee, "Unauthorized");
        if (msg.sender == payer) payerApprovedRefund = true;
        if (msg.sender == payee) payeeApprovedRefund = true;
        emit RefundApproved(msg.sender);
        if (payerApprovedRefund && payeeApprovedRefund) _refund();
    }

    function raiseDispute() external inState(State.Funded) {
        require(msg.sender == payer || msg.sender == payee, "Unauthorized");
        state = State.Disputed;
        emit DisputeRaised(msg.sender);
    }

    function arbiterRelease() external onlyArbiter inState(State.Disputed) {
        _release();
    }

    function arbiterRefund() external onlyArbiter inState(State.Disputed) {
        _refund();
    }

    function releaseByTimeout() external {
        require(state == State.Funded, "Invalid state");
        require(block.timestamp >= releaseAfter, "Too early");
        _release();
    }

    function refundByTimeout() external {
        require(state == State.Funded, "Invalid state");
        require(block.timestamp >= refundAfter, "Too early");
        _refund();
    }

    function feeAmount() public view returns (uint256) {
        return (amount * feeBps) / 10_000;
    }

    function payoutAmount() public view returns (uint256) {
        return amount - feeAmount();
    }

    function _release() internal nonReentrant {
        state = State.Released;

        uint256 fee = feeAmount();
        uint256 payout = amount - fee;

        if (fee > 0) {
            (bool feeOk,) = payable(feeRecipient).call{value: fee}("");
            require(feeOk, "Fee transfer failed");
        }

        (bool payoutOk,) = payable(payee).call{value: payout}("");
        require(payoutOk, "Transfer failed");

        emit Released(payee, amount, fee, feeRecipient);
    }

    function _refund() internal nonReentrant {
        state = State.Refunded;
        (bool ok,) = payable(payer).call{value: address(this).balance}("");
        require(ok, "Transfer failed");
        emit Refunded(payer, amount);
    }
}
