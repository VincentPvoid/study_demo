<template>
  <h1>不要混用vue2和vue3的写法</h1>
  <h2>name: {{name}} </h2>
  <h2>age: {{age}} </h2>
  <button @click="vue3Test">click test</button>
  <br>
  <br>
  <button @click="vue2Test">click test</button>
  <br>
  <br>
  <button @click="readVue3Data">read vue3's data in vue2' setting</button>
  <br>
  <br>
  <button @click="readVue2Data">read vue2's data in vue3' setting</button>
</template>

<script>
import { h } from 'vue';

export default {
  name: 'App',
  data(){
    return {
      gender: 'female'
    }
  },
  methods:{
    vue2Test(){
      console.log(this.gender, 'vue2')
    },
    // 读取vue3中的数据
    readVue3Data(){
      console.log(this.gender)
      console.log(this.name)
      console.log(this.age)
      console.log(this.vue3Test)
    }
  },
  // 此处只是测试一下setup，暂时不考虑响应式的问题
  setup(){
    // 数据
    let name = 'Maria';
    let age = 25;

    // 方法
    function vue3Test(){
      console.log(name, age, 'vue3')
    }

    // 读取vue2（使用vue2写法）的数据
    function readVue2Data(){
      console.log(name)
      console.log(age)
      console.log(vue3Test)
      console.log(this.gender)
      console.log(this.readVue3Data)
    }

    // 返回一个对象（常用）
    return {
      name,
      age,
      vue3Test,
      readVue2Data
    }

    // 返回一个函数（渲染函数）
    // return () => h('h1', 'vue3Test')
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
