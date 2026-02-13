// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFA {
    string public name = "NFA Agents";
    string public symbol = "NFA";
    
    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balanceOf;
    
    address public owner;
    bool public mintEnabled;
    uint256 public constant MAX_SUPPLY = 7777;
    uint256 public totalMinted;
    mapping(address => bool) public hasMinted;
    
    constructor() {
        owner = msg.sender;
    }
    
    function enableMint() external {
        require(msg.sender == owner);
        mintEnabled = true;
    }
    
    function mint() external {
        require(mintEnabled);
        require(!hasMinted[msg.sender]);
        require(totalMinted < MAX_SUPPLY);
        
        hasMinted[msg.sender] = true;
        ownerOf[totalMinted] = msg.sender;
        balanceOf[msg.sender]++;
        totalMinted++;
    }
    
    function withdraw() external {
        require(msg.sender == owner);
        payable(owner).transfer(address(this).balance);
    }
    
    function transferFrom(address from, address to, uint256 tokenId) external {
        require(ownerOf[tokenId] == from);
        require(msg.sender == from);
        ownerOf[tokenId] = to;
        balanceOf[from]--;
        balanceOf[to]++;
    }
}
