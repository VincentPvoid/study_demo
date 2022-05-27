<template>
  <div>
    <h1>toRaw & markRaw</h1>
    <div>
      <p>count: {{ count }}</p>
      <button @click="count++">click add 1</button>
    </div>

    <hr />

    <!-- <p>{{ hunter }}</p> -->
    <span>name: {{ name }}</span>
    <br />
    <span>age: {{ age }}</span>
    <br />
    <span>salary: {{ job.j1.salary }}</span>
    <br />
    <span>weapon: {{ hunter.weapon }} </span>
    <br>
    <button @click="name += '@'">change name</button>
    <button @click="age++">change age</button>
    <button @click="job.j1.salary++">change salary</button>
    <br>
    <button @click="showHunterObj">show original hunter Object</button>
    <button @click="addWeapon">add weapon</button>
    <br>
    <!-- 新添加的weapon为响应式对象时，点击按钮，界面实时更新 -->
    <!-- <button v-if="hunter.weapon" @click="hunter.weapon.name+='%'">change weapon name</button>
    <button v-if="hunter.weapon" @click="hunter.weapon.atk++">add atk</button> -->
    <br>
    
    <!-- 新添加的weapon为非响应式对象时，点击按钮，界面不会实时更新 -->
    <button v-if="hunter.weapon" @click="hunter.weapon.name+='%'">change weapon name</button>
    <button v-if="hunter.weapon" @click="addAtk">add atk</button>
  </div>
</template>

<script>
import { ref, reactive, toRefs, toRaw, markRaw } from "vue";

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


    // 在控制台输出原始hunter对象
    function showHunterObj(){
      // // 下方输出的为经过Proxy包装后的hunter对象，不是原始的hunter对象
      // console.log(hunter)
      // // 输出原始hunter对象
      // console.log(toRaw(hunter))

      // 以下操作会修改原始对象，但因为不是响应式所以界面并不会实时更新
      const h = toRaw(hunter)
      h.age++;
      console.log(h)
    }


    // 点击添加weapons属性
    function addWeapon(){
      let weapon = {name:'Rakuyo', atk: 100}
      // hunter.weapon = weapon

      // 使用markRaw后，对象不会变为响应式对象
      // 当数据为复杂的大量数据时，设置为非响应式可以提高性能
      // 例子中为改变添加的weapon中的值时，界面不会实时更新
      hunter.weapon = markRaw(weapon)
    }

    function addAtk(){
      hunter.weapon.atk++;
      console.log(hunter.weapon)
    }

    return {
      count,
      hunter,
      ...toRefs(hunter),
      showHunterObj,
      addWeapon,
      addAtk
    };
  },
};
</script>

<style>
</style>