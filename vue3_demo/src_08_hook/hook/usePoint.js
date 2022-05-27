import { reactive, onMounted, onBeforeUnmount } from 'vue'

export function usePoint() {

  let point = reactive({
    x:0,
    y:0
  })

  // 保存点击时鼠标位置数据到组件数据中
  function savePoint(event){
    point.x = event.pageX;
    point.y = event.pageY;
    console.log(event.pageX, event.pageY)
  }

  // 挂载时添加鼠标点击事件
  onMounted(() => {
    window.addEventListener('click', savePoint)
  })

  // 卸载组件时移除鼠标点击事件
  onBeforeUnmount(() => {
    window.removeEventListener('click', savePoint)
  })

  return point;

}