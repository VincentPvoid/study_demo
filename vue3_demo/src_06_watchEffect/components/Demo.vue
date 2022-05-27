<template>
  <div>
    <h1>watch</h1>
    <div>
      <span>sum: {{ sum }} </span>
      <br />
      <button @click="sum++">add 1</button>
    </div>

    <hr />

    <div>
      <span>msg: {{ msg }} </span>
      <br />
      <button @click="msg += '!'">add 1</button>
    </div>

    <hr />

    <div>
      <span>name: {{ hunter.name }}</span>
      <br />
      <span>age: {{ hunter.age }}</span>
      <br />
      <span>salary: {{ hunter.job.salary }}</span>
      <br />
      <button @click="hunter.name += '@'">change name</button>
      <button @click="hunter.age++">change age</button>
      <button @click="hunter.job.salary++">change salary</button>
    </div>
  </div>
</template>

<script>
import { ref, reactive, watch, watchEffect } from "vue";

export default {
  name: "Demo",
  setup() {
    let sum = ref(0);
    let msg = ref("hello world");

    let hunter = reactive({
      name: "Maria",
      age: 18,
      job: {
        type: "hunter",
        address: "Astral Clocktower",
        salary: 1000,
        onlyTest: {
          a: {
            b: {
              c: 123,
            },
          },
        },
      },
    });

    // watchEffect启动时就会执行
    // 如果所指定的回调中用到的数据发生变化，则直接重新执行回调；
    // 数据没有在回调中被使用，则不会执行
    // 有点类似computed；但注重点不同；watchEffect更注重过程
    watchEffect(() => {
      const res1 = sum.value;
      const res2 = hunter.job.salary;
      console.log('---watchEffect---')
    })


    return {
      sum,
      msg,
      hunter,
    };
  },
};
</script>

<style>
</style>