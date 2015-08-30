TrelloApp.Models.List = Backbone.Model.extend({
  initialize: function (options) {
    this.board = options.board;
  },
  urlRoot: function () { return this.board.url() + "/lists"; },

  parse: function (payload) {
    if (payload.cards) {
      this.cards().set(payload.cards);
      delete payload.cards;
    }

    return payload;
  },

  cards: function () {
    if (!this._cards) {
      this._cards = new TrelloApp.Collections.Cards([], {list: this});
    }

  return this._cards;
  }
});
