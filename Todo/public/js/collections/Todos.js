define([
  'backbone',
  'models/Todo',
], function (Backbone, Todo) {
  "use strict";

  var Todos = Backbone.Collection.extend({
    model: Todo,

    url: '/api/todos',

    parse: function (resp) {
      return resp.items;
    },

  });

  return Todos;
});
