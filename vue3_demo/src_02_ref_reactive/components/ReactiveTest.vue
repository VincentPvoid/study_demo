<template>
  <div class="test-reactive">
    <h1>reactive</h1>
    <h2>name: {{ name }}</h2>
    <h2>age: {{ age }}</h2>
    <h2>job type: {{ job.type }}</h2>
    <h2>job address: {{ job.address }}</h2>
    <button @click="changeValueText">change value</button>
  </div>
</template>

<script>
import { ref, reactive } from 'vue';

export default {
  name: 'ReactiveTest',
  setup(){
    let name = ref('Maria')
    let age = ref(18)
    let job = reactive({
      type: 'hunter',
      address: 'Astral Clocktower'
    })

    function changeValueText(){
      name.value = 'plain doll';
      age.value = 3;
      job.type = 'doll'
      job.address = "Hunter's Dream"
      
      console.log(job, 'reactive')
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

<style>
.test-reactive{
  margin:20px 0;
  background: #ccc;
}
</style>