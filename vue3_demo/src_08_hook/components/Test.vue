<template>
  <div class="test-com">
    <h1>Test</h1>
    <span> point x: {{ point.x }} y: {{ point.y }}</span>
  </div>
</template>

<script>
import { usePoint } from '../hook/usePoint'

export default {
  name:'Test',
  setup(){
    let point = usePoint()
    return {
      point
    }
  }
}
</script>

<style>
.test-com{
  background:#ccc;
}
</style>