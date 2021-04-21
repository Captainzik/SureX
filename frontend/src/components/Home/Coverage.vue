<template>
    <section id="CovertageSection" class="MajorSection mb-3">
        <div class="container h-100 d-flex flex-column justify-content-center">
            <!-- <div class="CoverageWrapper h-100 w-100 d-flex  align-content-center"> -->
                <div class=" CovertageTitle p-5 align-self-top ">
                    <span class="my-5">
                        HOW IT WORKS
                    </span>
                </div>
                <div class="row mt-5">
                    <div class="col-sm-12 col-md-4 my-3">
                        <div class="card-box">
                            <div class="cardImg">
                                <img class="img-fluid" src="../../assets/Images/MagnifyingGlass.png" alt="choose">
                            </div>
                            <div class="cardText d-flex justify-content-center">
                                <p class="DescriptionsText col-lg-8">
                                    Choose your coverage package.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-4 my-3">
                        <div class="card-box">
                            <div class="cardImg">
                                <img class="img-fluid" src="../../assets/Images/Coins.png" alt="Coins">
                            </div>
                            <div class="cardText d-flex justify-content-center">
                                <p class="DescriptionsText col-lg-8">
                                    Get a quote and buy discretionary coverage instantly using our app.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-4 my-3">
                        <div class="card-box">
                            <div class="cardImg">
                                <img class="img-fluid" src="../../assets/Images/Dartboard.png" alt="Select">
                            </div>
                            <div class="cardText d-flex justify-content-center">
                                <p class="DescriptionsText col-lg-8">
                                    Easily make a claim within minutes if you need to.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            <!-- </div> -->
        </div>
    </section>
</template>

<script>
export default {

    setup() {
        },
}
</script>

<style lang="scss">
@import "/src/assets/variables.scss";
    .CovertageTitle{
        text-align: center;
        span{
            font-size: 2.75em;
            font-family: 'Gotham-Medium';
            color: $bluCol;
        }
    }
    .CovertageDescription{
        color: $bluCol;
        font-size: large;
        font-family: 'Gotham-Book';
        text-align: center;
    }
    .card-box{
        text-align: center;
        p{
            text-align: center;
        }
    }
</style>