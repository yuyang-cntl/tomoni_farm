const envPath = process.env.NODE_ENV === 'production' ? '.env.production' : '.env';
require("dotenv").config({ path: envPath });


const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
);
environment.plugins.append(
  "DefinePlugin",
  new webpack.DefinePlugin({
    "process.env.GOOGLE_MAPS_API_KEY": JSON.stringify(process.env.GOOGLE_MAPS_API_KEY),
    "process.env.OPENAI_API_KEY": JSON.stringify(process.env.OPENAI_API_KEY)
  })
);

module.exports = environment