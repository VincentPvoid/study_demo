<template>
  <div class="cube-class1">
    <h2>cube class1</h2>
    <CubeClass2 />
  </div>
</template>

<script>
import CubeClass2 from './CubeClass2'
export default {
  name:'CubeClass1',
  components:{
    CubeClass2,
  }

}
</script>

<style>
.cube-class1{
  background: #ccc;
  padding:10px;
}
</style>