define([
  'jquery',
  'backbone',
  'models/Todo',
  'collections/Todos',
  'views/TodoView',
], function ($, Backbone, Todo, Todos, TodoView) {
  var App = Backbone.View.extend({
    events: {
      'keypress input[name="todo"]': 'inputChange',
      'click #create': 'createTodo',
    },

    initialize: function () {
      this.collection = new Todos()

      _.bindAll(this, 'render');
      this.listenTo(this.collection, 'reset', this.addAll);
      this.listenTo(this.collection, 'add', this.add);

      this.collection.fetch({
        reset: true,
      });
    },

    inputChange: function (e) {
      if (e.keyCode != 13/* Enter */) return;
      this.createTodo(e);
    },

    createTodo: function (e) {
      this.collection.create({
        todo: this.getInputVal()
      });

      this.clearInput();
    },

    getInputVal: function () {
      return $('input[name="todo"]').val();
    },

    clearInput: function () {
      $('input[name="todo"]').val('');
    },

    add: function (todo) {
      var view = new TodoView({
        model: todo,
      });
      this.$('#todo-table').append(view.render().el);
    },

    addAll: function () {
      this.collection.each(this.add, this);
    },

    render: function () {
      return this;
    },
  });

  return App;
});
