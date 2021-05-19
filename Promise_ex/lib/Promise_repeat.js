(function (window) {
  const PENDING = 'pending';
  const RESOLVED = 'resolved';
  const REJECTED = 'rejected';

  function Promise(excutor) {
    const self = this;

    self.status = PENDING;
    self.data = undefined;
    self.callbacks = [];



    function resolve(value) {
      if (self.status != PENDING) {
        return;
      }

      self.status = RESOLVED;
      self.data = value;
      if (self.callbacks.length > 0) {
        setTimeout(() => {
          callbacks.forEach(callbacksObj => {
            callbacksObj.onResolved(value)
          })
        })
      }
    }

    function reject(reason) {
      if (self.status != PENDING) {
        return;
      }

      self.status = REJECTED;
      self.data = reason;
      if (self.callbacks.length > 0) {
        setTimeout(() => {
          callbacks.forEach(callbacksObj => {
            callbacksObj.onRejected(reason);
          })
        })
      }
    }

    try {
      excutor(resolve, reject)
    } catch (error) {
      reject(error)
    }
  }

  Promise.prototype.then = function (onResolved, onRejected) {
    const self = this;

    onResolved = typeof onResolved === 'function' ? onResolved : value => value
    onRejected = typeof onRejected === 'function' ? onRejected : reason => { throw reason }

    return new Promise((resolve, reject) => {
      function handle(callback) {
        try {
          const result = callback(self.data);
          if (result instanceof Promise) {
            result.then(resolve, result)
          } else {
            resolve(result)
          }
        } catch (error) {
          reject(error)
        }
      }
      if (self.status === RESOLVED) {
        setTimeout(() => {
          handle(onResolved)
        })
      } else if (self.status === REJECTED) {
        setTimeout(() => {
          handle(onRejected)
        })
      } else {
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

  Promise.prototype.catch = function (onRejected) {
    return this.then(null, onRejected)
  }

  Promise.resolve = function (value) {
    return new Promise((resolve, reject)=>{
      if(value instanceof Promise){
        value.then(resolve, reject)
      }else{
        resolve(value)
      }
    })
  }

  Promise.reject = function (reason) {
    return new Promise((resolve, reject) =>{
      reject(reason)
    })
  }

  Promise.all = function (promises) {
    let values = new Array(promises.length);
    let resolvedCount = 0;

    return new Promise((resolve, reject) => {
      promises.forEach((p, index) => {
        Promise.resolve(p).then(
          value => {
            values[index] = value;
            resolvedCount++;
            if(promises.length === resolvedCount){
              resolve(values)
            }
          },
          reason => {
            reject(reason)
          }
        )
      })
    })
    
  }
  Promise.race = function (promises) {
    return new Promise((resolve, reject) => {
      promises.forEach(p => {
        Promise.resolve(p).then(
          value => {
            resolve(value);
          },
          reason => {
            reject(reason)
          }
        )
      })
    })
  }

})(window)