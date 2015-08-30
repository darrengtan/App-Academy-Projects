TrelloApp.Models.Card = Backbone.Model.extend({
  initialize: function (options) {
    this.list = options.list;
  },

  urlRoot: function () { return this.list.url() + "/cards"; }
});
