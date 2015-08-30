TrelloApp.Views.ListShowCardItem = Backbone.View.extend({
  template: JST["cards/list_show_card_item"],
  tagName: "li",

  render: function () {
    this.$el.html(this.template({ card: this.model }));
    return this;
  }

});
