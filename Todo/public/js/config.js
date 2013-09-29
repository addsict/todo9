require = {
  baseUrl: '/js',
  paths: {
    jquery: 'vendor/jquery.min',
    backbone: 'vendor/backbone',
    underscore: 'vendor/underscore',
    bootstrap: 'vendor/bootstrap.min',
  },
  shim: {
    jquery: {
      exports: '$',
    },
    underscore: {
      exports: '_',
    },
    backbone: {
      deps: ['jquery', 'underscore'],
      exports: 'Backbone',
    },
  },
  urlArgs: "bust=" + (new Date()).getTime(), // for busting cache
};
