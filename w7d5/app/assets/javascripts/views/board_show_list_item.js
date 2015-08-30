TrelloApp.Views.BoardShowListItem = Backbone.CompositeView.extend({
  template: JST["lists/board_show_list_item"],
  tagName: "li",
  className: "list-list-item",

  render: function () {
    this.$el.html(this.template({ list: this.model }));
    return this;
  }
});
