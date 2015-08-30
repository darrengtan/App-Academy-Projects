JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['posts_index_item'],
  tagName: 'li',

  events: {
    "click .delete-post-index-item" : "deletePost",
    "click .post-item-link": "showPostItem",
    "click .edit-post-link" : "postEdit"
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));
    return this;
  },

  deletePost: function () {
    this.model.destroy();
    this.remove();
  },

  showPostItem: function (e) {
    e.preventDefault();
    Backbone.history.navigate("posts/" + this.model.escape("id"), { trigger: true });
  },

  postEdit: function (e) {
    e.preventDefault();
    Backbone.history.navigate(
      "posts/" + this.model.escape("id") + "/edit", { trigger: true }
    );
  }
});
