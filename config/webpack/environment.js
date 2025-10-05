require("dotenv").config();

const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

// CSS loader
environment.loaders.append('style', {
  test: /\.css$/,
  use: ['style-loader', 'css-loader']
});

// SASS loader
environment.loaders.append('sass', {
  test: /\.scss$/,
  use: ['style-loader', 'css-loader', 'sass-loader']
});

// jQuery plugin
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
);

module.exports = environment;