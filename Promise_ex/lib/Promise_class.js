/*
自定义Promise函数模块IIFE
*/

(function (window) {

  const PENDING = 'pending';
  const RESOLVED = 'resolved';
  const REJECTED = 'rejected';

  class Promise {
    /*
    Promise构造函数
    excutor：执行器函数（同步执行）
    */
    constructor(excutor) {
      // 保存当前的promise实例对象
      const self = this;

      self.status = PENDING;  // 给promise对象指定status属性，初始值为pending
      self.data = undefined; // 给promise对象指定一个用于存储结果数据的属性
      self.callbacks = []; // 每个元素的结构：{onResolved(){}, onRejected(){}}

      function resolve(value) {
        // 如果当前状态不是pending，直接结束
        if (self.status != PENDING) {
          return;
        }
        // 将状态改为resolved
        self.status = RESOLVED;
        // 保存value数据
        self.data = value;
        // 如果有待执行的callbacks函数，立即异步执行回调函数onResolved()
        if (self.callbacks.length) {
          setTimeout(() => { // 放入队列中执行所有成功的回调；为了放入队列中异步执行因此需要使用定时器
            self.callbacks.forEach(callbacksObj => {
              callbacksObj.onResolved(value);
            })
          })
        }
      }

      function reject(reason) {
        // 如果当前状态不是pending，直接结束
        if (self.status != PENDING) {
          return;
        }
        // 将状态改为rejected
        self.status = REJECTED;
        // 保存reason数据
        self.data = reason;
        // 如果有待执行的callbacks函数，立即异步执行回调函数onRejected()
        if (self.callbacks.length) {
          setTimeout(() => { // 放入队列中执行所有失败的回调；为了放入队列中异步执行因此需要使用定时器
            self.callbacks.forEach(callbacksObj => {
              callbacksObj.onRejected(reason);
            })
          })
        }
      }

      // 立即同步执行excutor
      try {
        excutor(resolve, reject)
      } catch (error) { // 如果执行器抛出异常，promise对象变为rejected状态
        reject(error)
      }
    }

    /*
    Promise原型对象的then()
    指定成功和失败的回调函数
    返回一个新的promise对象
    返回promise的结果由onResolved/onRejected执行的结果决定
    */

    then(onResolved, onRejected) {
      const self = this;

      // 指定回调函数的默认值（必须是函数）
      onResolved = typeof onResolved === 'function' ? onResolved : value => value;
      onRejected = typeof onRejected === 'function' ? onRejected : reason => {
        throw reason
      };

      // 返回一个新的promise
      return new Promise((resolve, reject) => {

        /*
        执行指定的回调函数
        根据执行的结果改变return的promise的状态/数据
        */
        function handle(callback) {
          /*
          返回promise的结果由onResolved/onRejected执行的结果决定
          1. 抛出异常，当前返回的promise的结果为失败，reason为异常
          2. 返回的是promise，当前返回的promise的结果就是这个结果
          3. 返回的不是promise，当前返回的promise为成功，value就是返回值
          */
          try {
            const result = callback(self.data);
            if (result instanceof Promise) { // 2. 返回的是promise，当前返回的promise的结果就是这个结果
              /**
               * result.then(
               * value => resolve(value),
               * reason => resolve(reason)
               * )
               */
              result.then(resolve, reject)
            } else { // 3. 返回的不是promise，当前返回的promise为成功，value就是返回值
              resolve(result);
            }
          } catch (error) { // 1. 抛出异常，当前返回的promise的结果为失败，reason为异常
            reject(error)
          }
        }

        // 当前promise的状态是resolved
        if (self.status === RESOLVED) {
          // 立即异步执行成功的回调函数
          setTimeout(() => {
            handle(onResolved)
          })
        } else if (self.status === REJECTED) { // 当前promise的状态是rejected
          // 立即异步执行失败的回调函数
          setTimeout(() => {
            handle(onRejected)
          })
        } else { // 当前promise的状态是pending 
          // 将成功和失败的回调函数保存到callbacks容器中缓存起来
          self.callbacks.push({
            onResolved(value) {
              handle(onResolved)
            },
            onRejected(reason) {
              handle(onRejected)
            }
          })
        }
      })
    }


    /*
    Promise原型对象的catch()
    指定失败的回调函数
    返回一个新的promise对象
    */
    catch(onRejected) {
      return this.then(null, onRejected);
    }


    /* 
    Promise函数对象的resolve方法
    返回一个指定结果（value）的成功的promise
    */
    static resolve(value) {
      // 返回一个promise（可能成功也可能失败，状态不确定）
      return new Promise((resolve, reject) => {
        if (value instanceof Promise) { // 使用value的结果作为promise的结果
          value.then(resolve, reject)
        } else { // value不是promise；promise变为成功，数据是value
          resolve(value);
        }
      })
    }

    /* 
    Promise函数对象的reject方法
    返回一个指定reason的失败的promise
    */
    static reject(reason) {
      // 返回一个失败的promise
      return new Promise((resolve, reject) => {
        reject(reason);
      })
    }

    /* 
    Promise函数对象的all方法
    返回一个promise, 只有当所有proimse都成功时才成功, 否则只要有一个失败的就失败
    */
    static all(promises) {
      // 用来保存所有成功value的数组
      const values = new Array(promises.length);
      // 用来保存成功promise的数量
      let resolvedCount = 0;
      // 返回一个新的promise
      return new Promise((resolve, reject) => {
        // 遍历promises获取每个promise的结果
        promises.forEach((p, index) => {
          Promise.resolve(p).then(
            value => {
              resolvedCount++;  // 成功的数量加1
              // p成功，将成功的value按原数组顺序保存到values中
              values[index] = value;
              // 如果全部成功了，将return的promise变为成功
              if (resolvedCount === promises.length) {
                resolve(values)
              }
            },
            reason => { // 只要一个失败了，return的promise就失败
              reject(reason)
            }
          )
        })
      })
    }

    /* 
    Promise函数对象的race方法
    返回一个promise, 其结果由第一个完成的promise决定
    */
    static race(promises) {
      // 返回一个新的promise
      return new Promise((resolve, reject) => {
        // 遍历promises获取每个promise的结果
        promises.forEach(p => {
          Promise.resolve(p).then(
            value => { // 一旦有p成功了，将return的promise变为成功
              resolve(value)
            },
            reason => { // 一旦有p失败了，将return的promise变为失败
              reject(reason)
            }
          )
        })
      })
    }

    /*
    返回一个指定的promise，它在指定的时间后才确定结果
    */
    static resolveDelay(value, time) {
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          if (value instanceof Promise) { // 使用value的结果作为promise的结果
            value.then(resolve, reject)
          } else { // value不是promise；promise变为成功，数据是value
            resolve(value)
          }
        }, time)
      })
    }


    /*
    返回一个指定的promise，它在指定的时间后才失败
    */
    static rejectDelay(reason, time) {
      // 返回一个失败的promise
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          reject(reason)
        }, time)
      })
    }



  }







  // 向外暴露promise函数
  window.Promise = Promise
})(window)
