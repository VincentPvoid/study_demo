<template>
  <h1>Demo</h1>
  <h2>name: {{ person.name }}</h2>
  <h2>age: {{ person.age }}</h2>
  <button @click="disANum">click to console num</button>
  <br>
  <br>
  <slot name="slot1"></slot>
  <br>
  <slot name="slot2"></slot>
</template>

<script>
import { reactive } from 'vue';

export default {
  name: 'Demo',
  props:{
    msg:{
      type:String,
    },
    otherStr:{
      type:String
    }
  },
  emits:['hello'],
  setup(props, context){
    // console.log(props)
    console.log(context)
    // console.log(context.attrs) // 相当于vue2中的$attrs
    console.log(context.slots)

    let person = reactive({
      name:'Maria',
      age: 18,
    })

    function disANum(){
      context.emit('hello', 123)
    }


    return {
      person,
      disANum
    }
  }
};
</script>

<style>
</style>