
const {resolve} = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './src/js/index.js',
  output: {
    filename: 'js/[name].built.[contenthash:10].js',
    path: resolve(__dirname, 'build')
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/07lazy.html'
    })
  ],
  mode: 'production',
  optimization: {
    splitChunks: {
      chunks: 'all'
    }
  }
}