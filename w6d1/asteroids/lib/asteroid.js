(function () {
  window.Asteroids = window.Asteroids || {};

  var Asteroid = Asteroids.Asteroid = function (options) {
    this.pos = options.pos;
    this.vel = options.vel || Asteroids.Util.randomVec(Math.random() * 4 + 1);
    this.color = options.color || Asteroid.COLOR;
    this.radius = options.radius || Asteroid.RADIUS;
    this.game = options.game;
  };

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.COLOR = '#000F37';
  Asteroid.RADIUS = 20;

  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject.constructor === Asteroids.Ship){
      otherObject.relocate();
    }
  };
})();
