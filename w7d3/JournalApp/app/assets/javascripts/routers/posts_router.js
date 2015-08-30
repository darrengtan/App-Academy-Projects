JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.collection = options.collection;
    this.$rootEl = options.$rootEl;
    this.$sidebar = options.$sidebar;

    this.collection.fetch();
    this._postsIndex = new JournalApp.Views.PostsIndex({
      collection: this.collection
    });
    this.$sidebar.html(this._postsIndex.$el);
  },

  routes: {
    "" : "root",
    "posts" : "postsIndex",
    "posts/new" : "postNew",
    "posts/:id" : "postShow",
    "posts/:id/edit" : "postEdit"
  },

  root: function () {
    this.$rootEl.empty();
    this._view && this._view.remove();
    this._view = null;
    this._postsIndex.refresh();
  },

  postsIndex: function () {
    // var postIndexView = new JournalApp.Views.PostsIndex({ collection: this.collection });
    this._postsIndex.refresh();

    // this._swapView(postIndexView);
    // this.$sidebar.html(postIndexView.$el);
  },

  postShow: function (id) {
    // this.postsIndex();
    var post = this.collection.getOrFetch(id);
    var postShowView = new JournalApp.Views.Post({ model: post });

    this._swapView(postShowView);
  },

  postEdit: function (id) {
    var post = this.collection.getOrFetch(id);
    var postShowView = new JournalApp.Views.PostForm({ model: post, method: "Edit Post" });

    this._swapView(postShowView);
  },

  postNew: function () {
    var post = new JournalApp.Models.Post();
    var postShowView = new JournalApp.Views.PostForm({ model: post, collection: this.collection, method: "New Post" });

    this._swapView(postShowView);
  },

  _swapView: function (view) {
    this._view && this._view.remove();
    this.$rootEl.html(view.render().$el);
    this._view = view;
  }
});
