TrelloApp.Models.Board = Backbone.Model.extend({
  urlRoot: "api/boards",

  parse: function (payload) {
    if (payload.lists) {
      this.lists().set(payload.lists);
      delete payload.lists;
    }

    if (payload.cards) {
      this.cards().set(payload.cards);
      delete payload.cards;
    }

    return payload;
  },

  lists: function () {
    if (!this._lists) {
      this._lists = new TrelloApp.Collections.Lists([], { board: this });
    }

    return this._lists;
  },

  cards: function () {
    if (!this._cards) {
      this._cards = new TrelloApp.Collections.Cards([], { board: this });
    }

    return this._cards;
  }
});
