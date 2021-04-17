<template>
  <div class="container-fluid">
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 @click="handlClick" class="h3 mb-0 text-gray-800">Policies</h1>
      <a
        href="#"
        class="d-none d-sm-inline-block btn btn-sm btn-outline-primary btn-outline-success-surex shadow-sm"
      >
        <font-awesome-icon
          class="mr-1"
          icon="plug"
          size="1x"
        ></font-awesome-icon>
        Connect Wallet
      </a>
    </div>

    <!-- Content Row -->
    <div class="row">
      <section id="Covers" class="container">
          


        <div class="row">

          <div
            class="col-lg-4 col-md-6"
            :key="cover.index"
            v-for="cover in covers"
          >
            <div class="coverCard card shadow mb-4">
              <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold coverTitle">
                  {{ cover.title }}
                </h6>
              </div>
              <div class="card-body">
                <div class="text-center imgWrapper">
                  <img
                    class="img-fluid px-3 px-sm-4 mt-3 mb-4"
                    style="width: 25rem"
                    :src="cover.icon"
                    :alt="cover.title"
                  />
                </div>
                <p class="coverDescription">{{ cover.description }}</p>
                <a class="coverLink" @click="viewPolicy"
                  >Click to view policy</a
                >
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>
<script>
import BuyPolicy from "../../components/SB2/BuyPolicy";

export default {
  name: "Covers",
  components: {
  },
  data() {
    return {
      svgBaseDit: "../../assets/SVGs/",
      covers: [
        {
          title: "Laptop Policy",
          icon: require("../../assets/SVGs/undraw_noted_pc9f.svg"),
          description:
            "Proactively brand reliable imperatives before market positioning innovation.",
        },
        {
          title: "Smartphone Policy",
          icon: require("../../assets/SVGs/undraw_calling_kpbp.svg"),
          description:
            "Conveniently engineer out-of-the-box communities and front-end human capital.",
        },
        {
          title: "Camera Policy",
          icon: require("../../assets/SVGs/undraw_Camera_re_cnp4.svg"),
          description:
            "Efficiently engineer seamless portals rather than visionary mindshare.",
        },
        {
          title: "Bicycle Covers",
          icon: require("../../assets/SVGs/undraw_Ride_a_bicycle_2yok.svg"),
          description:
            "Holisticly implement emerging expertise through empowered mindshare.",
        },
        {
          title: "Game-Controller Policy",
          icon: require("../../assets/SVGs/undraw_gaming_6oy3.svg"),
          description:
            "Authoritatively maintain standardized applications after premier markets.",
        },
        {
          title: "Printer Policy",
          icon: require("../../assets/SVGs/undraw_printing_invoices_5r4r.svg"),
          description:
            'Uniquely engineer flexible internal or "organic" sources without.',
        },
      ],
    };
  },
  methods: {
    viewPolicy(e) {
      e.preventDefault();

    },

  },
  mounted() {},
};
</script>
<style lang="scss">
@import "../../assets/variables.scss";
// @import "../../assets/vueformwizard/vue-form-wizard.min.css";

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