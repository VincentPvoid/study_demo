<template>
  <h1>computed</h1>
  <p>
    <span>first name: </span>
    <input type="`text`" v-model="hunter.firstName" />
  </p>
  <p>
    <span>last name: </span>
    <input type="`text`" v-model="hunter.lastName" />
  </p>

  <p><span>full name: </span> {{ hunter.fullName }}</p>

  <p>
    <span>full name: </span>
    <input type="`text`" v-model="hunter.fullName" />
  </p>
</template>

<script>
import { reactive, computed } from "vue";

export default {
  name: "Demo",
  setup() {
    let hunter = reactive({
      firstName: "Lady",
      lastName: "Maria",
    });

    // 计算属性：简写，没有考虑计算属性被修改的情况
    // hunter.fullName = computed(() => {
    //   return hunter.firstName + ' ' + hunter.lastName
    // })

    // 计算属性：完整写法，考虑读和写
    hunter.fullName = computed({
      get() {
        return hunter.firstName + " " + hunter.lastName;
      },
      set(value) {
        const nameArr = value.split(" ");
        hunter.firstName = nameArr[0];
        hunter.lastName = nameArr[1];
      },
    });

    return {
      hunter,
    };
  },
};
</script>

<style>
</style>