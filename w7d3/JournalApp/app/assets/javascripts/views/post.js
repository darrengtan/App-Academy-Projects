JournalApp.Views.Post = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  template: JST["post"],

  events: {
    "click .back-to-index" : "backToIndex",
    "click .edit-post-link" : "postEdit",
    "click .delete-post" : "postDelete",
    "dblclick h2" : "editTitle",
    "dblclick p" : "editBody"
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));
    return this;
  },

  postEdit: function (e) {
    e.preventDefault();
    Backbone.history.navigate(
      "posts/" + this.model.escape("id") + "/edit", { trigger: true }
    );
  },

  postDelete: function (e) {
    e.preventDefault();
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("", { trigger: true });
  },

  backToIndex: function (e) {
    e.preventDefault();
    Backbone.history.navigate("", { trigger: true });
  },

  editTitle: function (e) {
    var $title = $(e.currentTarget);
    
  },

  editBody: function (e) {
    var $body = $(e.currentTarget);
  }

});
