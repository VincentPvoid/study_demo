<template>
  <div>
    <div>
      <p>count: {{ countObj.count }} </p>
      <button @click="countObj = {count:100}">click replace countObj</button>
      <br>
      <!-- 以下操作在使用shallowRef时无效 -->
      <button @click="countObj.count++">click add</button>
    </div>

    <hr>

    <p>{{ hunter }} </p>
    <span>name: {{ name }}</span>
    <br />
    <span>age: {{ age }}</span>
    <br />

    <span>salary: {{ job.j1.salary }}</span>
    <br />
    <button @click="name += '@'">change name</button>
    <button @click="age++">change age</button>
    <br>
    <!-- 以下操作在使用shallowReactive时无效 -->
    <button @click="job.j1.salary++">change salary</button>
  </div>
</template>

<script>
import { ref, reactive, toRefs, shallowRef, shallowReactive } from "vue";

export default {
  name: "Demo",
  setup() {

    // shallowRef：只处理基本数据类型的响应式, 不进行对象的响应式处理
    // ref处理对象时会自动使用reactive生成Proxy对象；
    // shallowRef则不会；因此如果直接对应对象中的值，则不会进行处理
    let countObj = shallowRef({
    // let countObj = ref({
      count:0
    })


    // shallowReactive只处理对象最外层属性的响应（浅响应式）
    // let hunter = shallowReactive({
    let hunter = reactive({
      name: "Maria",
      age: 18,
      job: {
        type: "hunter",
        address: "Astral Clocktower",
        j1: {
          salary: 10,
        },
        onlyTest: {
          a: {
            b: {
              c: 123,
            },
          },
        },
      },
    });

    return {
      countObj,
      hunter,
      ...toRefs(hunter)
    };
  },
};
</script>

<style>
</style>