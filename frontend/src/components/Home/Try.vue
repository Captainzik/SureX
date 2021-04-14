<template>
  <section id="TrySection" class="MajorSection">
    <div class="container h-100">
    <div class="row">
    </div>
      <div class="row h-100 tryWrapper">
        <div class="col-12 TryTitle">
            <span>Try and Buy</span>
        </div>
        <div class="col-lg-6">
          <div class="TryConfigWrapper d-flex flex-column justify-content-center align-items-center">
            <p class="DescriptionsText">How much cover do you need?</p>
            <div class="slidecontainer">
                <input type="range" min="1" max="100" value="50" class="slider" id="myRange">
            </div>
            <p class="DescriptionsText">Over what period do you need it?</p>
            <div class="slidecontainer">
                <input type="range" min="1" max="100" value="50" class="slider" id="myRange">
            </div>
            <p class="DescriptionsText">What is your initial deposit(optional)??</p>
            <div class="slidecontainer">
                <input type="range" min="1" max="100" value="50" class="slider" id="myRange">
            </div>
          </div>
        </div>
        <div class="col-lg-6">
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
#TrySection{
    background-image: url("../../assets/Images/IllustrationBackground.png");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
}
.tryWrapper {
    .TryTitle {
        text-align: center;
      span {
        font-size: xxx-large;
        font-family: "Gotham-Medium";
        color: $bluCol;
      }
    .TryConfigWrapper {
      height: 100%;
      }
      .TryDescription {
        color: $bluCol;
        font-size: large;
        font-family: "Gotham-Book";
        text-align: justify;
      }
    }

}
.illustrationWrapper {
  display: block;
  height: 100%;
}
    </style>