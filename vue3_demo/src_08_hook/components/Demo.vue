<template>
  <div>
    <h1>Demo</h1>
    <div>
      <span>sum: {{ sum }} </span>
      <br />
      <button @click="sum++">add 1</button>
    </div>
    <hr>
    <div>
      point x: {{ point.x }} y: {{ point.y }}
    </div>
  </div>
</template>

<script>
import { ref } from "vue";

import { usePoint } from '../hook/usePoint'

export default {
  name: "Demo",
  setup() {
    let sum = ref(0);

    let point = usePoint()

    return {
      sum,
      point
    };
  },
};
</script>

<style>
</style>