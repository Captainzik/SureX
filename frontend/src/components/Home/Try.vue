<template>
  <section id="TrySection" class="MajorSection my-5 py-5">
    <div class="container h-100">
      <div class="row mb-5">
        <div class="col-12 d-flex flex-column justify-content-center my-2">
          <div class="TryTitle">
            <span class="pt-2 pb-3 py-3">Try and Buy</span>
          </div>
        </div>
      </div>
      <div class="row h-100 tryWrapper">
        <div class="col-lg-6 col-sm-12">
          <div
            class=" TryConfigWrapper d-flex flex-column justify-content-center px-4"
          >
            <div class="">
              <p class="DescriptionsText text-center">
                How much cover do you need?
              </p>
              <RangeSlider
                @mouseup="monitorVal($event, 1)"
                class="mb-3"
                :max="2000"
                :min="1"
                :units="'$'"
                :pre="true"
              />

              <p class="DescriptionsText text-center">
                Over what period do you need it?
              </p>
              <RangeSlider
                @mouseup="monitorVal($event, 2)"
                class="mb-3"
                :max="72"
                :min="1"
                :units="'Months'"
                :pre="false"
              />

              <p class="DescriptionsText text-center">
                What is your initial deposit(optional)??
              </p>
              <RangeSlider
                @mouseup="monitorVal($event, 3)"
                class="mb-3"
                :max="100"
                :min="1"
                :units="'$'"
                :pre="true"
              />
            </div>
            <div class="py-5 trybuyitWrapper">
              <span class="trybuyit">Try it</span>
            </div>
          </div>
        </div>
        <div class="col-lg-6 d-flex flex-column justify-content-center px-4">
          <div
            class="policyOverviewWrapper d-flex flex-column justify-content-center align-items-center py-5"
          >
            <div class="policyOverview my-5">
              <div class="title">Policy Overview</div>
              <div class="paramsBriefWrapper py-3">
                <div class="paramsBrief d-flex flex-column py-4">
                  <div
                    class="d-flex justify-content-between paramsBriefItem px-4"
                  >
                    <span>Savings target&nbsp;:</span>
                    <span>$ {{ configCover }} </span>
                  </div>
                  <div
                    class="d-flex justify-content-between paramsBriefItem px-4"
                  >
                    <span>Over a period of&nbsp;:</span>
                    <span> {{ configPeriod }} Months</span>
                  </div>
                  <div
                    class="d-flex justify-content-between paramsBriefItem px-4"
                  >
                    <span> With an initial deposit of&nbsp;:</span>
                    <span>$ {{ configDepo }}</span>
                  </div>
                </div>
                <br />
                <div class="paramsBrief d-flex flex-column">
                  <div
                    class="d-flex justify-content-between paramsBriefItem px-4 bgGreen"
                  >
                    <span><strong> Your premium will be&nbsp;:</strong></span>
                    <span
                      ><strong>${{ premium }}</strong></span
                    >
                  </div>
                  <div
                    class="d-flex justify-content-between paramsBriefItem px-4"
                  >
                    <span>You will <strong>save</strong> at least:&nbsp;:</span>
                    <span> ${{ savings }}</span>
                  </div>
                </div>
                <div class="my-3 trybuyitWrapper">
                  <a class="trybuyit">BUY</a>
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
import Web3 from 'web3';
import RangeSlider from "../RangeSlider.vue";
export default {
  name: "Try",
  components: {
    RangeSlider,
  },
  computed: {
    premium() {
      // Calculation of Premiums
      // Parameters include varianles in the data object: configCover, configPeriod, configDepo
      // use this to access the variables eg. this.configCover and return the final result
      let prem =
        (Number(this.configCover) + Number(this.configDepo)) /
        this.configPeriod;
      return prem > 0 ? Math.round(prem, 2) : 0;
    },
    savings() {
      // Calculation of Savings
      // Parameters may include varianles in the data object: configCover, configPeriod, configDepo
      // use this to access the variables eg. this.configCover and return the final result
      let savs =
        Number(this.configCover) +
        Number(this.configDepo) -
        (this.configCover * 0.94) / 1.005;
      return savs > 0 ? Math.round(savs, 2) : 0;
    },
  },
  data() {
    return {
      configCover   : 0,
      configPeriod  : 0,
      configDepo    : 0,
      contract      : null,
    };
  },
  methods: {
    monitorVal(e, config) {
      if (config != undefined && e.target.value) {
        switch (config) {
          case 1:
            this.configCover = e.target.value;
            break;

          case 2:
            this.configPeriod = e.target.value;
            break;

          case 3:
            this.configDepo = e.target.value;
            break;

          default:
            break;
        }
      }
    },
    async calculatePolicy(_target, _term, _deposit){
        await this.contract.methods.requestForCover().call()
    }
  },
  mounted(){
      web3            = new Web3(Web3.givenProvider || "http://localhost:8545");
      const address   = "0x67a8f9Be3B7089b6EED44607Bd6F59A527D9A6d1";
      const abi       = [{"inputs":[{"internalType":"uint256","name":"useOpsRateBIPS","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"accountPolicies","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"availableReserveBalance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"buy","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"buy","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"calculateMinimumMintAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tenderAmount","type":"uint256"}],"name":"calculateMintAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tenderAmount","type":"uint256"}],"name":"calculateRefundAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"targetAmount","type":"uint256"}],"name":"calculateTenderAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_target","type":"uint256"},{"internalType":"uint256","name":"_term","type":"uint256"},{"internalType":"uint256","name":"_deposit","type":"uint256"}],"name":"createPolicy","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"operations","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"opsRateBIPS","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_target","type":"uint256"},{"internalType":"uint256","name":"_term","type":"uint256"},{"internalType":"uint256","name":"_deposit","type":"uint256"}],"name":"requestForCover","outputs":[{"components":[{"internalType":"uint256","name":"target","type":"uint256"},{"internalType":"uint256","name":"term","type":"uint256"},{"internalType":"uint256","name":"deposit","type":"uint256"},{"internalType":"uint256","name":"savingsAnnuity","type":"uint256"},{"internalType":"uint256","name":"initialCoverPremium","type":"uint256"},{"internalType":"uint256","name":"firstInstallment","type":"uint256"}],"internalType":"struct Quotes.CoverQuote","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"reserveBalance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"riskRateBIPS","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tenderAmount","type":"uint256"}],"name":"sell","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"token","outputs":[{"internalType":"contract SRXToken","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]
      this.contract   = new web3.eth.Contract(abi, address)
  }
};
</script>

