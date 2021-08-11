/*
webpack.config.js webpack的配置文件
作用：指示webpack 干哪些活（当运行webpack指令时，会加载里面的配置）
*/

const { resolve } = require('path');
// 使用plugins的配置需要下载html-webpack-plugin模块并引入
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'bulit.js',
    path: resolve(__dirname, 'build')
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use:
          [ // 需要下载style-loader和css-loader
            'style-loader',
            'css-loader'
          ]
      },
      {
        test: /\.less$/,
        use:
        ['style-loader', 
        'css-loader', 
        // 需要下载less-loader和less
        'less-loader']
      },
      {
        test: /\.(png|jpg)$/,
        // 需要下载url-loader和file-loader
        loader:'url-loader',
        options: {
          limit: 4 * 1024,
          // 给图片进行重命名
          // [hash:10]取图片hash的前10位
          // [ext]取文件原来的扩展名
          name: '[hash:10].[ext]'
        }
      },
      {
        test: /\.html$/,
        // 处理html文件的img图片
        loader: 'html-loader'
      }
    ]
  },
  plugins:[
    new HtmlWebpackPlugin({
      template: './src/test1.html'
    })
  ],
  mode: 'development'
  // mode: 'production'
}