
const { resolve } = require('path');
const HtmlWebpackPlugin= require('html-webpack-plugin');

module.exports = {
  // 单入口
  entry: './src/js/index.js',
  // 多入口
  // entry:{
  //   main: './src/js/index.js',
  //   test: './src/js/test06.js'
  // }
  output: {
    filename: 'js/[name].built.[contenthash:10].js',
    path: resolve(__dirname,'build')
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/06code_split.html'
    })
  ],
  mode: 'production',
  optimization: {
    splitChunks: {
      chunks: 'all'
    }
  }
}