<template>
  <div class="container-fluid">
    <PolicyModal ref="policmod"/>
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 @click="handlClick" class="h3 mb-0 text-gray-800">Policies</h1>
      <div>
        <router-link :to="{ name: 'covers'}"
          class="d-none d-sm-inline-block btn btn-sm btn-outline-success active mr-3">
          Covered Items
        </router-link>
        <router-link :to="{ name: 'mypolicies'}"
        class="d-none d-sm-inline-block btn btn-sm btn-outline-success  ">
          My Policies
        </router-link>

      </div>
      <router-link :to="{ name: 'mypolicies'}"
        class="d-none d-sm-inline-block btn btn-sm btn-outline-primary shadow-sm">
        <font-awesome-icon
          class="mr-1"
          icon="plug"
          size="1x">
        </font-awesome-icon>
        Connect Wallet
      </router-link>
    </div>

    <!-- Content Row -->
    <div class="row">
      <section id="Covers" class="container">     
        <div class="row">

          <div class="col-lg-4 col-md-6"
            :key="cover.index"
            v-for="cover in covers">
              <coverCard :cover="cover" />
          </div>
        </div>
      </section>
    </div>
  </div>
</template>
<script>
import coverCard from "../../components/SB2/coverCard.vue"
import PolicyModal from "../../components/SB2/PolicyModal.vue"
export default {
  name: "Covers",
  components: {
    coverCard,
    PolicyModal
  },
  computed:{
      premium(){
          // Calculation of Premiums
          // Parameters include varianles in the data object: configCover, configPeriod, configDepo
          // use this to access the variables eg. this.configCover and return the final result
          let prem = ( Number(this.configCover) + Number(this.configDepo))/this.configPeriod;
          return ( prem > 0) ? Math.round(prem,2) : 0 ;
      },
      savings(){
          // Calculation of Savings
          // Parameters may include varianles in the data object: configCover, configPeriod, configDepo
          // use this to access the variables eg. this.configCover and return the final result
          let savs = ( Number(this.configCover) + Number(this.configDepo) - (this.configCover *.94)/1.005 )
          return ( savs > 0) ? Math.round(savs,2) : 0 ;
      }
  },
  data() {
    return {
      svgBaseDit: "../../assets/SVGs/",
      covers: [
        {
          id      : 1,
          owned   : false,
          title   : "Laptop Cover",
          icon    : require("../../assets/SVGs/undraw_noted_pc9f.svg"),
          description: "Proactively brand reliable imperatives before market positioning innovation.",
          losess      : [
              "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
          ]
        },
        {
          id    : 2,
          owned : false,
          title : "Smartphone Cover",
          icon: require("../../assets/SVGs/undraw_calling_kpbp.svg"),
          description: "Conveniently engineer out-of-the-box communities and front-end human capital.",
          losess      : [
              "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
          ]
        },
        {
          id    : 3,
          owned : false,
          title : "Camera Cover",
          icon: require("../../assets/SVGs/undraw_Camera_re_cnp4.svg"),
          description: "Efficiently engineer seamless portals rather than visionary mindshare.",
          losess      : [
              "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
          ]
        },
        {
          id    : 4,
          owned : false,
          title : "Bicycle Covers",
          icon: require("../../assets/SVGs/undraw_Ride_a_bicycle_2yok.svg"),
          description: "Holisticly implement emerging expertise through empowered mindshare.",
          losess      : [
              "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
          ]
        },
        {
          id    : 5,
          owned : false,
          title : "Game-Controller Cover",
          icon: require("../../assets/SVGs/undraw_gaming_6oy3.svg"),
          description: "Authoritatively maintain standardized applications after premier markets.",
          losess      : [
              "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
          ]
        },
        {
          id    : 6,
          owned : true,
          title: "Printer Cover",
          icon: require("../../assets/SVGs/undraw_printing_invoices_5r4r.svg"),
          description: 'Uniquely engineer flexible internal or "organic" sources without.',
          losess      : [
              "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
          ]
        },
      ],
    };
  },
  methods: {
    viewCover(id) {
      this.$refs.policmod.getPolicyItem(id)
      $('#policyModal').modal('show')
    },

  },
  mounted() {},
};
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