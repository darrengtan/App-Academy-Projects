(function () {
  window.Asteroids = window.Asteroids || {};

  var Bullet = Asteroids.Bullet = function (options) {
    this.ship = options.ship;
    this.vel = this.ship.vel;
    this.game = options.game;
    this.pos = this.ship.pos;
  };





  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);







})();
