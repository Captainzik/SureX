<template>
  <section id="LandingSection" class="MajorSection">
    <div class="container h-100">
      <div class="row h-100 landingWrapper">
        <div class="col-lg-5">
          <div
            class="LandingText d-flex flex-column justify-content-center align-items-center">
            <div class="LandingTitle">
              <span> DECENTRALISED COVERAGE </span>
            </div>
            <div class="">
              <p class="LandingDescription">
                Collaboratively brand business human capital and one-to-one
                alignments. Compellingly underwhelm plug-and-play services and
                functionalized web services. Objectively visualize wireless
                strategic theme areas vis-a-vis 24/7 architectures.
              </p>
            </div>
          </div>
        </div>
        <div class="col-lg-7">
          <span class="illustrationWrapper d-flex flex-column justify-content-center">
            <img
              class="img-fluid"
              src="../../assets/Images/IllustrationOnly.png"
              alt="Illustration"
            />
          </span>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  setup() {},
};
</script>

<style lang="scss">
@import "/src/assets/variables.scss";
#LandingSection{
    background-image: url("../../assets/Images/IllustrationBackground.png");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
}
.landingWrapper {
//   background-image: url("../../assets/Images/Illustration.png");
  background-size: 100%;
  background-position: center;
  background-repeat: no-repeat;
}
.LandingText {
  height: 100%;
  .LandingTitle {
    span {
      font-size: xxx-large;
      font-family: "Gotham-Medium";
      color: $bluCol;
    }
  }
  .LandingDescription {
    color: $bluCol;
    font-size: large;
    font-family: "Gotham-Book";
    text-align: justify;
  }
}
.illustrationWrapper {
  display: block;
  height: 100%;
}
</style>