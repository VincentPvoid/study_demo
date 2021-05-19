const express = require('express')

const app = express()

app.get('/home', (request, response) => {
  // 响应一个页面
  response.sendFile(__dirname + '/index.html')
})

app.get('/data', (request, response) => {
  // 响应一个页面
  response.send('test data')
})

app.listen(9000, ()=>{
  console.log('server is running in port 9000...')
})