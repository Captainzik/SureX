<template>
    <div class="container-fluid">                    
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Swap Tokens</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-outline-primary btn-outline-success-surex shadow-sm">
                <font-awesome-icon  class="mr-1" icon="plug" size="1x"></font-awesome-icon>
                 Connect Wallet
            </a>
        </div>
        <hr>
        <!-- Content Row -->
        <div class="row">
            <div class="container">
                <div class="row">

                    <!-- RSV TOKEN  ENTRY-->
                    <div class="col-md-5 col-xs-12 toknWrapper rsvToknWrapper">
                        <div class="py-2 px-3 border-bottom-primary" :class="{ 'shadow' :rsvFocus, 'shadow-sm' :ntvFocus }">
                            <span class="w-100 align-self-center action text-secondary">
                                <!-- Toggle text based on the field focused on -->
                                <!-- Helps in identify what is being bought -->
                                {{ (!ntvFocus && rsvFocus) ? "For" : "Your Get" }}
                            </span>
                            <input @focus="focusedTkn" @keyup="updateVals" class="bg-light w-100" type="number" v-model="rsvToken" name="rsvToknVal" placeholder="0"/>
                            <span class="d-block w-100 text-center pl-3">BNB</span>
                        </div>
                    </div>

                    <!-- SWAP ICON  -->
                    <div class="col-md-2 col-xs-12 rsvToknWrapper d-flex flex-column justify-content-center align-items-center my-3">
                        <font-awesome-icon  class="mr-1 text-secondary" icon="exchange-alt" size="3x"></font-awesome-icon>
                    </div>

                    <!-- NATIVE TOKEN ENTRY-->
                    <div class="col-md-5 col-xs-12 toknWrapper rsvToknWrapper ">
                        <div class="py-2 px-3 border-bottom-success" :class="{ 'shadow' :ntvFocus, 'shadow-sm' : rsvFocus }">
                            <span class="w-100 align-self-center action text-secondary">
                                <!-- Toggle text based on the field focused on -->
                                <!-- Helps in identify what is being bought -->
                                {{ (ntvFocus && !rsvFocus) ? "For" : "Your Get" }} :
                            </span>
                            <input @focus="focusedTkn" @keyup="updateVals" class="bg-light w-100" v-model="ntvToken" type="number" name="ntvToknVal" placeholder="0"/>
                            <span class="d-block w-100 text-center pl-3">SRX</span>
                        </div>
                    </div>
                </div>


                <!-- SWAP DETAILs -->
                <div class="row swapDetailsWrapper">
                    <div class="col-lg-7 col-md-8 col-sm-10 col-xs-12 shadow mx-auto mt-5 py-3 mx-3">
                        <div class="row py-2 border-bottom swap-detail-item">
                            <div class="col-6 font-weight-light">
                                <span>1 BNB</span> <sub class="font-weight-light">(BNB/SRX) </sub>
                            </div>
                            <div class="col-6 text-right">
                                ~ {{ oneRSV.toFixed(3) }}&nbsp;<sup class="font-weight-lighter">SRX</sup>
                            </div>
                        </div>
                        <div class="row py-2 border-bottom swap-detail-item">
                            <div class="col-6 font-weight-light">
                                <span>1 SRX</span>&nbsp;<sub>(SRX/BNB) </sub>
                            </div>
                            <div class="col-6 text-right">
                                ~ {{ Number(oneNTV).toFixed(3) }} <sup class="font-weight-lighter">BNB</sup>
                            </div>
                        </div>
                        <div class="row py-2 border-bottom swap-detail-item">
                            <div class="col-6 font-weight-light">
                                <span>Min. Txn</span>&nbsp;<sub>(BNB/SRX) </sub>
                            </div>
                            <div class="col-6 text-right">
                                {{ minTxn }}&nbsp;<sup class="font-weight-lighter">BNB</sup>
                            </div>
                        </div>
                        <div class="row py-2 swap-detail-item ">
                            <button @click="triggerContractTxn" 
                                class="mx-auto mt-2 btn  col-md-6 col-xs-12"
                                :class="{ 'btn-outline-danger' : (!rsvFocus && !ntvFocus), 'btn-outline-primary' :rsvFocus, 'btn-outline-success' :  ntvFocus }">
                            Swap</button>
                        </div>
                        
                    </div>
                </div>
            </div>

        </div>

    </div>
