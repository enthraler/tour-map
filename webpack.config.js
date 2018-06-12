const WebpackConfigMaker = require("cultureamp-front-end-scripts/webpack-config-maker");

const configMaker = new WebpackConfigMaker();
configMaker.registerLoader('haxe-loader', {
  options: {}
});
configMaker.setSourceDirectories(['./', 'src']);
configMaker.addRule({
  extension: 'hxml',
  loader: 'haxe-loader'
});
configMaker.usePresets([
  require("cultureamp-front-end-scripts/config/webpack/presets/react-dev-tools.js"),
  require("cultureamp-front-end-scripts/config/webpack/presets/sass-postcss.js")
]);
configMaker.setEntryPoint('build.hxml');

const config = configMaker.generateWebpackConfig();
config.externals = [
  "css!https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,600"
];
config.devServer.host = '0.0.0.0';
module.exports = config;
