<template>
  <div class="cube-class2">
    <h2>cube class2</h2>
    <ModalTest />
  </div>
</template>

<script>
import ModalTest from './ModalTest'

export default {
  name: "CubeClass2",
  components:{
    ModalTest,
  }
};
</script>

<style>
.cube-class2 {
  background: lightblue;
  padding: 10px;
}
</style>