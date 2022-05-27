<template>
  <Demo msg="hello world" otherStr="test" @hello="showNum">
    <template v-slot:slot1>
      <span>slot 1</span>
    </template>
    <template v-slot:slot2>
      <span>slot 2</span>
    </template>
  </Demo>
</template>

<script>
import Demo from "./components/Demo";

export default {
  name: "App",
  components: {
    Demo,
  },
  setup(){
    function showNum(num){
      console.log(`the num is ${num}`)
    }
    return {
      showNum
    }
  }
};
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
