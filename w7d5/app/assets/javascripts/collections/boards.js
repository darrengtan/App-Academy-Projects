TrelloApp.Collections.Boards = Backbone.Collection.extend({
  url: "api/boards",
  model: TrelloApp.Models.Board,

  getOrFetch: function (id) {
    var boards = this;
    var board = boards.get(id);

    if (board) {
      board.fetch();
    } else {
      board = new TrelloApp.Models.Board({ id: id });
      boards.add(board);
      board.fetch({ error: function () { boards.remove(board); } });
    }

    return board;
  },

  getOrFetchLists: function (boardId, listId) {
    var boards = this;
    boards.getOrFetch(boardId);
    var list;
    // if () {}
  }
});
