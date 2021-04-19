<template>
        <!-- Page Wrapper -->
    <div id="wrapper">

       <SideNav/>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                
                <topBar :address="'0x454212215fcc223212aa'"/>
                <!-- End of Topbar -->

                <router-view/>
                <!-- Begin Page Content -->
                
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright © SureX 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->
</template>

<script>
import { provide } from '@vue/runtime-core';
import Web3 from 'web3';
window.$ = window.jQuery = require("jquery");
require("../assets/SB2/sb-admin-2.min.js");
import SideNav from "../components/SB2/sideNav.vue"
import topBar from "../components/SB2/topBar.vue"
export default {

    name : "MainApp",
    components:{
        SideNav, topBar
    },
    setup(){
        web3 = null;
        const configureWeb3 = async ()=>{
            if( window.ethereum ){
                web3 = new Web3( window.ethereum )
                await ethereum.enable();
            }else if(window.web3){
                web3 = new Web3(window.web3.currentProvider)
            }
        }
        configureWeb3()
        const address   = "0xC26B013e4E331AEe15e1289C57ff2004092E84eE";
        const abi       = [{"inputs":[{"internalType":"uint256","name":"useOpsRateBIPS","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"accountPolicies","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"availableReserveBalance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"buy","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"buy","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"calculateMinimumMintAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tenderAmount","type":"uint256"}],"name":"calculateMintAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tenderAmount","type":"uint256"}],"name":"calculateRefundAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"targetAmount","type":"uint256"}],"name":"calculateTenderAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_target","type":"uint256"},{"internalType":"uint256","name":"_term","type":"uint256"},{"internalType":"uint256","name":"_deposit","type":"uint256"}],"name":"createPolicy","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"operations","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"opsRateBIPS","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_target","type":"uint256"},{"internalType":"uint256","name":"_term","type":"uint256"},{"internalType":"uint256","name":"_deposit","type":"uint256"}],"name":"requestForCover","outputs":[{"components":[{"internalType":"uint256","name":"target","type":"uint256"},{"internalType":"uint256","name":"term","type":"uint256"},{"internalType":"uint256","name":"deposit","type":"uint256"},{"internalType":"uint256","name":"savingsAnnuity","type":"uint256"},{"internalType":"uint256","name":"initialCoverPremium","type":"uint256"},{"internalType":"uint256","name":"firstInstallment","type":"uint256"}],"internalType":"struct Quotes.CoverQuote","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"reserveBalance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"riskRateBIPS","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tenderAmount","type":"uint256"}],"name":"sell","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"token","outputs":[{"internalType":"contract SRXToken","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]
        const cnr       = new web3.eth.Contract(abi, address)
        const userAddr  = web3.currentProvider.selectedAddress
        provide ( 'contract', cnr );
        provide ( 'web3', web3 );
        provide ( 'userAddr', userAddr );

    },
    data(){
        return{
            
        }
    }
}
</script>

<style lang="scss">
@import "../assets/variables.scss";

body.sidebar-toggled footer.sticky-footer {
  width: 100%;
}
.btn-primary-surex{
    background-color: $bluCol;
    border-color: $bluCol;
}

.btn-success-surex{
    background-color: $greenCol;
    border-color: $greenCol;
}

</style>