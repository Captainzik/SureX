<template>
    <div class="container-fluid">                    
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 @click="handlClick" class="h3 mb-0 text-gray-800">Swap Tokens</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-outline-primary btn-outline-success-surex shadow-sm">
                <font-awesome-icon  class="mr-1" icon="plug" size="1x"></font-awesome-icon>
                 Connect Wallet
            </a>
        </div>

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
                                ~ {{ bnbsrx }}&nbsp;<sup class="font-weight-lighter">SRX</sup>
                            </div>
                        </div>
                        <div class="row py-2 border-bottom swap-detail-item">
                            <div class="col-6 font-weight-light">
                                <span>1 SRX</span>&nbsp;<sub>(SRX/BNB) </sub>
                            </div>
                            <div class="col-6 text-right">
                                ~ {{ srxbnb }} <sup class="font-weight-lighter">BNB</sup>
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
    name: "Swap",
    setup() {
        
    },
    data(){
        return{
            rsvToken    : null,
            ntvToken    : null,
            bnbsrx      : 2.54,
            minTxn      : 0.2,
            rsvFocus    : false,
            ntvFocus    : false,
        }
    },
    computed:{
        srxbnb(){
            return Number(1/Number(this.bnbsrx)).toFixed(5)
        }
    },
    methods:{
        // Helps in figuring out which field is being edited 
        focusedTkn(e){
            if(e.target.name=="rsvToknVal"){ this.rsvFocus = true; this.ntvFocus = false }
            if(e.target.name=="ntvToknVal"){ this.rsvFocus = false; this.ntvFocus = true }
        },

        // Update values in the token fields
        // Depends ont focusedTkn()
        updateVals(e){
            if( this.rsvFocus ){
                this.ntvToken =  this.rsvToken * this.bnbsrx
            }
            if( this.ntvFocus ){
                this.rsvToken =  this.ntvToken * this.srxbnb
            }
        },

        // Interact with the contract
        triggerContractTxn(){
            // Prevent swapping null tokens 
            if( Number(this.ntvToken) == 0 || Number(this.rsvToken) == 0 ){
                alert(`Cannot swap between ${this.ntvToken} BNB and ${this.rsvToken} SRX`)
                return;
            }

            // WEB3 CODE GOES HERE


            
        }

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