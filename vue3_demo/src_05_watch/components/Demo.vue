<template>
  <div>
    <h1>watch</h1>
    <div>
      <span>sum: {{ sum }} </span>
      <br />
      <button @click="sum++">add 1</button>
    </div>

    <hr />

    <div>
      <span>msg: {{ msg }} </span>
      <br />
      <button @click="msg += '!'">add 1</button>
    </div>

    <hr />

    <div>
      <span>name: {{ hunter.name }}</span>
      <br />
      <span>age: {{ hunter.age }}</span>
      <br />
      <span>salary: {{ hunter.job.salary }}</span>
      <br />
      <button @click="hunter.name += '@'">change name</button>
      <button @click="hunter.age++">change age</button>
      <button @click="hunter.job.salary++">change salary</button>
    </div>
  </div>
</template>

<script>
import { ref, reactive, watch } from "vue";

export default {
  name: "Demo",
  setup() {
    let sum = ref(0);
    let msg = ref("hello world");

    // let hunter = reactive({
    //   name: "Maria",
    //   age: 18,
    //   job: {
    //     type: "hunter",
    //     address: "Astral Clocktower",
    //     salary: 1000,
    //     onlyTest: {
    //       a: {
    //         b: {
    //           c: 123,
    //         },
    //       },
    //     },
    //   },
    // });


    //情况一：监视ref定义的响应式数据
    // watch(
    //   sum,
    //   (newValue, oldValue) => {
    //     console.log("sum changed", newValue, oldValue);
    //   },
    //   { immediate: true } // 是否马上进行watch
    // );



    // //情况二：监视多个ref定义的响应式数据
    // watch([sum, msg], (newValue, oldValue) => {
    //   console.log("sum or msg changed", newValue, oldValue);
    // });



    /* 情况三：监视reactive定义的响应式数据
  		注意：
      1.若watch监视的是reactive定义的响应式数据，则无法正确获得oldValue
  		2.若watch监视的是reactive定义的响应式数据，则强制开启深度监视（deep设置无效） 
    */
    // watch(
    //   hunter,
    //   (newValue, oldValue) => {
    //     console.log("hunter changed", newValue, oldValue);
    //   },
    //   { immediate: true, deep: false }
    // ); //此处的deep配置没有作用；默认开启deep watch（深度监视）



    //情况四：监视reactive定义的响应式数据中的某个属性
    // watch(
    //   () => hunter.age, // 注意此处要写成函数的形式
    //   (newValue, oldValue) => {
    //     console.log("hunter's age changed", newValue, oldValue);
    //   },
    // );

    

    // 情况五：监视reactive定义的响应式数据中的某些属性
    // watch([() => hunter.age, () => hunter.name], (newVal, oldVal) => {
    //   console.log("hunter's age or name changed", newVal, oldVal);
    // });



    // //特殊情况
    // watch(
    //   () => hunter.job,
    //   (newValue, oldValue) => {
    //     console.log("hunter's job changed", newValue, oldValue);
    //   },
    //   // { deep: true }
    // ); //此处由于监视的是reactive所定义的对象中的某个属性，所以此处deep配置有效



    // 测试下方value用，平常使用时对象应该使用reactive函数进行包裹
    let hunter = ref({
      name: 'Maria',
      age: 18,
       job: {
        type: "hunter",
        address: "Astral Clocktower",
        salary: 1000,
        onlyTest: {
          a: {
            b: {
              c: 123,
            },
          },
        },
      },
    })


    // 注意：watch时是否需要添加value的问题；
    // watch的都是对象，不能watch某个具体的值
    // 为ref生成的基本数据类型时，不添加value
    watch(sum, (newVal, oldVal) => {
      console.log('sum is changed', newVal, oldVal)
    })


    // 注意以下两种方式都无法取得oldVal的值

    // 此处watch的是ref生成的RefImpl对象；
    // 如果需要监视其中复杂数据类型的变化，需要使用deep watch；（例子中为hunter.job对象）
    watch(hunter, (newVal, oldVal) => {
      console.log('hunter changed (deep watch)', newVal, oldVal)
    }, {deep: true})
    
    // 此处watch的是ref借助reactive生成的Proxy对象；直接watch了该对象，因此不需要设置deep watch
    // watch(hunter.value, (newVal, oldVal) => {
    //   console.log('hunter changed (value)', newVal, oldVal)
    // },)
    


    return {
      sum,
      msg,
      hunter,
    };
  },
};
</script>

<style>
</style>