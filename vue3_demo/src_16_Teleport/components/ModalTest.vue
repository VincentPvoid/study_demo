<template>
  <div>
    <button @click="isShowModal = true">show Modal</button>
    <!-- 除了使用标签名称定位之外，还可以使用id锚点的方式进行定位 -->
    <!-- <teleport to="body"> -->
    <teleport to="#app">
      <div class="mask" v-if="isShowModal">
        <div class="main-modal">
          <h3>Just A Modal</h3>
          <p>Lorem ipsum dolor sit amet.</p>
          <p>Lorem ipsum dolor sit amet.</p>
          <p>Lorem ipsum dolor sit amet.</p>
          <p>Lorem ipsum dolor sit amet.</p>
          <button @click="isShowModal = false">close Modal</button>
        </div>
      </div>
    </teleport>
  </div>
</template>

<script>
import { ref } from "vue";

export default {
  name: "ModalTest",
  setup() {
    let isShowModal = ref(false);
    return {
      isShowModal,
    };
  },
};
</script>

<style>
.mask {
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  background: #0005;
}
.main-modal {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 300px;
  height: 300px;
  padding:20px 10px ;
  background: yellowgreen;
}
</style>