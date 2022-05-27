<template>
  <div class="test-wrapper">
    <h1>reactive</h1>
    <h2>name: {{ person.name }}</h2>
    <h2>age: {{ person.age }}</h2>
    <h2>job type: {{ person.job.type }}</h2>
    <h2>job address: {{ person.job.address }}</h2>
    <h2>quote: {{ person.quote }}</h2>
    <button @click="changeInfo">change value</button>
  </div>
</template>

<script>
import { reactive } from 'vue';

export default {
  name:'Test',
  setup(){
    let person = reactive({
      name:'Maria',
      age: 18,
      job:{
        type: 'hunter',
        address: 'Astral Clocktower',
        onlyTest:{
          a: {
            b: {
              c: 123
            }
          }
        }
      },
      quote:[
        'A corpse, should be left well alone',
        'Oh, I know very well how the secrets beckon so sweetly.',
        'Only an honest death will cure you now.',
        'Liberate you from your wild curiosity.'
      ]
    })
    
    function changeInfo(){
      person.name = 'plain doll';
      person.age = 3;
      person.job.type = 'doll'
      person.job.address = "Hunter's Dream";

      person.quote[0] = 'Hello, good hunter.'
    }
    return {
      person,
      changeInfo
    }
  }
}
</script>

<style>
.test-wrapper{
  background: lightblue;
}
</style>