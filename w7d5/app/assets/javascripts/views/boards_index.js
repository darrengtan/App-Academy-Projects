TrelloApp.Views.BoardsIndex = Backbone.CompositeView.extend({
  template: JST['boards/index'],

  initialize: function () {
    this.listenTo(this.collection, "add", this.addBoardSubview);
    this.listenTo(this.collection, "sync add remove", this.render);
    this.collection.each(this.addBoardSubview.bind(this));
  },

  events: {
    "submit .new-board-form": "addBoard"
  },

  addBoardSubview: function (board) {
    var boardListItem = new TrelloApp.Views.BoardsListItem({ model: board });
    this.addSubview("ul.boards-list", boardListItem);
  },

  render: function () {
    this.$el.html(this.template());
    this.attachSubviews();
    return this;
  },

  addBoard: function (e) {
    e.preventDefault();
    var title = this.$(".new-board-title").val();
    var board = new TrelloApp.Models.Board({ title: title });
    board.save({}, {
      success: function () {
        this.collection.add(board);
        Backbone.history.navigate("boards/" + board.escape("id"), { trigger: true });
      }.bind(this)
    });
  }
});
