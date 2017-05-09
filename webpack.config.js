// Import external libraries
const path = require('path')
const webpack = require("webpack")

// Define our compiled asset files
const jsOutputTemplate = 'javascripts/application.js'

module.exports = {
  // Remove this if you are not using Docker
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000,
    ignored: /node_modules/
  },

  // Define our asset directory
  context: path.join(__dirname, '/app/assets'),

  // What js / CSS files should we read from and generate
  entry: {
    application: ['bootstrap-loader', './javascripts/application.js']
  },

  // Define where to save assets to
  output: {
    path: path.join(__dirname, '/public'),
    filename: jsOutputTemplate
  },

  // Define how different file types should be transpiled
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: 'babel-loader',
      query: {
        presets: ['es2015']
      },
    },
    {
      test: /.vue$/,
      loader: 'vue-loader',
      exclude: /node_modules/,
    },
    { test: /bootstrap-sass\/assets\/javascripts\//, loader: 'imports-loader?jQuery=jquery' },
    { test: /\.(woff2?|svg)$/, loader: 'url-loader?limit=10000' },
    { test: /\.(ttf|eot)$/, loader: 'file-loader' },
    ]
  },

  plugins: [
    new webpack.ProvidePlugin({
      Vue: 'vue',
    }),
  ],

  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.common.js'
    }
  }

}
