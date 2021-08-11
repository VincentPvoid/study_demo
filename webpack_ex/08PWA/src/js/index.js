
// eslint-disable-next-line
console.log('index.js');

// 注册serviceWorker
// 处理兼容性问题
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker
      .register('/service-worker.js')
      .then(() => {
        console.log('serviceWorker success');
      })
      .catch(() => {
        console.log('serviceWorker failed...');
      });
  });
}
