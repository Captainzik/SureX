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
import { ref } from 'vue';
window.$ = window.jQuery = require("jquery");
require("../assets/SB2/sb-admin-2.min.js");
import SideNav from "../components/SB2/sideNav.vue"
import topBar from "../components/SB2/topBar.vue"
export default {
    // import * as mykey from '../assets/js/mykey.js'

    name : "MainApp",
    components:{
        SideNav, topBar
    },
    setup() {
        const rView = ref(null)
        const handlClick = (e) => { 
            console.log( rView.value.name )
        }
        return{ rView, handlClick }
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