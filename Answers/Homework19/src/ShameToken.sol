// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "../lib/openzeppelin-contractscontracts/token/ERC20/ERC20.sol";


contract shameToken is ERC20 {
    address immutable admin;

    /**
     * @dev Sets the values for {name} and {symbol}. 
     * @dev Sets admin to msg.sender.
     */
    constructor() ERC20("Shame", "SHM"){
        admin = msg.sender;
    }


    /**
     * @dev Returns the number of decimals used to get its user representation.
     * In this case decimals is 0. 
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    /**
     * @dev non standard {IERC20-transfer}.
     * 
     *
     * Requirements:
     *
     * - `amount` must be 0 if called by admin.
     * - mints 1 token to `to` address when called by admin
     * - mints 1 token to msg.sender if not called by admin
     * - if called by non admin regardless of amount 1 token is minted to msg.sender
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        if (msg.sender == admin) {
            require(amount == 1, "Amount must be 1");
            _mint(to, 1);
            return true;
        } else {
            _mint(msg.sender, 1);
            return true;
        }
    }

    /**
     * @dev non standard {IERC20-approve}.
     *
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must be admin
     * - `amount` must be 1
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        require(spender == admin, "Spender must be admin");
        require(amount == 1, "Amount must be 1");
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

        /**
     * @dev non standard {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     * - `from` address increases by 1
     * - `to` addresss is unchanged
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _burn(from, amount);
        return true;
    }
}