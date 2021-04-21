<template>
    <!-- <div class="slidercontainer">
        <input type="range" :min="min" :max="max" value="50" class="slider" id="myRange">
    </div> -->
    <!-- <div> -->
      <div class="range-slider px-2">
          <input @load="handleFillEvent" @touchstart="handleFillEvent" @mousemove="handleFillEvent" ref="rSlider" class="range-slider__range" type="range" value="0" :min="min" :max="max">
          <!-- <span class=" range-slider__value">100</span> -->
          <div class="text-center DescriptionsText">
            <span v-if="pre" > {{ units }}&nbsp;</span>
            {{ value }}
            <span v-if="!pre">&nbsp;{{ units }} </span>
          </div>
      </div>

    <!-- </div> -->
</template>
<script>
import { ref } from 'vue'
export default {
    name: "RangeSlider",
    props:{
        max: Number,
        min: Number,
        units: String,
        pre: Boolean,
    },
    setup() {
        const value = ref(1);
        // First let's set the colors of our sliders
        // These are the $greenCp; and $greenLightCol respectively
        const settings={
            fill: '#5fefc0',
            background: '#bff9e6'
        }
        // Initialise the ref tha will be attahched to our slider.
        const rSlider = ref(null)

        // This function applies the fill to our sliders by using a linear gradient background
        function applyFill(slider) {
            // Let's turn our value into a percentage to figure out how far it is in between the min and max of our input
            const percentage = 100*(slider.value-slider.min)/(slider.max-slider.min);
            // now we'll create a linear gradient that separates at the above point
            // Our background color will change here
            const bg = `linear-gradient(90deg, ${settings.fill} ${percentage}%, ${settings.background} ${percentage+0.1}%)`;
            slider.style.background = bg;
        }
        const handleFillEvent = ()=> { 
          value.value = rSlider.value.value

          applyFill(rSlider.value) 
          // console.log(value.value)
        }


        return{ rSlider, handleFillEvent, value  }
    },
}
</script>
<style lang="scss">
@import "/src/assets/variables.scss";
// Base Colors
$shade-10: $bluCol !default; // handle colour
$shade-1: $greenLightCol !default; // track backkground colour
$shade-0: #fff !default;
$teal: $hovbluCol !default;

.range-slider {
  // margin: 60px 0 0 0%;
  .DescriptionsText{
    margin-left: -13px;
  }
}

// Range Slider
$range-width: 100% !default;

$range-handle-color: $shade-10 !default;
$range-handle-color-hover: $teal !default;
$range-handle-size: 24px !default;

$range-track-color: $shade-1 !default;
$range-track-height: 10px !default;

$range-label-color: $shade-10 !default;
$range-label-width: 0px !default;

.range-slider {
  width: $range-width;
}

.range-slider__range {
  -webkit-appearance: none;
  // width: calc(100% - (#{$range-label-width + 13px}));
  width: calc(100% - (#{$range-label-width + 0px}));
  height: $range-track-height;
  border-radius: 5px;
  background: $range-track-color;
  outline: none;
  padding: 0;
  margin: 0;

  // Range Handle
  &::-webkit-slider-thumb {
    appearance: none;
    width: $range-handle-size;
    height: $range-handle-size;
    border-radius: 50%;
    background: $range-handle-color;
    cursor: pointer;
    transition: background 0.15s ease-in-out;

    &:hover {
      background: $range-handle-color-hover;
    }
  }

  &:active::-webkit-slider-thumb {
    background: $range-handle-color-hover;
  }

  &::-moz-range-thumb {
    width: $range-handle-size;
    height: $range-handle-size;
    border: 0;
    border-radius: 50%;
    background: $range-handle-color;
    cursor: pointer;
    transition: background 0.15s ease-in-out;

    &:hover {
      background: $range-handle-color-hover;
    }
  }

  &:active::-moz-range-thumb {
    background: $range-handle-color-hover;
  }

  // Focus state
  &:focus {
    &::-webkit-slider-thumb {
      // box-shadow: 0 0 0 3px $shade-0, 0 0 0 6px $teal;
    }
  }
}

// Range Label
.range-slider__value {
  display: inline-block;
  position: relative;
  width: $range-label-width;
  color: $shade-0;
  line-height: 20px;
  text-align: center;
  border-radius: 3px;
  background: $range-label-color;
  padding: 5px 10px;
  margin-left: 8px;

  &:after {
    position: absolute;
    top: 8px;
    left: -7px;
    width: 0;
    height: 0;
    border-top: 7px solid transparent;
    border-right: 7px solid $range-label-color;
    border-bottom: 7px solid transparent;
    content: "";
  }
}

// Firefox Overrides
::-moz-range-track {
  background: $range-track-color;
  border: 0;
}

input::-moz-focus-inner,
input::-moz-focus-outer {
  border: 0;
}

</style>
