<template>
  <div>
      <router-view/>
  </div>
</template>

<script>
import { provide } from '@vue/runtime-core';
export default {
    name: "SureX",    
    provide:  {
        covers: [
          {
            id      : 1,
            owned   : true,
            title   : "Laptop Cover",
            icon    : require("./assets/SVGs/undraw_noted_pc9f.svg"),
            description: "Proactively brand reliable imperatives before market positioning innovation.",
            losess      : [
                "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
            ]
          },
          {
            id    : 2,
            owned : true,
            title : "Smartphone Cover",
            icon: require("./assets/SVGs/undraw_calling_kpbp.svg"),
            description: "Conveniently engineer out-of-the-box communities and front-end human capital.",
            losess      : [
                "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
            ]
          },
          {
            id    : 3,
            owned : false,
            title : "Camera Cover",
            icon: require("./assets/SVGs/undraw_Camera_re_cnp4.svg"),
            description: "Efficiently engineer seamless portals rather than visionary mindshare.",
            losess      : [
                "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
            ]
          },
          {
            id    : 4,
            owned : false,
            title : "Bicycle Covers",
            icon: require("./assets/SVGs/undraw_Ride_a_bicycle_2yok.svg"),
            description: "Holisticly implement emerging expertise through empowered mindshare.",
            losess      : [
                "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
            ]
          },
          {
            id    : 5,
            owned : false,
            title : "Game-Controller Cover",
            icon: require("./assets/SVGs/undraw_gaming_6oy3.svg"),
            description: "Authoritatively maintain standardized applications after premier markets.",
            losess      : [
                "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
            ]
          },
          {
            id    : 6,
            owned : true,
            title: "Printer Cover",
            icon: require("./assets/SVGs/undraw_printing_invoices_5r4r.svg"),
            description: 'Uniquely engineer flexible internal or "organic" sources without.',
            losess      : [
                "Cracked Screen", "Bricked Motherboard", "Faulty Power Systems", "Faulty Keyboard","Theft"
            ]
          },
        ],      
    },
    data(){
      return{

      }
    }
}
</script>

<style lang="scss">
html,body{
 margin: 0; padding: 0;
}
body{
  height: 100%;
  width: 100%;
  padding: 0 !important;
  background: #fff !important;
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
