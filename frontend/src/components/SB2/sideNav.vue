<template>
     <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-surex sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3"> 
                    <img src="../../assets/Icons/SureX_Logo.png" alt="{{ appname }}">                     
                </div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <router-link class="nav-link " :to="{ name: 'home'}">
                    <font-awesome-icon  class="mr-3" icon="home" size="1x"></font-awesome-icon>
                    <span>Surex Home</span>
                </router-link>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider"/>

            <!-- Heading -->
            <div class="sidebar-heading">
                Basics
            </div>

             <li class="nav-item">
                <router-link class="nav-link " :to="{ name: 'overview'}">
                    <font-awesome-icon  class="mr-3" icon="tachometer-alt" size="1x"></font-awesome-icon>
                    <span>Overview</span>
                </router-link> 
            </li>

            <li class="nav-item">
                <router-link class="nav-link " :to="{ name: 'swap'}">
                    <font-awesome-icon  class="mr-3" icon="sync-alt" size="1x"></font-awesome-icon>
                    <span>Swap</span>
                </router-link> 
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Covers
            </div>


        <li class="nav-item">
        </li>
        <!-- Nav Item - Utilities Collapse Menu -->
        <li class="nav-item">
            <router-link class="nav-link collapsed" to="#" data-toggle="collapse" data-target="#collapseUtilities"
                aria-expanded="true" aria-controls="collapseUtilities">
                <font-awesome-icon  class="mr-3" icon="handshake" size="1x"></font-awesome-icon>
                <span>Policies</span>
            </router-link> 

            <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <!-- <h6 class="collapse-header">Custom Utilities:</h6> -->
                    <router-link class="collapse-item " :to="{ name: 'covers'}">
                        <!-- <font-awesome-icon  class="mr-3" icon="exclamation" size="1x"></font-awesome-icon> -->
                        <span>All Policies</span>
                    </router-link>
                    <router-link class="collapse-item " :to="{ name: 'mypolicies'}">
                        <!-- <font-awesome-icon  class="mr-3" icon="exclamation" size="1x"></font-awesome-icon> -->
                        <span>My Policies</span>
                    </router-link>
                    
                </div>
            </div>
        </li>

        <li class="nav-item">
            <router-link class="nav-link collapsed" to="#" data-toggle="collapse" data-target="#claimUtilities"
                aria-expanded="true" aria-controls="claimUtilities">
                <font-awesome-icon  class="mr-3" icon="exclamation" size="1x"></font-awesome-icon>
                <span>Claims</span>
            </router-link> 

            <div id="claimUtilities" class="collapse" aria-labelledby="headingUtilities"
                data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <!-- <h6 class="collapse-header">Custom Utilities:</h6> -->
                    <router-link class="collapse-item " :to="{ name: 'claims'}">
                        <!-- <font-awesome-icon  class="mr-3" icon="exclamation" size="1x"></font-awesome-icon> -->
                        <span>Claims</span>
                    </router-link>
                    <router-link class="collapse-item " :to="{ name: 'assess'}">
                        <!-- <font-awesome-icon  class="mr-3" icon="exclamation" size="1x"></font-awesome-icon> -->
                        <span>Assess</span>
                    </router-link>
                    
                </div>
            </div>
        </li>
        
            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle">
                </button>
            </div>

        </ul>
        <!-- End of Sidebar -->

</template>

<script>
export default {
    name : "SideNav",
    data(){
        return{
            appname : "SureX"
        }
    }
}
</script>

<style lang="scss" scoped>
@import "../../assets/variables.scss";    
        
    .bg-gradient-surex{
        background-color: $greenDarkCol;
        background-image: linear-gradient( 220deg , $greenDarkCol 4%, $bluCol 40%,);
        background-size: cover;
    }
</style>