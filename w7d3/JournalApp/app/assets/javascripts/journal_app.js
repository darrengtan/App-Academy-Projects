window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new JournalApp.Routers.PostsRouter({
      collection: new JournalApp.Collections.Posts(),
      $sidebar: $(".sidebar"),
      $rootEl: $(".content")
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
