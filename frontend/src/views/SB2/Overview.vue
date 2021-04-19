<template>
    <div class="container-fluid">                    
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 @click="handlClick" class="h3 mb-0 text-gray-800">Overview</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-outline-primary btn-outline-success-surex shadow-sm">
                <font-awesome-icon  class="mr-1" icon="plug" size="1x"></font-awesome-icon>
                 Connect Wallet
            </a>
        </div>
<hr>
        <!-- Content Row -->
        <div class="row">
            <div class="container">
                <main>
                    <ul class="gradient-list">
                        <li :key="point" v-for="point in points">{{ point }}</li>
                    </ul>
                </main>
            </div>
        </div>

    </div>
</template>
<script>
export default {
    name: "Overview",
    setup() {
        
    },
    data(){
        return{
            points:[
                "Built on the Binance Smart Chain network.",
                "Users can buy insurance for items such as technological devices (phones, cameras, computers etc) – stakers split profit and yields as a reward.",
                "Purchase coverage using Stablecoins.",
                "Policy funds are invested on platforms such as Aave, Curve, Balancer, etc.",
                "Policyholders can place claims easily on the SureX Platform.",
                "Tribunal claims mechanism to ensure every claim is assessed fairly.",
                "SRX tokens govern the platform"
            ]
        }
    }
}
</script>
<style lang="scss">
@import "../../assets/variables.scss";

/* box-shadow */
%boxshadow {
  box-shadow: 0.25rem 0.25rem 0.6rem rgba(0,0,0,0.05), 0 0.5rem 1.125rem rgba(75,0,0,0.05);
}



main {
  display: block;
  margin: 0 auto;
  max-width: 40rem;
  padding: 1rem;
}


ul.gradient-list {
  counter-reset: gradient-counter;
  list-style: none;
  margin: 1.75rem 0;
  padding-left: 1rem;
  > li {
    background: white;
    border-radius: 0 0.5rem 0.5rem 0.5rem;
    @extend %boxshadow;
    counter-increment: gradient-counter;
    margin-top: 1rem;
    min-height: 3rem;
    padding: 1rem 1rem 1rem 3rem;
    position: relative;
    &::before,
    &::after {
      background: linear-gradient(135deg, $greenCol 0%,$bluCol 100%);
      border-radius: 1rem 1rem 0 1rem;
      content: '';
      height: 3rem;
      left: -1rem;
      overflow: hidden;
      position: absolute;
      top: -1rem;
      width: 3rem;
    }
    &::before {
      align-items: flex-end;
      @extend %boxshadow;
      content: counter(gradient-counter);
      color: $gray-100;
      display: flex;
      font: 900 1.5em/1 'Montserrat';
      justify-content: flex-end;
      padding: 0.125em 0.25em;
      z-index: 1;
    }
    background: linear-gradient(135deg, rgba(#fff, 0.2) 0%,rgba($greenCol,  0.2) 100%);

    + li {
      margin-top: 2rem;
    }
  }
}
</style>