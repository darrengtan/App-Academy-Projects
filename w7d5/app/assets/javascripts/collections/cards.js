TrelloApp.Collections.Cards = Backbone.Collection.extend({
  initialize: function (models, options) {
    this.list = options.list;
  },

  url: function () { return this.list.url() + "/cards"; },

  comparator: "ord",

  getOrFetch: function (id) {
    var card = this.get(id);
    if (!card) {
      card = new NewsReader.Models.Card({ id: id });
      card.fetch({
        success: function() {
          this.add(card);
        }.bind(this)
      });
    } else {
      card.fetch();
    }

    return card;
  }
});
