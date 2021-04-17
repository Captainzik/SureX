<template>
  <section id="TrySection" class="MajorSection">
    <div class="container h-100">
      <div class="row h-100 tryWrapper">
        <div class="col-12 d-flex flex-column justify-content-center">
          <div class="TryTitle ">
            <span class="pt-2 pb-3">Try and Buy</span>
        </div>
        </div>
        <div class="col-lg-6 col-sm-12">
            <div class="h-100 TryConfigWrapper d-flex flex-column justify-content-center px-4">
              <div class="">
                <p class="DescriptionsText text-center">How much cover do you need?</p>
                <RangeSlider @mouseup="monitorVal($event,1)" class="mb-3" :max="2000" :min="1" :units="'$'" :pre="true"/>
                
                <p class="DescriptionsText text-center">Over what period do you need it?</p>
                <RangeSlider @mouseup="monitorVal($event,2)" class="mb-3" :max="72" :min="1" :units="'Months'" :pre="false"/>

                <p class="DescriptionsText text-center">What is your initial deposit(optional)??</p>
                <RangeSlider @mouseup="monitorVal($event,3)" class="mb-3" :max="100" :min="1" :units="'$'" :pre="true"/>
            </div>
            <div class="py-5 trybuyitWrapper">
                <span class="trybuyit">Try it</span>
            </div>
          </div>
        </div>
        <div class="col-lg-6 d-flex flex-column justify-content-center px-4">
          <div class=" policyOverviewWrapper d-flex flex-column justify-content-center align-items-center">
              <div class="policyOverview ">
                  <div class="title"> Policy Overview </div>
                  <div class="paramsBriefWrapper py-3">
                      <div class="paramsBrief d-flex flex-column py-4">
                          <div class="d-flex justify-content-between paramsBriefItem px-4">
                            <span>Savings target&nbsp;:</span>
                            <span>$ {{ configCover }} </span>
                          </div>
                          <div class="d-flex justify-content-between paramsBriefItem px-4">
                            <span>Over a period of&nbsp;:</span>
                            <span> {{ configPeriod }} Months</span>
                          </div>
                          <div class="d-flex justify-content-between paramsBriefItem px-4">
                            <span> With an initial deposit of&nbsp;:</span>
                            <span>$ {{configDepo}}</span>
                          </div>
                      </div>
                      <br>
                      <div class="paramsBrief d-flex flex-column ">
                          <div class="d-flex justify-content-between paramsBriefItem px-4 bgGreen">
                            <span><strong> Your premium will be&nbsp;:</strong></span>
                            <span><strong>${{ premium }}</strong></span>
                          </div>
                          <div class="d-flex justify-content-between paramsBriefItem px-4">
                            <span>You will <strong>save</strong> at least:&nbsp;:</span>
                            <span> ${{savings}}</span>
                          </div>
                      </div>
                      <div class="mt-5 trybuyitWrapper">
                          <a class=" trybuyit">BUY</a>
                      </div>
                  </div>
              </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import RangeSlider from "../RangeSlider.vue";
export default {
    name: "Try", 
    components:{
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
          configCover   : 0,
          configPeriod  : 0,
          configDepo    : 0,
      }
    },
    methods:{
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
};
</script>

<style lang="scss">
@import "/src/assets/variables.scss";
#TrySection{
    
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
}

.policyOverviewWrapper{
  border-radius: 8px;
  height: 100%;
  max-height: 800px;
  background-color: $greenLightCol;
  text-align: center;
  .policyOverview{
      border-radius: 18px;
      height: 70%;
      width: 80%;
      background-color: #fff;
      
      div.title{
        text-transform: uppercase;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
        line-height: 2;
        background-color: $bluCol;
        font-size: x-large;
        width: 100%;
        font-family: "Gotham-Medium";
        color: #fff;
      }
  }
   
  .paramsBrief{
      .paramsBriefItem{
        padding: .6em 0;
        span{ 
          color: $bluCol; }
          font-size: large;
          font-family: "Gotham-Book";
      }
      .bgGreen{
        background-color: $greenCol;
      }
  }
}

  .TryTitle {
      span {
        width: 100%;
        text-align: center;
        display: block;
        font-size: xxx-large;
        font-family: "Gotham-Medium";
        color: $bluCol;
      }
    }
.tryWrapper {
    .TryConfigWrapper {
      height: 100%;
      
    }
      .TryDescription {
        color: $bluCol;
        font-size: large;
        font-family: "Gotham-Book";
        text-align: justify;
      }
    .trybuyitWrapper{
      text-align: center;
      .trybuyit{
        margin: 0 auto;
        display: block;
        width: 120px;
        border-top-left-radius: 2em;
        border-bottom-left-radius: 2em;
        border-top-right-radius: 2em;
        border-bottom-right-radius: 2em;
        padding: .08em .7em;
        text-decoration: none;
        text-transform: uppercase;
        font-size: x-large;
        font-family: "Gotham-Bold";
        cursor: pointer;
      }
    }
}
 .paramsBriefWrapper{
    .trybuyit{
        color: $bluCol;
        background-color: $greenCol;
        &:hover{
          background-color: $greenDarkCol;
        }
    }
  }
  .TryConfigWrapper {
    .trybuyit{
      color: #fff;
      background-color: $bluCol;
      &:hover{
        background-color: $bluDarkCol;
      }
    }
  }
</style>