
// File: @openzeppelin/contracts/utils/math/SafeMath.sol


// OpenZeppelin Contracts (last updated v4.9.0) (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

// File: @openzeppelin/contracts/security/ReentrancyGuard.sol


// OpenZeppelin Contracts (last updated v4.9.0) (security/ReentrancyGuard.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be _NOT_ENTERED
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
     * `nonReentrant` function in the call stack.
     */
    function _reentrancyGuardEntered() internal view returns (bool) {
        return _status == _ENTERED;
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// File: contracts/EmployeeTokenLock_V3.sol


pragma solidity ^0.8.19;




contract EmployeeTokenLock_V3 is ReentrancyGuard{
    address private immutable admin;
    address private immutable token;

    uint256 private lockupIndex = 0;
    uint256 private totalAmount = 0;
    uint256 public unLockTime = 0;

    /**
    * withdarwActiveMode State
    * true Withdraw(s) Activated
    * false Withdraw(s) Not Activated
    */
    bool private _withdrawActiveMode = false;

    uint256 constant VESTING_COUNT = 24;

    mapping( address => uint256[] ) private accountToLockupIndex;
    mapping( uint256 => LockupInfo ) private lockupInfo;

    struct LockupInfo{
        address account;
        uint256 lockuptime;
        uint256 amount;
        uint256 index;
    }

    struct UserLockupResultInfo{
        uint256 timestamp;
        uint256 amount;
        uint256 duration;
        uint256 index;
    }

    struct LockupResultInfo{
        uint256 lockuptime;
        uint256 timestamp;
        uint256 amount;
        uint256 duration;
        uint256 index;
        uint256 amountIndex;
        address account;
    }

    struct LockupRequest{
        address account;
        uint256 amount;
    }

    event setLockupsEvent(address indexed account, uint256 amount);
    event withdrawEvent(address indexed account, uint256 lockupIndex, uint256 amount);
    event withdrawsEvent(address indexed account, uint256 amount);

    constructor(address _admin, address _token) {
        require(address(0) != _admin, "EmployeeTokenLock: ZERO_ADDRESS");
        require(address(0) != _token, "EmployeeTokenLock: ZERO_ADDRESS");

        admin = _admin;
        token = _token;
	}

    modifier onlyAdmin(){
         require(admin == msg.sender, "EmployeeTokenLock: NOT_ADMIN");
        _;
    }

    modifier onlyLock(uint _lockupIndex){
        require(isLockInfo(msg.sender), "EmployeeTokenLock: NOT_LOCKINFO");
        require(isLockIndex(msg.sender, _lockupIndex), "EmployeeTokenLock: NOT_LOCKINDEX");
        _;
    }

    modifier onlyWithdrawActiveMode() {
        require(_withdrawActiveMode == true, "EmployeeTokenLock: NOT_ACTIVATED");
        _;
    }

    function isLockInfo(address _account) internal view returns(bool) {
        if( accountToLockupIndex[_account].length > 0 )
            return true;
        else
            return false;
    }

    function isLockIndex(address _account, uint256 _lockupIndex) internal view returns(bool) {
        if( lockupInfo[_lockupIndex].account == _account )
            return true;
        else
            return false;
    }

    function _getDuration(uint256 _lockupIndex) internal pure returns(uint256 duration){
        return _lockupIndex * 30 days;
    }

    function setAdminApprove() external onlyAdmin(){
        IERC20(token).approve(address(this), type(uint256).max);
    }

    function setUnLockTime(uint256 _unLockTime) external onlyAdmin(){
        require(_unLockTime > 0, "EmployeeTokenLock: ZERO_UNLOCKTIME");
        unLockTime = _unLockTime;
    }

    function setLockups(bytes memory _lockups) external onlyAdmin(){
        (LockupRequest[] memory lockups ) = abi.decode(_lockups, (LockupRequest[]));

        for( uint256 i = 0; i < lockups.length; i++ ){
            require( lockups[i].account != address(0), "EmployeeTokenLock: NOT_ADDRESS");

            uint256 minAmount = 1 ether * VESTING_COUNT;
            require( lockups[i].amount >= minAmount, "EmployeeTokenLock: NOT_AMOUNT");

            IERC20(token).transferFrom(admin, address(this), lockups[i].amount);

            uint256 firstAmount = SafeMath.div(lockups[i].amount, VESTING_COUNT);  
            uint256 firstAmountMod = SafeMath.mod(firstAmount, 1 ether);

            uint256 addFirstAmount = 0;
            if( firstAmountMod >= 0.5 ether ){
                addFirstAmount = 1 ether;
            }

            firstAmount =  SafeMath.add(SafeMath.sub(firstAmount, firstAmountMod), addFirstAmount);       

            uint256 lastAmount = (SafeMath.sub(lockups[i].amount, SafeMath.mul(firstAmount, VESTING_COUNT-1)));
            for( uint j = 0; j < VESTING_COUNT; j++ ){
                uint256 amount;
                if( j == VESTING_COUNT-1 ){
                    amount = lastAmount;
                }else{
                    amount = firstAmount;
                }

                lockupInfo[lockupIndex] = LockupInfo({
                    amount : amount,
                    lockuptime : block.timestamp,
                    account :lockups[i].account,
                    index : j
                });

                accountToLockupIndex[lockups[i].account].push(lockupIndex);
                lockupIndex++;
            }           

            totalAmount += lockups[i].amount;            

            emit setLockupsEvent(lockups[i].account, lockups[i].amount);
        }
    }

    function _removeLockup(address _account, uint256 _lockupIndex) internal {

        LockupInfo memory info = lockupInfo[_lockupIndex];

        IERC20(token).transferFrom(address(this), admin, info.amount);

        delete lockupInfo[_lockupIndex];

        uint256 index = 0;
        for( index; index < accountToLockupIndex[_account].length; index++ ){
            if( accountToLockupIndex[_account][index] == _lockupIndex )
                break;            
        }

        if( accountToLockupIndex[_account].length > 0 ){
            accountToLockupIndex[_account][index] = accountToLockupIndex[_account][accountToLockupIndex[_account].length-1];
            accountToLockupIndex[_account].pop();
        }

        totalAmount -= info.amount;
    }

    function removeLockups(address[] memory _accounts) external onlyAdmin(){    
        for( uint256 i = 0; i < _accounts.length; i++ ){            
            require(isLockInfo(_accounts[i]), "EmployeeTokenLock: NOT_LOCKINFO");

            uint256 lockupCount = accountToLockupIndex[_accounts[i]].length;            
            for( uint256 j = 0; j < lockupCount; j++ ){
                _removeLockup(_accounts[i], accountToLockupIndex[_accounts[i]][0]);
            }
        }
    }

    function getLockupsByAccount(address _account) external view onlyAdmin returns(LockupResultInfo[] memory list){
        if( !isLockInfo(_account) )
            return list;

        LockupResultInfo[] memory infoList = new LockupResultInfo[](accountToLockupIndex[_account].length);

        for( uint256 i = 0; i < accountToLockupIndex[_account].length; i++ ){
            infoList[i].lockuptime = lockupInfo[accountToLockupIndex[_account][i]].lockuptime;
            infoList[i].amount = lockupInfo[accountToLockupIndex[_account][i]].amount;
            infoList[i].amountIndex = lockupInfo[accountToLockupIndex[_account][i]].index;
            infoList[i].index = accountToLockupIndex[_account][i];
            infoList[i].account = lockupInfo[accountToLockupIndex[_account][i]].account;
            infoList[i].timestamp = unLockTime;
            uint256 duration = _getDuration(lockupInfo[accountToLockupIndex[_account][i]].index);
            infoList[i].duration = duration;
        } 

        return infoList;
    }

    function getLockupsByIndex(uint256 _lockupIndex) external view onlyAdmin returns(LockupResultInfo memory info){
        if( lockupInfo[_lockupIndex].amount != 0 ){
            info.amount = lockupInfo[_lockupIndex].amount;
            info.lockuptime = lockupInfo[_lockupIndex].lockuptime;
            info.amountIndex = lockupInfo[_lockupIndex].index;
            info.index = _lockupIndex;
            info.account = lockupInfo[_lockupIndex].account;
            info.timestamp = unLockTime;
            uint256 duration = _getDuration(lockupInfo[_lockupIndex].index);
            info.duration = duration;
        }
    }
    
    function getLockups() external view returns(UserLockupResultInfo[] memory list){
        require(isLockInfo(msg.sender), "EmployeeTokenLock: NOT_LOCKINFO");

        UserLockupResultInfo[] memory infoList = new UserLockupResultInfo[](accountToLockupIndex[msg.sender].length);

        for( uint256 i = 0; i < accountToLockupIndex[msg.sender].length; i++ ){
            uint256 _lockupIndex = accountToLockupIndex[msg.sender][i];
            infoList[i].amount = lockupInfo[_lockupIndex].amount;
            infoList[i].timestamp = unLockTime;
            uint256 duration = _getDuration(lockupInfo[_lockupIndex].index);
            infoList[i].duration = duration;
            infoList[i].index = _lockupIndex;
        }

        return infoList;
    }

    function getBalance(uint256 _lockupIndex) public view onlyLock(_lockupIndex) returns(uint256 amount){
        uint256 curTime = block.timestamp;

        LockupInfo memory info = lockupInfo[_lockupIndex];

        uint256 duration = _getDuration(info.index);
        if( SafeMath.add(unLockTime, duration) <= curTime )
            amount = info.amount;
        else
            amount = 0;
    }

    function withdraw(uint256 _lockupIndex) public onlyLock(_lockupIndex) nonReentrant onlyWithdrawActiveMode returns(uint256 withdrawBalance){
        uint256 balance = getBalance(_lockupIndex);

        require(balance > 0, "EmployeeTokenLock: NOT_AMOUNT");
        require(IERC20(token).transferFrom(address(this), msg.sender, balance), "EmployeeTokenLock: TRANSFER_ERR");

        delete lockupInfo[_lockupIndex];

        uint256 index = 0;
        for( index; index < accountToLockupIndex[msg.sender].length; index++ ){
            if( accountToLockupIndex[msg.sender][index] == _lockupIndex ){
                break;            
            }
        }

        if( accountToLockupIndex[msg.sender].length > 0 ){
            accountToLockupIndex[msg.sender][index] = accountToLockupIndex[msg.sender][accountToLockupIndex[msg.sender].length-1];
            accountToLockupIndex[msg.sender].pop();
        } 

        totalAmount -= balance;
        withdrawBalance = balance;

        emit withdrawEvent(msg.sender, _lockupIndex, balance);
    }

    function withdraws() public nonReentrant onlyWithdrawActiveMode returns(uint256 withdrawsBalance){
        require(isLockInfo(msg.sender), "EmployeeTokenLock: NOT_LOCKINFO");

        uint256 curTime = block.timestamp;
        uint256 withdrawCount;
        uint256 balance;

        for( uint256 i = 0; i < accountToLockupIndex[msg.sender].length; i++ ){
            uint256 _lockupIndex = accountToLockupIndex[msg.sender][i];
            uint256 duration = _getDuration(lockupInfo[_lockupIndex].index);
            if( SafeMath.add(unLockTime, duration) <= curTime ){
                balance += lockupInfo[_lockupIndex].amount;
                withdrawCount++;
            }
        }

        require(balance > 0, "EmployeeTokenLock: NOT_AMOUNT");
        require(IERC20(token).transferFrom(address(this), msg.sender, balance), "EmployeeTokenLock: TRANSFER_ERR");

        for( uint256 k = 0; k < withdrawCount; k++ ){
             for( uint256 i = 0; i < accountToLockupIndex[msg.sender].length; i++ ){
                uint256 _lockupIndex = accountToLockupIndex[msg.sender][i];
                uint256 duration = _getDuration(lockupInfo[_lockupIndex].index);
                if( SafeMath.add(unLockTime, duration) <= curTime ){                        
                    if( accountToLockupIndex[msg.sender].length > 0 ){
                        accountToLockupIndex[msg.sender][i] = accountToLockupIndex[msg.sender][accountToLockupIndex[msg.sender].length-1];
                        accountToLockupIndex[msg.sender].pop();
                    }

                    delete lockupInfo[_lockupIndex];
                    break;
                }
             }
        }      

        totalAmount -= balance;
        withdrawsBalance = balance;

        emit withdrawsEvent(msg.sender, balance);
    }

    /**
    * Activate Withdraw Active Mode
    */
    function enableWithdrawActiveMode() external onlyAdmin {
        _withdrawActiveMode = true;
    }
    
    /**
    * Disable Withdraw Active Mode
    */
    function disableWithdrawActiveMode() external onlyAdmin { 
        _withdrawActiveMode = false;
    }

    /**
    * Get Withdraw Active Mode State
    */
    function getWithdrawActiveMode() external view returns(bool) {
        return _withdrawActiveMode;
    }

    /**
     * Get Admin
     */
    function getAdmin() external view returns(address) {
        return admin;
    }

    /**
     * Get Token
     */
    function getToken() external view returns(address) {
        return token;
    }
}