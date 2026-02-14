// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/interfaces/IERC721.sol";

/// @title YSABadge — Soulbound reputation NFT for YSA founders
/// @notice Non-transferable ERC-721. Levels: 1=Organized, 2=Disciplined, 3=CapitalReady, 4=InvestorGrade
contract YSABadge {
    string public constant name = "YSA Badge";
    string public constant symbol = "YSAB";

    address public disciplineContract;
    address public owner;

    uint256 private _nextTokenId = 1;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(address => uint256) public tokenOfFounder; // founder → tokenId
    mapping(uint256 => uint8) public levels;           // tokenId → level

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event BadgeMinted(address indexed founder, uint256 tokenId, uint8 level);
    event BadgeUpgraded(address indexed founder, uint256 tokenId, uint8 newLevel);

    error Soulbound();
    error OnlyDiscipline();
    error OnlyOwner();
    error AlreadyHasBadge();
    error NoBadge();
    error MaxLevel();

    modifier onlyDiscipline() {
        if (msg.sender != disciplineContract) revert OnlyDiscipline();
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setDisciplineContract(address _discipline) external {
        if (msg.sender != owner) revert OnlyOwner();
        disciplineContract = _discipline;
    }

    function mint(address founder, uint8 level) external onlyDiscipline {
        if (tokenOfFounder[founder] != 0) revert AlreadyHasBadge();
        uint256 tokenId = _nextTokenId++;
        _owners[tokenId] = founder;
        _balances[founder] = 1;
        tokenOfFounder[founder] = tokenId;
        levels[tokenId] = level;
        emit Transfer(address(0), founder, tokenId);
        emit BadgeMinted(founder, tokenId, level);
    }

    function upgrade(address founder) external onlyDiscipline {
        uint256 tokenId = tokenOfFounder[founder];
        if (tokenId == 0) revert NoBadge();
        if (levels[tokenId] >= 4) revert MaxLevel();
        levels[tokenId]++;
        emit BadgeUpgraded(founder, tokenId, levels[tokenId]);
    }

    function levelOf(address founder) external view returns (uint8) {
        uint256 tokenId = tokenOfFounder[founder];
        if (tokenId == 0) return 0;
        return levels[tokenId];
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return _balances[_owner];
    }

    function ownerOf(uint256 tokenId) external view returns (address) {
        return _owners[tokenId];
    }

    // --- Soulbound: block all transfers ---
    function transferFrom(address, address, uint256) external pure {
        revert Soulbound();
    }

    function safeTransferFrom(address, address, uint256) external pure {
        revert Soulbound();
    }

    function safeTransferFrom(address, address, uint256, bytes calldata) external pure {
        revert Soulbound();
    }

    function approve(address, uint256) external pure {
        revert Soulbound();
    }

    function setApprovalForAll(address, bool) external pure {
        revert Soulbound();
    }

    function getApproved(uint256) external pure returns (address) {
        return address(0);
    }

    function isApprovedForAll(address, address) external pure returns (bool) {
        return false;
    }

    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return interfaceId == 0x80ac58cd || interfaceId == 0x01ffc9a7; // ERC721 + ERC165
    }
}
