window.TrelloApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('div.main-content');
    var boards = new TrelloApp.Collections.Boards();
    new TrelloApp.Routers.TrelloAppRouter({ $rootEl: $rootEl, collection: boards });
    Backbone.history.start();
  }
};
