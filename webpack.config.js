// Import external libraries
const path = require('path')
const webpack = require("webpack")
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
const VueLoaderPlugin = require('vue-loader/lib/plugin')

// Define our compiled asset files
const jsOutputTemplate = 'javascripts/application.js'
const cssOutputTemplate = 'stylesheets/application.css'

module.exports = {
  mode: 'development',
  // Define our asset directory
  context: path.join(__dirname, '/app/assets'),

  entry: [
    './javascripts/application.js',
    './stylesheets/application.sass'
  ],

  // Define where to save assets to
  output: {
    path: path.join(__dirname, '/public'),
    filename: jsOutputTemplate
  },

  // Define how different file types should be transpiled
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader?presets[]=es2015',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      },
      {
        test: /\.vue$/,
        use: [
          {
            loader: 'vue-loader'
          }
        ]
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'sass-loader',
        ],
      },
      {
        test: /\.(woff2?|svg)$/,
        use: [
          {
            loader: 'url-loader?limit=10000'
          }
        ]
      },
      {
        test: /\.(ttf|eot)$/,
        use: [
          {
            loader: 'file-loader'
          }
        ]
      },
    ],
  },
  plugins: [
    new MiniCssExtractPlugin(
      {
        filename: cssOutputTemplate,
      }
    ),
    new VueLoaderPlugin()
  ],
  resolve: {
    alias: {
      $: 'jquery',
      jQuery: 'jquery',
      'window.jQuery': 'jquery',
      'vue$': 'vue/dist/vue.esm.js'
    },
    extensions: ['*', '.js', '.vue', '.json']
  }
}
