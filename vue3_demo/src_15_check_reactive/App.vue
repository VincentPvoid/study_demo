<template>
  <div class="wrapper">
    <h2>响应式数据的判断</h2>
  </div>
</template>

<script>
import {
  ref,
  reactive,
  toRefs,
  toRaw,
  readonly,
  isRef,
  isReactive,
  isReadonly,
  isProxy,
} from "vue";

export default {
  name: "App",
  setup() {
    let hunter = reactive({
      name: 'Maria',
      age: 18,
    })
    let sum = ref(0);
    let hunterCopy = readonly(hunter)
    let test = toRaw(hunter)

    console.log('------', hunterCopy)

    // isRef: 检查一个值是否为一个 ref 对象
    console.log(isRef(sum)) // true

    // isReactive: 检查一个对象是否是由 reactive 创建的响应式代理
    console.log(isReactive(hunter)) // true

    // isReadonly: 检查一个对象是否是由 readonly 创建的只读代理
    console.log(isReadonly(hunterCopy)) // true

    // isProxy: 检查一个对象是否是由 reactive 或者 readonly 方法创建的代理
    console.log(isProxy(hunterCopy)) // true

    console.log(isProxy(test)) // false


    return {
      ...toRefs(hunter)
    };
  },
};
</script>

<style>
</style>
