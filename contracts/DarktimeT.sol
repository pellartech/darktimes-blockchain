// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { ERC20Permit } from "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import { ERC20Votes } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

//
//   +-+ +-+ +-+ +-+   +-+ +-+ +-+ +-+ +-+
//   |D| |A| |R| |K|   |T| |I| |M| |E| |S|
//   +-+ +-+ +-+ +-+  +-+ +-+ +-+ +-+ +-+
//
//
//   DARKTIMES 2022
//

contract DARKTIMES is ERC20, ERC20Permit, ERC20Votes {
  constructor() ERC20("DARKTIMES", "TIMES") ERC20Permit("DARKTIMES") {
    _mint(msg.sender, 1_000_000_000 * (10 ** decimals()));
  }

  function decimals() public view virtual override returns (uint8) {
    return 6;
  }

  function _maxSupply() internal view virtual override returns (uint224) {
    return uint224(1_000_000_000 * (10 ** decimals()));
  }

  function _afterTokenTransfer(address from, address to, uint256 amount) internal override(ERC20, ERC20Votes) {
    super._afterTokenTransfer(from, to, amount);
  }

  function _mint(address to, uint256 amount) internal override(ERC20, ERC20Votes) {
    super._mint(to, amount);
  }

  function _burn(address account, uint256 amount) internal override(ERC20, ERC20Votes) {
    super._burn(account, amount);
  }
}
