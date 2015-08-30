JournalApp.Views.PostsIndex = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.collection, 'remove reset sync', this.render);
  },

  events: {
    "click .new-post-link" : "postNew"
  },

  template: JST["posts_index"],

  render: function () {
    this.$el.html(this.template({ posts: this.collection }));
    this.collection.each(function (post) {
      var postItemView = new JournalApp.Views.PostsIndexItem({ model: post });
      this.$('ul.post-index-list').append(postItemView.render().$el);
    }.bind(this));

    return this;
  },

  refresh: function () {
    this.collection.fetch({ reset: true });
  },

  postNew: function (e) {
    e.preventDefault();
    Backbone.history.navigate("posts/new", { trigger: true });
  }
});
