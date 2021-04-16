<template>
        <!-- Page Wrapper -->
    <div id="wrapper">

       <SideNav/>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                </nav>
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
export default {
    // import * as mykey from '../assets/js/mykey.js'

    name : "MainApp",
    components:{
        SideNav
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