import '../css/test04.css';
import a from './a';


const b = require('./b');

a('123');
b();


if (module.hot) {
  // 一旦module.hot为true，说明开启了HMR功能
  module.hot.accept('./a.js', () => {
    // 监听要开启HMR功能的js的变化；如果发生变化，其他模块不会重新打包构建
    // 会执行后面的回调函数
    a();
  });
}
