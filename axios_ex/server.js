const express = require('express')

const app = express()

app.get('/products1', (request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  setTimeout(() => {
    response.send('请求1响应')
  }, 2000);
})

app.get('/products2', (request, response) => {
  response.setHeader('Access-Control-Allow-Origin', '*')
  setTimeout(() => {
    response.send('请求2响应')
  }, 2000);
})

app.listen(4000, ()=>{
  console.log('server is running in port 4000...')
})