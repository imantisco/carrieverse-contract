
// File: contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

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
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

// File: contracts/TokenLock_V1.sol


pragma solidity ^0.8.13;


contract TokenLock_V1{
    address private admin;
    address private token;

    uint256 private lockupIndex = 0;
    uint256 private totalAmount = 0;
    uint256 private lockupCount = 0;

    mapping( address => uint256[] ) private accountToLockupIndex;
    mapping( uint256 => LockupInfo ) private lockupInfo;

    struct LockupInfo{
        address account;
        uint256 timestamp;
        uint256 amount;
        uint256 duration;
        uint256 index;
    }

    struct LockupResultInfo{
        uint256 timestamp;
        uint256 amount;
        uint256 duration;
        uint256 index;
    }

    struct Lockups{
        address account;
        uint256 amount;
        uint256 duration;
    }

    event setLockupEvent(address, uint256, uint256);
    event setLockupsEvent(address, uint256, uint256);
    event withdrawEvent(address, uint256, uint256);
    event withdrawsEvent(address, uint256);

    constructor(address _admin, address _token) {
        admin = _admin;
        token = _token;

        IERC20(token).approve(address(this), type(uint256).max);
	}

    modifier onlyAdmin(){
         require(admin == msg.sender, "TokenLock: NOT_ADMIN");
        _;
    }

    modifier onlyLock(uint _lockupIndex){
        require(isLockInfo(msg.sender), "TokenLock: NOT_LOCKINFO");
        require(isLockIndex(msg.sender, _lockupIndex), "TokenLock: NOT_LOCKINDEX");

        _;
    }

    function setLockups(bytes memory _lockups) external onlyAdmin(){
        (Lockups[] memory lockups ) = abi.decode(_lockups, (Lockups[]));

        for( uint256 i = 0; i < lockups.length; i++ ){
            IERC20(token).transferFrom(admin, address(this), lockups[i].amount);

            lockupInfo[lockupIndex] = LockupInfo({
            amount : lockups[i].amount,
            timestamp : block.timestamp,
            duration : lockups[i].duration,
            account :lockups[i].account,
            index : lockupIndex   
        });

        accountToLockupIndex[lockups[i].account].push(lockupIndex);

        totalAmount += lockups[i].amount;
        lockupIndex++;
        lockupCount++;

        emit setLockupsEvent(lockups[i].account, lockups[i].amount, lockups[i].duration);
        }
    }

    function setLockup(address _account, uint256 _amount, uint256 _duration) external onlyAdmin(){
        require( _account != address(0), "TokenLock: NOT_ADDRESS");
        require( _amount > 0, "TokenLock: NOT_AMOUNT");
        require( _duration > 0, "TokenLock: NOT_DURATION");

        IERC20(token).transferFrom(admin, address(this), _amount);
        
        lockupInfo[lockupIndex] = LockupInfo({
            amount : _amount,
            timestamp : block.timestamp,
            duration : _duration,
            account : _account,
            index : lockupIndex   
        });

        accountToLockupIndex[_account].push(lockupIndex);

        totalAmount += _amount;
        lockupIndex++;
        lockupCount++;

        emit setLockupEvent(_account, _amount, _duration);
    }

    function removeLockup(address _account, uint256 _lockupIndex) external onlyAdmin(){
        require(isLockInfo(_account), "TokenLock: NOT_LOCKINFO");
        require(isLockIndex(_account, _lockupIndex), "TokenLock: NOT_LOCKINDEX");

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
        lockupCount--;
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

    function getLockupsAdmin() public view onlyAdmin returns(LockupInfo[] memory list){
        LockupInfo[] memory infoList = new LockupInfo[](lockupCount);

        uint256 k;
        for( uint256 i = 0; i < lockupIndex; i++ ){
            if( lockupInfo[i].amount != 0 ){
                infoList[k].amount = lockupInfo[i].amount;
                infoList[k].duration = lockupInfo[i].duration;
                infoList[k].timestamp = lockupInfo[i].timestamp;
                infoList[k].index = lockupInfo[i].index;
                infoList[k].account = lockupInfo[i].account;
                k++;
            }
        }

        return infoList;
    }

    function getLockupAdmin(uint256 _lockupIndex) public view onlyAdmin returns(LockupInfo memory info){
        if( lockupInfo[_lockupIndex].amount != 0 ){
            info.amount = lockupInfo[_lockupIndex].amount;
            info.duration = lockupInfo[_lockupIndex].duration;
            info.timestamp = lockupInfo[_lockupIndex].timestamp;
            info.index = lockupInfo[_lockupIndex].index;
            info.account = lockupInfo[_lockupIndex].account;
        }
    }

    function getBalanceAdmin(uint256 _lockupIndex) public view onlyAdmin returns(uint256 amount){
        uint256 curTime = block.timestamp;

        LockupInfo memory info = lockupInfo[_lockupIndex];

        if( info.timestamp+info.duration <= curTime )
            amount = info.amount;
        else
            amount = 0;
    }

    function getLockups() public view returns(LockupResultInfo[] memory list){
        require(isLockInfo(msg.sender), "TokenLock: NOT_LOCKINFO");

        LockupResultInfo[] memory infoList = new LockupResultInfo[](accountToLockupIndex[msg.sender].length);

        for( uint256 i = 0; i < accountToLockupIndex[msg.sender].length; i++ ){
            infoList[i].amount = lockupInfo[accountToLockupIndex[msg.sender][i]].amount;
            infoList[i].duration = lockupInfo[accountToLockupIndex[msg.sender][i]].duration;
            infoList[i].timestamp = lockupInfo[accountToLockupIndex[msg.sender][i]].timestamp;
            infoList[i].index = accountToLockupIndex[msg.sender][i];
        }   

        return infoList;
    }

    function getBalance(uint256 _lockupIndex) public view onlyLock(_lockupIndex) returns(uint256 amount){
        uint256 curTime = block.timestamp;

        LockupInfo memory info = lockupInfo[_lockupIndex];

        if( info.timestamp+info.duration <= curTime )
            amount = info.amount;
        else
            amount = 0;
    }

    function withdraw(uint256 _lockupIndex) public onlyLock(_lockupIndex) returns(uint256 withdrawBalance){
        uint256 balance = getBalance(_lockupIndex);

        require(balance > 0, "TokenLock: NOT_AMOUNT");
        require(IERC20(token).transferFrom(address(this), msg.sender, balance));

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
        lockupCount--;
        withdrawBalance = balance;

        emit withdrawEvent(msg.sender, _lockupIndex, balance);
    }

    function withdraws() public returns(uint256 withdrawsBalance){
        require(isLockInfo(msg.sender), "TokenLock: NOT_LOCKINFO");

        uint256 curTime = block.timestamp;
        uint256 withdrawCount;
        uint256 balance;

        for( uint256 i = 0; i < accountToLockupIndex[msg.sender].length; i++ ){
            if( lockupInfo[accountToLockupIndex[msg.sender][i]].timestamp+lockupInfo[accountToLockupIndex[msg.sender][i]].duration <= curTime ){
                balance += lockupInfo[accountToLockupIndex[msg.sender][i]].amount;
                withdrawCount++;                
            }
        }

        require(balance > 0, "TokenLock: NOT_AMOUNT");
        require(IERC20(token).transferFrom(address(this), msg.sender, balance));

        for( uint256 k = 0; k < withdrawCount; k++ ){
             for( uint256 i = 0; i < accountToLockupIndex[msg.sender].length; i++ ){
                uint256 checkLockupIndex = accountToLockupIndex[msg.sender][i];                    
                if( lockupInfo[checkLockupIndex].timestamp+lockupInfo[checkLockupIndex].duration <= curTime ){                        
                    if( accountToLockupIndex[msg.sender].length > 0 ){
                        accountToLockupIndex[msg.sender][i] = accountToLockupIndex[msg.sender][accountToLockupIndex[msg.sender].length-1];
                        accountToLockupIndex[msg.sender].pop();
                    }

                    delete lockupInfo[checkLockupIndex];

                    break;
                }
             }
        }      

        totalAmount -= balance;
        lockupCount = lockupCount- withdrawCount;
        withdrawsBalance = balance;

        emit withdrawsEvent(msg.sender, balance);
    }
}