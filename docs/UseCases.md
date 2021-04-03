# Use Cases

## Request For Cover
Inputs:
- target savings amount (min: $500, max: $5000)
- period in months (min: 12, max: 36, inc: 6)
- initial deposit (< target)

Outputs:
- Policy Overview (target, period, deposit, premium)

Support Functions:
- Risk Free Return (to calculate savings interest)
- Calculate Risk (risk factor for particular requesting address, age, stake, history, etc)
- Calculate Premium (risk amortization function that amortizes risk vs savings growth over period and determines fixed policy payments)

## Activate Policy
Inputs:
- target savings amount (min: $500, max: $5000)
- period in months (min: 12, max: 36, inc: 6)
- initial deposit (< target)

Outputs:
- success: active policy
- failure: error (e.g. insufficient funds for deposit, declined, etc)

Support Functions:
- Risk Free Return (to calculate savings interest)
- Calculate Risk (risk factor for particular requesting address, age, stake, history, etc)
- Calculate Premium (risk amortization function that amortizes risk vs savings growth over period and determines fixed policy payments)

## Policy Payment
Inputs:
- payment authorization

Outputs:
- success: active policy (update status)
- failure: adjust policy (update status, adjust contributions)

Support Functions:

## Register Claim
Inputs:
- claim amount (< target)
- stake authorization (authorized stake is taken from savings, if savings balance < stake authorize from wallet)

Outputs:
- success: claim registered and assessor assigned (claim status: awaiting proof of loss)
- failure: claim registration error (e.g. invalid claim amount, insufficient stake, etc)

Support Functions:
- Select Assessor (e.g. from FIFO queue based on staked amounts)

## Substantiate Claim
Inputs:
- hash of proof of loss (by claimant, proof of loss provided to assessor through off chain features in product front end)

Outputs:
- claim status update: awaiting approval

Support Functions:

## Verify Claim
Inputs:
- hash of claim details signed by assessor (ZKP-HMAC, must match hash provided by claimant)
- assessment outcome (approve / decline)

Outputs:
- approve: claim stake released, claim amount payout
- declined: claim stake consumed, claim closed
- both: portion of assessor stake locked for period (e.g. 30 days)

Support Functions:
