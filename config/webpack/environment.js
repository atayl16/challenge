const { environment } = require('@rails/webpacker');
const erb = require('./loaders/erb')
const coffee =  require('./loaders/coffee')
const customConfig = require('./custom');
const webpack = require('webpack');

environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
);
environment.config.merge(customConfig);

environment.loaders.prepend('coffee', coffee)
environment.loaders.prepend('erb', erb)
module.exports = environment;
