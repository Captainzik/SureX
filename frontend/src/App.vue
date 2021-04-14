<template>
  <Navbar/>
  <router-view/>
</template>

<script>
import Navbar from '@/components/Navbar.vue'
export default {
  name: "SureX",
  components:{
    Navbar
  }
}
</script>

<style lang="scss">
html,body{
 margin: 0; padding: 0
}
body{
  height: 100%;
  width: 100%;
}
@import "/src/assets/variables.scss";
@font-face {
  font-family: "Gotham-Bold";
  src: local("Gotham-Bold.ttf"),
   url(./assets/Fonts/Gotham-Bold.ttf) format("truetype");
}
@font-face {
  font-family: "Gotham-Book";
  src: local("Gotham-Book.ttf"),
   url(./assets/Fonts/Gotham-Book.ttf) format("truetype");
}
@font-face {
  font-family: "Gotham-Light";
  src: local("Gotham-Light.ttf"),
   url(./assets/Fonts/Gotham-Light.ttf) format("truetype");
}
@font-face {
  font-family: "Gotham-Medium";
  src: local("Gotham-Medium.ttf"),
   url(./assets/Fonts/Gotham-Medium.ttf) format("truetype");
}
 .MajorSection{
   @media only screen and (max-width: 600px) {
     
     }
    height: 100Vh;
      
  }
.DescriptionsText{
        color: $bluCol;
        font-size: large;
        font-family: 'Gotham-Book';
        text-align: justify;
}

</style>
