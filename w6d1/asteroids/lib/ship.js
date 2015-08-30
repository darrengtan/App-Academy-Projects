(function () {
  window.Asteroids = window.Asteroids || {};

  var Ship = Asteroids.Ship = function (options) {
    this.game = options.game;
    this.radius = Ship.RADIUS;
    this.color = Ship.COLOR;
    this.vel = [0, 0];
    this.pos = this.game.randomPosition();
  };

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.RADIUS = 8;
  Ship.COLOR = '#FF0000';

  Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
    this.vel = [0,0];
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };









})();
