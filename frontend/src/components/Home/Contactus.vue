<template>
    <section id="ContactSection" class="MajorSection py-3 my-3">
        <div class="container h-100 d-flex flex-column justify-content-center">
            <!-- <div class="CoverageWrapper h-100 w-100 d-flex  align-content-center"> -->
                <div class=" ContactTitle p-5 align-self-top col-12">
                    <span class="my-5">
                        CONTACT US
                    </span>
                </div>
                <div class="row text-center my-2">
                    <div class="w-100 d-flex justify-content-center align-items-center">
                        <div class="col-md-3  cardImg">
                            <a href="#">
                                <img class="img-fluid" src="../../assets/Images/Phone.png" alt="Phone">
                            </a>
                        </div>
                        <div class="col-md-4  cardText">
                            <p class="DescriptionsText contact">
                                Chat to our friendly suport team directly via WhatsApp on your mobile or desktop. Click the phone icon to start.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="row text-center my-2">
                    <div class="w-100 d-flex justify-content-center align-items-center ">
                        <div class="col-md-3 col-sm-12 cardImg">
                            <a href="#">
                                <img class="img-fluid" src="../../assets/Images/Envelope.png" alt="Phone">
                            </a>
                        </div>
                        <div class="col-md-4 col-sm-12 cardText">
                            <p class="DescriptionsText contact">
                                For customer or application related queries email: <strong>info@surex.io</strong>
                            </p>
                        </div>
                    </div>
                </div>
            <!-- </div> -->
        </div>
    </section>
</template>

<script>
export default {
    components: {
    },
    setup() {
        },
}
</script>

<style lang="scss">
@import "/src/assets/variables.scss";
    .ContactTitle{
        text-align: center;
        span{
            font-size: 2.75em;
            font-family: 'Gotham-Medium';
            color: $bluCol;
        }
    }
    .card-box{
        text-align: Center;
        p{
            text-align: center;
        }
    }
</style>