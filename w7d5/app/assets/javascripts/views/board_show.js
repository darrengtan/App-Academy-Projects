TrelloApp.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["boards/board_show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);

    this.listenTo(this.model.lists(), "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.addListSubview);
    this.model.lists().each(this.addListSubview.bind(this));

    this.listenTo(this.model.cards(), "sync", this.render);
    this.listenTo(this.model.cards(), "add", this.addCardSubview);
    this.model.cards().each(this.addCardSubview.bind(this));
  },

  render: function () {
    this.$el.html(this.template({ board: this.model }));
    var lists = this.model.lists();
    lists.each(this.addListSubview.bind(this));

    var cards = this.model.cards();
    cards.each(this.addCardSubview.bind(this));
    return this;
  },

  events: {
    "click .delete": "deleteBoard",
    "click .new-list-form": "addNewListForm",
    "click .new-card-form": "addNewCardForm"
  },

  addCardSubview: function (card) {
    var listShowCardItem = new TrelloApp.Views.ListShowCardItem({ model: card });
    this.addSubview("ul.list-" + card.escape("list_id"), listShowCardItem);
  },

  addListSubview: function (list) {
    var boardShowListItem = new TrelloApp.Views.BoardShowListItem({ model: list });
    this.addSubview("ul.lists-list", boardShowListItem);
  },

  deleteBoard: function (e) {
    e.preventDefault();
    this.model.destroy();
    this.remove();

    Backbone.history.navigate("", { trigger: true });
  },

  addNewListForm: function (e) {
    e.preventDefault();
    this.$(".list-form").empty();
    var list = new TrelloApp.Models.List({ board: this.model });
    var listFormSubview = new TrelloApp.Views.ListForm({
      model: list,
      collection: this.model.lists()
    });

    this.addSubview(".list-form", listFormSubview);
  },

  addNewCardForm: function (e) {
    e.preventDefault();
    this.$(".card-form").empty();
    var listId = $(e.currentTarget).data("id");
    var list = this.model.lists().get(listId);
    var card = new TrelloApp.Models.Card({ list: list });
    var cardFormSubview = new TrelloApp.Views.CardForm({
      model: card,
      collection: this.model.cards()
    });

    this.addSubview(".list-" + listId, cardFormSubview);
  }
});
