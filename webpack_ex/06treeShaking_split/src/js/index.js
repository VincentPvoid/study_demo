
function sum(...args) {
  args.reduce((acc, cur) => acc + cur, 0);
}


// eslint-disable-next-line
console.log(sum(1, 2, 3));

import(/* webpackChunkName: 'add' */'./test06')
  .then(({ mul, count }) => {
    // 文件加载成功
    // eslint-disable-next-line
    console.log(mul(2, 5));
  })
  .catch(() => {
    // eslint-disable-next-line
    console.log('文件加载失败');
  })