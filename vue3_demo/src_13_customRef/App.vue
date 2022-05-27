<template>
  <div>
    <h1>customRef</h1>
    <input type="text" v-model="keyword" />
    <p>{{ keyword }}</p>
  </div>
</template>

<script>
import { ref, customRef } from "vue";

export default {
  name: "App",
  setup() {
    // let keyword = ref('test'); // 使用Vue提供的响应式ref

    let keyword = testCusRef("test", 1000); // 使用自定义的ref
    let timer = null;

    function testCusRef(value, delay) {
      // 通过customRef实现自定义
      return customRef((track, trigger) => {
        return {
          get() {
            console.log(`${value} is be read`);
            // console.log(`get ${keyword.value}`)
            track(); // 通知Vue追踪value的变化；否则keyword的值不会改变
            return value;
          },
          set(newValue) {
            console.log(`new value is: ${newValue}`);
            // console.log(`set ${keyword.value}`)
            clearTimeout(timer)
            timer = setTimeout(() => {
              value = newValue;
              trigger(); // 调用trigger函数，Vue才会重新解析模板
            }, delay);
          },
        };
      });
    }

    return {
      keyword,
    };
  },
};
</script>

<style>
#app {
  /* font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px; */
}
</style>
