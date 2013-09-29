define([
  'backbone',
], function (Backbone) {
  "use strict";

  var Todo = Backbone.Model.extend({
    baseUrl: '/api/todos/',

    parse: function (attr) {
      this.url = this.baseUrl + attr.id;
      return attr;
    },

  });

  return Todo;
});
