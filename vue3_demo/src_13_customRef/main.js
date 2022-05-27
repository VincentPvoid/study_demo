// 引入的不再是Vue的构造函数，而是一个名为createApp的工厂函数
import { createApp } from 'vue'
import App from './App.vue'

// 创建应用实例对象app，类似于Vue2中的vm，但app比vm更轻
const app = createApp(App)

// 挂载
app.mount('#app')

// createApp(App).mount('#app')
