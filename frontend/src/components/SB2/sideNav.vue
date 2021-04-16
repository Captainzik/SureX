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
            <li class="nav-item active">
                <a class="nav-link" href="#">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Overview</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

             <li class="nav-item">
                <router-link class="nav-link " :to="{ name: 'overview'}">
                    <font-awesome-icon  class="mr-1" icon="tachometer-alt" size="xs"></font-awesome-icon>
                    <span>Overview</span>
                </router-link> 
            </li>

            <li class="nav-item">
                <router-link class="nav-link " :to="{ name: 'swap'}">
                    <font-awesome-icon  class="mr-1" icon="sync-alt" size="xs"></font-awesome-icon>
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
            <router-link class="nav-link " :to="{ name: 'covers'}">
                <font-awesome-icon  class="mr-1" icon="handshake" size="xs"></font-awesome-icon>
                <span>Policies</span>
            </router-link> 
        </li>
       <li class="nav-item">
            <router-link class="nav-link " :to="{ name: 'claim'}">
                <font-awesome-icon  class="mr-1" icon="exclamation" size="xs"></font-awesome-icon>
                <span>Claim</span>
            </router-link> 
        </li>
        <li class="nav-item">
            <router-link class="nav-link " :to="{ name: 'assess'}">
                <font-awesome-icon  class="mr-1" icon="glasses" size="xs"></font-awesome-icon>
                <span>Assess</span>
            </router-link> 
        </li>


            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <!-- <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div> -->

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
    .sidebar .nav-item{
        font-size: larger;
    }
    .bg-gradient-surex{
        background-color: $greenDarkCol;
        background-image: linear-gradient( 220deg , $greenDarkCol 4%, $bluCol 40%,);
        background-size: cover;
    }
</style>