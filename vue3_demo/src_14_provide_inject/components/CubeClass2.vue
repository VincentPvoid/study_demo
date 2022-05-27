<template>
  <div class="cube-class2">
    <h2>cube class2</h2>
    <h3>{{ hunter.name }} {{ hunter.age }}</h3>
  </div>
</template>

<script>
import { inject } from "vue";
export default {
  name: "CubeClass2",
  setup() {
    // 使用inject获取祖先组件中的数据
    let hunter = inject("hunter");
    return {
      hunter,
    };
  },
};
</script>

<style>
.cube-class2 {
  background: lightblue;
  padding: 10px;
}
</style>