(function () {
  window.Asteroids = window.Asteroids || {};

  var GameView = Asteroids.GameView = function (ctx) {
    this.game = new Asteroids.Game();
    this.ctx = ctx;
  }

  GameView.prototype.start = function () {
    var currentGame = this
    setInterval(function (){
      currentGame.bindKeyHandlers();
      currentGame.game.draw(currentGame.ctx);
      currentGame.game.checkCollisions();
      currentGame.game.moveObjects();
    }, 20)
  }

  GameView.prototype.bindKeyHandlers = function () {
    var ship = this.game.ship;
    key('w', function () {
      ship.power([0, -0.005]);
    });
    key('a', function () {
      ship.power([-0.005, 0]);
    });
    key('s', function () {
      ship.power([0, 0.005]);
    });
    key('d', function () {
      ship.power([0.005, 0]);
    });

  };








})();
