<template>
  <h1>ref function</h1>
  <h2>name: {{name}} </h2>
  <h2>age: {{age}} </h2>
  <h2>job type: {{job.type}} </h2>
  <h2>job address: {{job.address}} </h2>
  <button @click="changeValueText">change value</button>
</template>

<script>
import { ref } from 'vue';

export default {
  name: 'RefTest',
  setup(){
    // ref函数；常用用定义一个（基本类型的）响应数据
    let name = ref('Maria')
    let age = ref(18)
    let job = ref({
      type: 'hunter',
      address: 'Astral Clocktower'
    })

    function changeValueText(){
      name.value = 'plain doll';
      age.value = 3;
      job.value.type = 'doll'
      job.value.address = "Hunter's Dream"

      console.log(job, 'ref')
    }
    return {
      name,
      age,
      job,
      changeValueText
    }
  }
}
</script>