TrelloApp.Views.BoardsListItem = Backbone.View.extend({
  template: JST["boards/boards_list_item"],
  tagName: "li",
  className: "boards-list-item",

  render: function () {
    this.$el.append(this.template({ board: this.model }));
    return this;
  }
});
