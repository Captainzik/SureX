<template>
    <!-- Modal -->
    <div class="modal fade" id="policyModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="policyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-primary" id="staticBackdropLabel"> {{ coverItem.title }} </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div v-show="curStep == 1" class="row">
                    <div class="col-md-7 col-sm-12 border-right">
                          <img :src="coverItem.icon" class="card-img-top img-fluid" alt="...">
                          <p class="card-text text-justify">{{ coverItem.description }}</p>                        
                    </div>
                    <div class="col-md-5 col-sm-12">
                      <h4>Losses Covered</h4>
                      <hr>
                        <div :key="loss.index" v-for="loss in coverItem.losses" class="d-flex justify-content-between border-bottom py-2">
                            <span class="text-gray-800">
                                {{ loss }}
                            </span>
                            <span>
                                <font-awesome-icon class="mr-1 text-primary" icon="check" size="1x" ></font-awesome-icon>
                            </span>
                        </div>
                    </div>                  
                </div>
                <div v-show="curStep == 2" class="row">
                    <div class="col-md-7 col-sm-12 border-right">
                        <div class=" ">
                            <div class="2-100 TryConfigWrapper d-flex flex-column justify-content-center px-4">
                              <div class="">
                                <p class="DescriptionsText text-center">How much cover do you need?</p>
                                <RangeSlider @mouseup="monitorVal($event,1)" class="mb-3" :max="2000" :min="1" :units="'SRX'" :pre="true"/>
                                
                                <p class="DescriptionsText text-center">Over what period do you need it?</p>
                                <RangeSlider @mouseup="monitorVal($event,2)" class="mb-3" :max="72" :min="1" :units="'Months'" :pre="false"/>

                                <p class="DescriptionsText text-center">What is your initial deposit(optional)??</p>
                                <RangeSlider @mouseup="monitorVal($event,3)" class="mb-3" :max="100" :min="1" :units="'SRX'" :pre="true"/>
                            </div>

                          </div>
                      </div>                     
                    </div>
                    <div class="col-md-5 col-sm-12">
                        <h4 class="quotation">Quote</h4>
                        <div style="padding-top:-1em" class="h-100 d-flex flex-column justify-content-start px-3 ">
                              <div class=" d-flex flex-column py-0">
                                  <div class="paramRow d-flex justify-content-between py-3">
                                    <span>Savings target&nbsp;:</span>
                                    <span>SRX {{ configCover }} </span>
                                  </div>
                                  <div class="paramRow d-flex justify-content-between py-3">
                                    <span>Over a period of&nbsp;:</span>
                                    <span> {{ configPeriod }} Months</span>
                                  </div>
                                  <div class="paramRow d-flex justify-content-between py-3">
                                    <span> With an initial deposit of&nbsp;:</span>
                                    <span>SRX {{ configDepo }}</span>
                                  </div>
                              </div>
                                <div class="row border-bottom">
                                </div>
                              <div class=" d-flex flex-column ">
                                  <div class="paramRow d-flex justify-content-between py-2">
                                    <span><strong> Your premium will be&nbsp;:</strong></span>
                                    <span><strong>&nbsp;SRX{{ premium }}</strong></span>
                                  </div>
                                  <div class="paramRow d-flex justify-content-between py-2">
                                    <span>You will <strong>save</strong> at least:&nbsp;:</span>
                                    <span>&nbsp;SRX{{ savings }}</span>
                                  </div>
                                  <div class="btn btn-success my-2"> Pay {{ premium }}&nbsp;SRX</div>
                              </div>
                        </div>

                    </div>
                </div>
        
            </div>
            <div class="modal-footer">
              <div class="d-flex flex-row justify-content-center align-content-center mx-auto">
                  <div class="">
                      <button type="button" class="btn btn-sm btn-outline-success mx-2" @click="(curStep > 1) ? curStep-- : 1">
                          <font-awesome-icon class="mr-1 text-success" icon="arrow-left" size="1x" ></font-awesome-icon>
                          <span class="mx-2">Prev</span>
                      </button>
                      <span class="text-center mx-4">
                        {{ curStep }} of {{ allSteps }}
                      </span>
                      <button type="button" class="btn btn-sm btn-outline-success mx-2" @click="(curStep <2) ? curStep++ : 1">
                          <span class="mx-2">Next</span>
                          <font-awesome-icon class="mr-1 text-success" icon="arrow-right" size="1x" ></font-awesome-icon>
                      </button>
                  </div>
              </div>
                <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Cancel</button>
            </div>
            </div>
        </div>
    </div>
</template>

<script>
import RangeSlider from "../RangeSlider";
export default {
    name: "PolicyModal",
    components : {
      RangeSlider,
      
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
    data(){
        return{
            curStep : 1,
            allSteps : 2,
            configCover   : 0,
            configPeriod  : 0,
            configDepo    : 0,
            coverItem:{

            },
            coveredItems: [
              {
                id      : 1,
                owned   : false,
                title   : "Laptop Policy",
                icon    : require("../../assets/SVGs/undraw_noted_pc9f.svg"),
                description: "Proactively brand reliable imperatives before market positioning innovation.",
                losses      : [
                    "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
                ]
              },
              {
                id    : 2,
                owned : false,
                title : "Smartphone Policy",
                icon: require("../../assets/SVGs/undraw_calling_kpbp.svg"),
                description: "Conveniently engineer out-of-the-box communities and front-end human capital.",
                losses      : [
                    "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
                ]
              },
              {
                id    : 3,
                owned : false,
                title : "Camera Policy",
                icon: require("../../assets/SVGs/undraw_Camera_re_cnp4.svg"),
                description: "Efficiently engineer seamless portals rather than visionary mindshare.",
                losses      : [
                    "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
                ]
              },
              {
                id    : 4,
                owned : false,
                title : "Bicycle Covers",
                icon: require("../../assets/SVGs/undraw_Ride_a_bicycle_2yok.svg"),
                description: "Holisticly implement emerging expertise through empowered mindshare.",
                losses      : [
                    "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
                ]
              },
              {
                id    : 5,
                owned : false,
                title : "Game-Controller Policy",
                icon: require("../../assets/SVGs/undraw_gaming_6oy3.svg"),
                description: "Authoritatively maintain standardized applications after premier markets.",
                losses      : [
                    "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
                ]
              },
              {
                id    : 6,
                owned : true,
                title: "Printer Policy",
                icon: require("../../assets/SVGs/undraw_printing_invoices_5r4r.svg"),
                description: 'Uniquely engineer flexible internal or "organic" sources without.',
                losses      : [
                    "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
                ]
              },
            ]
        }
    },
    
    methods:{
      getPolicyItem(coverID){
          const cv = this.coveredItems.find((cover) => cover.id === coverID)
          this.curStep = 1;
          this.coverItem = cv;
      },
      monitorVal(e,config){
        if(config != undefined && e.target.value){
          switch (config) {
            case 1:
              this.configCover = e.target.value
              break;
            
            case 2:
              this.configPeriod = e.target.value
              break;
            
            case 3:
              this.configDepo = e.target.value
              break;
          
            default:
              break;
          }

        }
        
      },
    }
        
}
</script>

<style lang="scss">
@import "../../assets/variables.scss";
.btn-success{
  background-color: $greenDarkCol !important;
  border-color: $greenDarkCol !important;
}
#policyModal{
  .quotation{
      color: $bluCol;
  }
}

.paramRow{
    font-size: large;
    color: $gray-800;
}
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