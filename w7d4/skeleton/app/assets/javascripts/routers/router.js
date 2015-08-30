NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "feedsIndex",
    "feeds/:id": "feedShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$sidebar = this.$rootEl.find('#sidebar');
    this.$content = this.$rootEl.find('#content');
    this.collection = new NewsReader.Collections.Feeds();
    this.feedsIndex();
  },

  feedsIndex: function () {
    var view = new NewsReader.Views.FeedsIndex({ collection: this.collection });
    this.collection.fetch();
    this.$sidebar.html(view.render().$el);
  },

  feedShow: function (id) {
    var feed = this.collection.getOrFetch(id);
    var view = new NewsReader.Views.FeedShow({
      model: feed,
      collection: this.collection
    });
    this._swapView(view);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this._view = view;
    this.$content.html(view.render().$el);
  }
});
