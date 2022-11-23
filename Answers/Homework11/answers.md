# Homework 9
## Volcano NFT

We now want to create an NFT.
We will use the Open Zeppelin libraries to help with this.

1. Create a new project in the IDE of you choice called NFTProject
2. Create a VolcanoNFT contract this should inherit from any [ERC721](https://docs.openzeppelin.com/contracts/2.x/erc721) implementation from the Open Zeppelin standard [libraries](https://docs.openzeppelin.com/contracts/2.x/api/token/erc721) 

```js 
// forge install OpenZeppelin/openzeppelin-contracts
// Remember to update remappings.txt
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
```
3. Give your NFT a name and a symbol.
```js
contract VolcanoNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("VolcanoNFT", "VCN") {

    }

    function mint() public returns (uint256) {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _mint(msg.sender, newItemId);
    return newItemId;
    }
   
}
```

4. Write unit tests to check that you can
	1. Mint new NFTs
	2. Transfer an NFT
```js
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTTest is Test {
    VolcanoNFT public nft;
    address alice = address(1);
    address bob = address(2);
    uint256 tokenId;

    function setUp() public {
        nft = new VolcanoNFT();
    }

    function testMint() public {
        vm.startPrank(alice);
        tokenId = nft.mint();
        assertEq(tokenId, 1);
        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.balanceOf(alice), 1);
        vm.stopPrank();

        vm.startPrank(bob);
        tokenId = nft.mint();
        assertEq(tokenId, 2);
        assertEq(nft.ownerOf(2), bob);
        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.balanceOf(alice), 1);
        assertEq(nft.balanceOf(bob), 1);
        vm.stopPrank();
    }

    function testTransfer() public {
        vm.startPrank(alice);
        tokenId = nft.mint();
        nft.transferFrom(alice, bob, tokenId);
        assertEq(nft.ownerOf(tokenId), bob);
        assertEq(nft.balanceOf(alice), 0);
        assertEq(nft.balanceOf(bob), 1);
        vm.stopPrank();
    }
}
```
5. Deploy your contract to Goerli and send some NFTs to your colleagues.

```
//Verify is optional but useful

forge create --rpc-url <your_rpc_url> \
    --private-key <your_private_key> src/VolcanoNFT.sol:VolcanoNFT \
    --etherscan-api-key <your_etherscan_api_key> \
    --verify
```


