(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var view = this;
    $('.square').click(function (event) {
      var $square = $(event.currentTarget);
      view.makeMove($square);
    });
  };

  View.prototype.makeMove = function ($square) {
    var pos = $square.data().pos;
    var currentPlayerClass = this.game.currentPlayer;

    try {
      this.game.playMove(pos);
      $square.addClass("full-square").addClass(currentPlayerClass);
      $square.text(currentPlayerClass.toUpperCase());
    }
    catch (MoveError) {
      alert("That move was invalid!");
    }
    finally {
      var $endMsg = $(".end-msg")

      if (this.game.isOver()) {
        $('.square').off();
        var gameWinner = this.game.winner();

        if (gameWinner !== null) {
          $endMsg.text(gameWinner.toUpperCase() + " wins! Congratulations!");
          return;
        }
        
        $endMsg.text("It's a draw!")
        return;
      }
    }
  };

  View.prototype.setupBoard = function () {
    for (var i = 0; i < 3; i++) {
      var rowClass = "row"
      var $row = $("<ul>").addClass(rowClass);

      for (var j = 0; j < 3; j++) {
        var squareClass = "square"
        var $square = $("<li>").data("pos", [i, j]).addClass(squareClass);
        $row.append($square);
      }
      this.$el.append($row);
    }
  };
})();
