import '../css/test03.css';


const add = (x, y) => x + y;
console.log(add(1, 2));

const promise = new Promise((resolve) => {
  setTimeout(() => {
    console.log('finish');
    resolve();
  }, 1000);
});

console.log(promise);
