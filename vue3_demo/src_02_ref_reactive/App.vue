<template>
  <RefTest />
  <ReactiveTest />
  <Test />
</template>

<script>
import RefTest from './components/RefTest'
import ReactiveTest from './components/ReactiveTest'
import Test from './components/Test'

export default {
  name: 'App',
  components: {
    RefTest,
    ReactiveTest,
    Test
  }
}
</script>

<style>
#app {
  /* font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px; */
}
</style>
