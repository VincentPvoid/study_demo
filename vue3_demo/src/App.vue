<template>
  <div class="wrapper">
    <h2>outer wrapper</h2>
    <CubeClass1 />
  </div>
</template>

<script>
import { reactive, toRefs, } from 'vue';

import CubeClass1 from './components/CubeClass1'

export default {
  name: "App",
  components:{
    CubeClass1,
  },

};
</script>

<style>
.wrapper{
  padding:10px;
  border:5px solid #000;
}
</style>
