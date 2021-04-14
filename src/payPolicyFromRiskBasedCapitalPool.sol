pragma solidity ^0.5.0;

import "./IpayPolicyModifiers.sol";
import "./SafeMath.sol";

contract riskBasedCapitalPool is IpayPolicyModifiers {
    using SafeMath for uint;
    
    Quotation internal q2;
    SOTEToken internal tk;
    TokenController internal tc;
    TokenFunctions internal tf;
    Pool2 internal p2;
    PoolData internal pd;
    MCR internal m1;
    Claims public c1;
    TokenData internal td;
    bool internal locked;

    uint internal constant DECIMAL1E18 = uint(10) ** 18;
    
    uint public pumpMo;
    address public pumpAddress;
    // uint internal constant PRICE_STEP = uint(1000) * DECIMAL1E18;

    event Apiresult(address indexed sender, string msg, bytes32 myid);
    event Payout(address indexed to, uint coverId, uint tokens);

    modifier noReentrancy() {
        require(!locked, "Reentrant call.");
        locked = true;
        _;
        locked = false;
    }

    constructor(address _pumpAddress,uint _pumpMo) public {
      pumpAddress = _pumpAddress;
      pumpMo = _pumpMo;
    }

    function () external payable {} //solhint-disable-line

    /**
     * @dev Pays out the sum assured in case a claim is accepted
     * @param coverid Cover Id.
     * @param claimid Claim Id.
     * @return succ true if payout is successful, false otherwise. 
     */ 
    function sendClaimPayout(
        uint coverid,
        uint claimid,
        uint sumAssured,
        address payable coverHolder,
        bytes4 coverCurr
    )
        external
        onlyInternal
        noReentrancy
        returns(bool succ)
    {
        
        uint sa = sumAssured.div(DECIMAL1E18);
        bool check;
        IERC20 erc20 = IERC20(pd.getCurrencyAssetAddress(coverCurr));

        //Payout
        if (coverCurr == "BNB" && address(this).balance >= sumAssured) {
            // check = _transferCurrencyAsset(coverCurr, coverHolder, sumAssured);
            coverHolder.transfer(sumAssured);
            check = true;
        } else if (coverCurr == "DAI" && erc20.balanceOf(address(this)) >= sumAssured) {
            erc20.transfer(coverHolder, sumAssured);
            check = true;
        }
        
        if (check == true) {
            q2.removeSAFromCSA(coverid, sa);
            pd.changeCurrencyAssetVarMin(coverCurr, 
                pd.getCurrencyAssetVarMin(coverCurr).sub(sumAssured));
            emit Payout(coverHolder, coverid, sumAssured);
            succ = true;
        } else {
            c1.setClaimStatus(claimid, 12);
        }
        _triggerExternalLiquidityTrade();
        // p2.internalLiquiditySwap(coverCurr);

        tf.burnStakerLockedToken(coverid, coverCurr, sumAssured);
    }
}
