TrelloApp.Collections.Lists = Backbone.Collection.extend({
  model: TrelloApp.Models.List,

  initialize: function (models, options) {
    this.board = options.board;
  },
  url: function () { return this.board.url() + "/lists"; },

  comparator: 'ord',

  getOrFetch: function (id) {
    var list = this.get(id);
    if (!list) {
      list = new NewsReader.Models.List({ id: id });
      list.fetch({
        success: function() {
          this.add(list);
        }.bind(this)
      });
    } else {
      list.fetch();
    }

    return list;
  }
});
