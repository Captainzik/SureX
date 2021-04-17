<template>
  <div class="container-fluid">
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 @click="handlClick" class="h3 mb-0 text-gray-800">Policies</h1>
      <div>
        <router-link :to="{ name: 'mypolicies'}"
          class="d-none d-sm-inline-block btn btn-sm btn-outline-success active mr-3">
          <font-awesome-icon
            class="mr-1"
            icon="plug"
            size="1x"
          ></font-awesome-icon>
          Covers
        </router-link>
        <router-link :to="{ name: 'mypolicies'}"
        class="d-none d-sm-inline-block btn btn-sm btn-outline-primary btn-outline-success-surex shadow-sm">
        <font-awesome-icon
            class="mr-1"
            icon="plug"
            size="1x"
          ></font-awesome-icon>
          My Policies
        </router-link>

      </div>
      <router-link :to="{ name: 'mypolicies'}"
        class="d-none d-sm-inline-block btn btn-sm btn-outline-primary shadow-sm">
        <font-awesome-icon
          class="mr-1"
          icon="plug"
          size="1x"
        ></font-awesome-icon>
        Connect Wallet
      </router-link>
    </div>

    <!-- Content Row -->
    <div class="row">
      <section id="Covers" class="container">
          
      </section>
    </div>
  </div>
</template>

<script>
export default {
    name: "Policy",
    data(){
        return{
            policy:{
                id            : 1,
                owned         : false,
                title         : "Laptop Policy",
                icon          : require("../../assets/SVGs/undraw_noted_pc9f.svg"),
                description   :  "Proactively brand reliable imperatives before market positioning innovation.",
            }
        }
    }
            
        
}
</script>

<style lang="scss">
@import "../../assets/variables.scss";

.coverCard {
  .coverDescription {
    color: $gray-800;
  }
  .coverLink {
    color: rgba($greenDarkCol, 0.9);
    text-decoration: none;
    cursor: pointer;
    widows: 100%;

    &:hover {
      color: $greenDarkCol;
    }
  }
  .coverTitle {
    color: $reddish;
  }
}
</style>