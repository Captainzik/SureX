<template>
  <Navbar/>
  <div class="home">
      <Landing/>
      <Coverage/>
      <Try/>
      <Contactus/>
  </div>
</template>

<script>
// @ is an alias to /src
  import Landing from '../components/Home/Landing.vue'
  import Coverage from '../components/Home/Coverage.vue'
  import Contactus from '../components/Home/Contactus.vue'
  import Try from '../components/Home/Try.vue'
  import Navbar from '@/components/Navbar.vue'
  
export default {
  name: 'Home',
  components: {
    Navbar,
    Landing,
    Coverage,
    Try,
    Contactus
  }
}
</script>
