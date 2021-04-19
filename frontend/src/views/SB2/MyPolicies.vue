<template>
  <div class="container-fluid">
    <!-- Modal -->
    <ClaimModal :pID="claim.pid" :title="claim.name" :losses="claim.losses"/>

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 @click="handlClick" class="h3 mb-0 text-gray-800">My Items</h1>
      <div>
        <router-link :to="{ name: 'covers'}"
          class=" d-sm-inline-block btn btn-sm btn-outline-success  mr-3">
          Covered Items
        </router-link>
        <router-link :to="{ name: 'mypolicies'}"
        class=" d-sm-inline-block btn btn-sm btn-outline-success active ">
          My Items
        </router-link>

      </div>
      <router-link :to="{ name: 'mypolicies'}"
        class="d-none d-sm-inline-block btn btn-sm btn-outline-primary shadow-sm">
        <font-awesome-icon
          class="mr-1"
          icon="plug"
          size="1x" >
          </font-awesome-icon>
        Connect Wallet
      </router-link>
    </div>
    <hr>

    <!-- Content Row -->
    <div class="row">
      <section id="Covers" class="container">
        <div class="row ">
            <div v-if="selectedCover" class="col-xs-12 col-sm-6 col-md-5 ">
                <!-- <div class="card" style="width: 18rem;"> -->
                <div class="card mx-auto">
                    <img :src="selectedCover.icon" class="card-img-top img-fluid px-3" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">{{ selectedCover.title }}</h5>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                        <h6>Losses Covered</h6>
                        <hr>
                        <div class="col-12 lossesCovered">

                            <div :key="item.index" v-for="item in selectedCover.losses" class="d-flex justify-content-between border-bottom py-1">
                                <span class="text-gray-800">
                                    {{ item }} {{ item.index }}
                                </span>
                                <span>
                                    <font-awesome-icon class="mr-1 text-primary" icon="check" size="1x" ></font-awesome-icon>
                                </span>
                            </div>
                        </div>
                        <hr>
                        <a href="#" v-show="!selectedCover.owned" class="btn btn-outline-success mr-3">Apply</a>
                        <a href="#" v-show="selectedCover.owned" class="btn btn-sm btn-outline-success" @click="makeClaim(selectedCover.id, selectedCover.title, selectedCover.losses)">File a Claim</a>
                        
                    </div>
                </div>
            </div>
            <div class="mx-auto col-xs-12 col-sm-6 col-md-7">
                <div class="row">
                    <div class="col-lg-6 col-md-12" :key="cover.index" v-for="cover in myCovers" >
                        <coverCard class="" :cover="cover" />
                    </div>
                </div>
            </div>
        </div>
      </section>
    </div>
  </div>
</template>
<script>
import coverCard from "../../components/SB2/coverCard.vue"
import ClaimModal from "../../components/SB2/claimModal.vue"
export default {
  name: "Covers",
  components: {
      coverCard,
      ClaimModal
  },
  inject: [ 'covers' ],
  data() {
    return {
      selectedCover: null,
      myCovers : [],
      claim: {
          pid       : null,
          name      : null,
          losses    : null,
      },
   
    };
  },
  methods: {
    //   Looks up the list of Cover 
    viewCover(id) {
        this.selectedCover = this.getCoverByID(id)
    },

    makeClaim(id, name, losses){
        $('#claimModal').modal('show')
        this.claim.pid = id;
        this.claim.name = name;
        this.claim.losses = this.getCoverByID(id).losses;
        console.log(this.claim.losses)
    }, 

    getCoverByID(id){
        const cvs = this.covers.find((cover) => cover.id === id)
        return cvs;
    }

  },
  mounted() {
    // this.myCovers = 
    this.covers.forEach(element => {
        if( element['owned'] == true ){
          this.myCovers.push(element)

        }
    });
  },
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