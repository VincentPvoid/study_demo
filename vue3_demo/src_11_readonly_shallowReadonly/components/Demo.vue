<template>
  <div>
    <h1>readonly & shallowReadonly</h1>
    <div>
      <p>count: {{ count }}</p>
      <!-- 以下如果设置了readonly则无效 -->
      <button @click="count++">click add 1</button>
    </div>

    <hr />

    <p>{{ hunter }}</p>
    <span>name: {{ name }}</span>
    <br />
    <span>age: {{ age }}</span>
    <br />

    <span>salary: {{ job.j1.salary }}</span>
    <br />
    <button @click="name += '@'">change name</button>
    <button @click="age++">change age</button>
    <button @click="job.j1.salary++">change salary</button>
  </div>
</template>

<script>
import { ref, reactive, toRefs, readonly, shallowReadonly } from "vue";

export default {
  name: "Demo",
  setup() {
    let count = ref(0);

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

    // 设置了readonly则count的值只读，不能改变
    count = readonly(count)

    // 设置了readonly则hunter中的值只读，不能改变；包括复杂数据中的嵌套
    // hunter = readonly(hunter)


    // 设置了shallowReadonly则hunter中的浅层数据只读，不能改变，
    // 但复杂数据中的嵌套数据可以改变
    // 例子中为salary的值可以改变
    hunter = shallowReadonly(hunter)

    return {
      count,
      hunter,
      ...toRefs(hunter),
    };
  },
};
</script>

<style>
</style>