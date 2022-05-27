<template>
  <div>
    <h1>watch</h1>
    <div>
      <span>sum: {{ sum }} </span>
      <br />
      <button @click="sum++">add 1</button>
    </div>
  </div>
</template>

<script>
import {
  ref,
  onBeforeMount,
  onMounted,
  onBeforeUpdate,
  onUpdated,
  onBeforeUnmount,
  onUnmounted,
} from "vue";

export default {
  name: "Demo",
  setup() {
    let sum = ref(0);

    // console.log("---setup---");
    // // 通过组合式API的形式使用生命周期钩子
    // onBeforeMount(() => {
    //    console.log("---onBeforeMount---");
    // })
    // onMounted(() => {
    //    console.log("---onMounted---");
    // })
    // onBeforeUpdate(() => {
    //    console.log("---onBeforeUpdate---");
    // })
    // onUpdated(() => {
    //    console.log("---onUpdated---");
    // })
    // onBeforeUnmount(() => {
    //    console.log("---onBeforeUnmount---");
    // })
    // onUnmounted(() => {
    //    console.log("---onUnmounted---");
    // })


    return {
      sum,
    };
  },


  // 通过配置项的形式使用生命周期钩子
  //#region 
  beforeCreate() {
    console.log("---beforeCreate---");
  },
  created() {
    console.log("---created---");
  },
  beforeMount() {
    console.log("---beforeMount---");
  },
  mounted() {
    console.log("---mounted---");
  },
  beforeUpdate() {
    console.log("---beforeUpdate---");
  },
  updated() {
    console.log("---updated---");
  },
  beforeUnmount() {
    console.log("---beforeUnmount---");
  },
  unmounted() {
    console.log("---unmounted---");
  },
  //#endregion
};
</script>

<style>
</style>