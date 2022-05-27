<template>
  <div>
    <p>{{ hunter }} </p>
    <span>name: {{ name }}</span>
    <br />
    <span>age: {{ age }}</span>
    <br />
    <!-- 使用toRef -->
    <!-- <span>salary: {{ salary }}</span> <button @click="salary++">change salary</button> -->

    <!-- 使用toRefs -->
    <span>salary: {{ job.j1.salary }}</span> <button @click="job.j1.salary++">change salary</button>
    <br />
    <button @click="name += '@'">change name</button>
    <button @click="age++">change age</button>
    
  </div>
</template>

<script>
import { reactive, toRef, toRefs } from "vue";

export default {
  name: "Demo",
  setup() {
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

    const test1 = hunter.name;
    console.log('test1', test1)

    const test2 = toRef(hunter, 'name')
    console.log('test2', test2)


    const testRefs = toRefs(hunter)
    console.log('testRefs', testRefs)

    return {
      hunter,
      // name: toRef(hunter, 'name'),
      // age: toRef(hunter, 'age'),
      // salary: toRef(hunter.job.j1, 'salary'),
      ...toRefs(hunter)
    };
  },
};
</script>

<style>
</style>