</template>
<script>
export default {
    name        : "Swap",
    inject  : ['contract', 'web3', 'userAddr'],
    data(){
        return{
            rsvToken        : null,
            ntvToken        : null,
            oneRSV          : 2.54,
            oneNTV          : 2.54,
            minTxn          : 0.2,
            rsvFocus        : false,
            ntvFocus        : false,
        }
    },
    computed:{
        srxbnb(){
            return Number(1/Number(this.bnbsrx)).toFixed(5)
        },
    },
    methods:{
        /**
         * Helps in figuring out which field is being edited 
         */
        focusedTkn(e){
            if(e.target.name=="rsvToknVal"){ this.rsvFocus = true; this.ntvFocus = false }
            if(e.target.name=="ntvToknVal"){ this.rsvFocus = false; this.ntvFocus = true }
        },

        /**
         * Update values in the token fields
         * Depends ont focusedTkn()
         */
        async updateVals(e){

            if( this.rsvFocus && Number(this.rsvToken) > 0 ){
                this.ntvToken = await this.calculateMintAmount(this.rsvToken)
                console.log("TO NTV");
            }
            else if( this.ntvFocus && Number(this.ntvToken) > 0){
                console.log("TO RSV");
                this.rsvToken = await this.calculateTenderAmount(this.ntvToken)
            }
            else{
                this.rsvToken = 0;
                this.ntvToken = 0;
            }
        },

        /**
         * Interact with the contract 
         */
        async triggerContractTxn(){
            // Prevent swapping null tokens 
            if( Number(this.ntvToken) == 0 || Number(this.rsvToken) == 0 ){
                alert(`Cannot swap between ${this.ntvToken} BNB and ${this.rsvToken} SRX`)
                return;
            }
            if (this.rsvFocus) this.getNTVtkn(this.rsvToken)
            if (this.ntvFocus) this.getRSVtkn(this.ntvToken)
        },

        async calculateMintAmount(_rsvTokens){
            let ntvWei = await this.contract.methods.calculateMintAmount(this.Power18(_rsvTokens)).call()
            return this._18Root(ntvWei)
        },

        async calculateTenderAmount(_ntvTokens){
            let rsvWei = await this.contract.methods.calculateTenderAmount(this.Power18(_ntvTokens)).call()
            return this._18Root(rsvWei)
            
        },

        async calculateMinimumMintAmount(  ){
            let rsvWei = await this.contract.methods.calculateMinimumMintAmount().call()
            return this._18Root(rsvWei)
        },

        /**
         * Buys SRX in echange of RSV tokens
         */
        async getNTVtkn( ntvVal ){
            let refVar = this
            this.contract.methods.buy().send({
                from  : this.userAddr,
                value : this.Power18(ntvVal)
            })
            .on('receipt', ( receipt )=>{ 
                console.log(receipt.events);
                if( receipt.status ){ refVar.showSuccessMsg(`Swapped ${refVar.ntvVal} BNB for SRX successfully`) }
            } )
            .on('error', (err) =>{ refVar.showErrorMsg(err.message) } )
        },

        /**
         * Get RSV in exchange for NTV
         */
        async getRSVtkn(_srxVal){
            let refVar = this
            this.contract.methods.sell( _srxVal ).send({
                from  : this.userAddr,
                value : this.Power18(_srxVal)
            })
            .on('receipt', ( receipt )=>{ 
                console.log(receipt.events);
                if( receipt.status ){ refVar.showSuccessMsg(`Swapped ${_srxVal} SRX for BNB successfully`) }
            } )
            .on('error', (err) =>{ refVar.showErrorMsg(err.message) } )
        },

        showErrorMsg( err ){
            alert( err )
        },

        showSuccessMsg( msg ){
            alert( msg )
        },

        Power18(val){ return String(val * 10**18)  },
        _18Root(val){ return val/(10**18) }

    },
    async mounted(){
        this.oneRSV = await this.calculateMintAmount(1)
        this.oneNTV = await this.calculateTenderAmount(1)
        this.minTxn = await this.calculateMinimumMintAmount()
    }
    

}
</script>
<style lang="scss">
    @import "../../assets/variables.scss";
    .toknWrapper{
        .border-bottom-primary{
            border-color: $bluCol !important;
        }
        .border-bottom-success{
            border-color: $greenCol !important;
        }
        select{
            border: none;
            &:focus{
                outline: none;
                border: none;
            }
        }
        &::hover{
            outline: $greenCol;
            
        }
        input{
            text-align: center;
            border: none;
            font-size: xx-large;
            padding-top:0;
            padding-bottom:0;
            color: $gray-700;
            
            &::-webkit-outer-spin-button,
                &::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            /* Firefox */
            &[type=number] {
                -moz-appearance: textfield;
            }
            
            &:focus{
                outline: none;
            }
            &::placeholder{
                text-indent: 1rem;
                color: $gray-500;
            }    
        }

    }
    .swapDetailsWrapper{
        .swap-detail-item{
            font-size: x-large;
        }
        .btn-outline-info{
            border-color: $orangish  !important;
            color: $orangish;
            &:hover{
                background-color: $orangish;
            }
            &:focus{
                background-color: $reddish;
            }
        }

    }
</style>