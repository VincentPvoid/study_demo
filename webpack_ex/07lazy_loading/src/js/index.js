// import {mul} from './07lazy';

// eslint-disable-next-line
console.log('this is index.js')


document.getElementById('btn').onclick = function () {
  // 普通绑定方法
  // console.log( mul(2, 5) );

  // 懒加载
  import( /* webpackChunkName: 'test07' */'./07lazy').then(({mul}) => {
    console.log(mul(2, 5));
  })

  // 懒加载+预加载
  // import( /* webpackChunkName: 'test07', webpackPrefetch: true */'./07lazy').then(({ mul }) => {
  //   console.log(mul(2, 5));
  // });
}