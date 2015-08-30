TrelloApp.Routers.TrelloAppRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "boardsIndex",
    "boards/:id": "boardShow"
  },

  boardsIndex: function () {
    var view = new TrelloApp.Views.BoardsIndex({ collection: this.collection });
    view.collection.fetch();
    this._swapView(view);
  },

  boardShow: function (id) {
    var board = this.collection.getOrFetch(id);
    var view = new TrelloApp.Views.BoardShow({ model: board });
    this._swapView(view);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
