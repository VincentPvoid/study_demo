// 1. 引入express
const express = require('express')

// 2. 创建应用对象
const app = express()

// 3. 创建路由规则
// request 是对请求报文的封装
// response 是对响应报文的封装
app.get('/server', (request, response) => {
  // 设置响应头 设置允许跨域
  response.setHeader('Access-Control-Allow-Origin', '*')

  // 设置响应体
  response.send('AJAX TEXT')
})

// app.post('/server', (request, response) => {
//   // 设置响应头 设置允许跨域
//   response.setHeader('Access-Control-Allow-Origin', '*')
//   // 设置可以接收所有类型的头信息
//   response.setHeader('Access-Control-Allow-Headers','*')
//   // 设置响应体
//   response.send('AJAX POST TEXT')
// })

// 因为跨域请求会先发送预请求（OPTIONS方法），只设置为post则无法相应该请求，因此要设置为all
app.all('/server', (request, response) => {
  // 设置响应头 设置允许跨域
  response.setHeader('Access-Control-Allow-Origin', '*')
  // 设置可以接收所有类型的头信息
  response.setHeader('Access-Control-Allow-Headers','*')
  // 设置响应体
  response.send('AJAX POST TEXT')
})

// all可以接收任意类型的请求
app.all('/json-server', (request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  response.setHeader('Access-Control-Allow-Headers','*')
  // 响应一个数据
  const data = {
    name:'json_test'
  }
  // 把对象转换为字符串
  const str = JSON.stringify(data)
  // 设置响应体
  response.send(str)
})

// ie缓存问题
app.get('/ie',(request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  response.send('deal with ie cache')
})

// 超时与网络异常
app.get('/delay', (request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  setTimeout(()=> {
    response.send('delay')
  }, 3000)
})

// jQuery服务
app.all('/jquery-server', (request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  response.setHeader('Access-Control-Allow-Headers','*')
  const data = {name:'jQuery'}
  // response.send('Hello jQuery AJAX')
  response.send(JSON.stringify(data))
})

// axios服务
app.all('/axios-server', (request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  response.setHeader('Access-Control-Allow-Headers','*')
  const data = {name:'axios'}
  response.send(JSON.stringify(data))
})

// fetch服务
app.all('/fetch-server', (request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  response.setHeader('Access-Control-Allow-Headers','*')
  const data = {name:'fetch'}
  response.send(JSON.stringify(data))
})

// jsonp服务；需要返回js代码，否则无法解析
app.all('/jsonp-server', (request, response) => {
  const data = {
    name:'jsonp-name111'
  }
  // 将数据转换为字符串
  let str = JSON.stringify(data)
  // end()不会加特殊响应头
  response.end(`jsonpTest(${str})`)
})

// jsonp案例
app.all('/check-username', (request, response) => {
  const data = {
    exist:1,
    msg:'username is exist'
  }
  // 将数据转换为字符串
  let str = JSON.stringify(data)
  // end()不会加特殊响应头
  response.end(`handle(${str})`)
})

// jQuery-jsonp服务
app.all('/jquery-jsonp-server', (request, response) => {
  const data = {
    name:'jquery-jsonp-test',
    hunters:['Maria', 'Garhem', 'doll']
  }
  // 将数据转换为字符串
  let str = JSON.stringify(data)
  // 接收callback函数
  let cb = request.query.callback;
  // 返回结果
  response.end(`${cb}(${str})`)
})


// 4. 监听端口启动服务
app.listen(8000, ()=>{
  console.log('server is running in port 8000...')
})