<style lang="scss">
@import "/src/assets/variables.scss";
#TrySection {
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  @media only screen and (min-width: 893px) {
        height: 100vh;
  }
  @media only screen and (max-width: 890px) {
        height: auto !important;
        max-height: auto !important;
    }
}

.policyOverviewWrapper {
  border-radius: 8px;
  // height: 100%;
  background-color: $greenLightCol;
  text-align: center;
  .policyOverview {
    border-radius: 18px;
    width: 80%;
    background-color: #fff;

    div.title {
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

  .paramsBrief {
    .paramsBriefItem {
      padding: 0.6em 0;
      span {
        color: $bluCol;
      }
      font-size: large;
      font-family: "Gotham-Book";
    }
    .bgGreen {
      background-color: $greenCol;
    }
  }
}

.TryTitle {
  span {
    width: 100%;
    text-align: center;
    display: block;
    font-size: 2.75em;
    font-family: "Gotham-Medium";
    color: $bluCol;
    text-transform: uppercase;
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
  .trybuyitWrapper {
    text-align: center;
    .trybuyit {
      margin: 0 auto;
      display: block;
      width: 120px;
      border-top-left-radius: 2em;
      border-bottom-left-radius: 2em;
      border-top-right-radius: 2em;
      border-bottom-right-radius: 2em;
      padding: 0.08em 0.7em;
      text-decoration: none;
      text-transform: uppercase;
      font-size: x-large;
      font-family: "Gotham-Bold";
      cursor: pointer;
    }
  }
}
.paramsBriefWrapper {
  .trybuyit {
    color: $bluCol;
    background-color: $greenCol;
    &:hover {
      background-color: $greenDarkCol;
    }
  }
}
.TryConfigWrapper {
  .trybuyit {
    color: #fff;
    background-color: $bluCol;
    &:hover {
      background-color: $bluDarkCol;
    }
  }
}
</style>