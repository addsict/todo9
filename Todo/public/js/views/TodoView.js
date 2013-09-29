define([
  'jquery',
  'underscore',
  'backbone',
  'models/Todo',
], function ($, _, Baekbone, Todo) {
  var TodoView = Backbone.View.extend({

    tagName: 'tr',

    events: {
      'click .update': 'updateTodo',
      'click .delete': 'deleteTodo',
      'keypress input.todo': 'inputChange',
    },

    initialize: function (opts) {
      this.listenTo(this.model, 'destroy', this.remove);
      this.listenTo(this.model, 'sync', this.sync); // called after server response
    },

    sync: function (e) {
      this.render();
    },

    inputChange: function (e) {
      if (e.keyCode != 13/* Enter */) return;
      this.updateTodo(e);
    },

    updateTodo: function (e) {
      var newTodo = this.$('.todo').val();
      this.model.save({
        todo: newTodo,
      });
    },

    deleteTodo: function (e) {
      this.model.destroy();
    },

    render: function () {
      var template = $('#todo-view-template');
      var html = _.template(template.html(), {
        todo: this.model.toJSON(),
      });
      this.$el.html(html);

      return this;
    },
  });

  return TodoView;
});
