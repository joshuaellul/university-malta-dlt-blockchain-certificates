// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "openzeppelin/contracts/token/ERC721/ERC721.sol";
import "openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "openzeppelin/contracts/utils/Counters.sol";
import "openzeppelin/contracts/access/Ownable.sol";

contract UMCDLTCerts is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;    

    constructor() ERC721("University of Malta, Centre for DLT Certificates", "UMCDLTCert") {
    }

    modifier isBeingMinted(address sender) {
        require(sender == address(0), "You cannot transfer the token!");
        _;
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public override isBeingMinted(_from) {        
        ERC721.safeTransferFrom(_from, _to, _tokenId, data);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public override isBeingMinted(_from) {
        ERC721.safeTransferFrom(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public override isBeingMinted(_from) {
        ERC721.transferFrom(_from, _to, _tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function xxx(address assignedTo, string memory tokenUri) public onlyOwner {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(assignedTo, newItemId);
        _setTokenURI(newItemId, tokenUri);
    }
}
