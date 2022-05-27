<template>
  <div class="wrapper">
    <h2>outer wrapper</h2>
    <h2> {{name}}  {{age}}</h2>
    <CubeClass1 />
  </div>
</template>

<script>
import { reactive, toRefs, provide } from 'vue';

import CubeClass1 from './components/CubeClass1'

export default {
  name: "App",
  components:{
    CubeClass1,
  },
  setup() {
    let hunter = reactive({
      name: 'Maria',
      age:18
    })

    // 给自己的后代组件传递数据
    provide('hunter', hunter)

    return {
      ...toRefs(hunter)
    }
  },
};
</script>

<style>
.wrapper{
  padding:10px;
  border:5px solid #000;
}
</style>
