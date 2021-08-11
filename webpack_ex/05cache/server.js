const express = require('express');

const app = express();

// 公开静态资源目录，设置缓存时间
app.use(express.static('build', {maxAge: 1000 * 3600}))

app.listen(3000, () => {
  console.log('server is running in port 3000...')
});