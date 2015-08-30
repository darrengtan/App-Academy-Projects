(function () {
  window.Asteroids = window.Asteroids || {};

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
    this.bullets = [];
    this.ship = new Asteroids.Ship({'game': this});
  };

  Game.DIM_X = 1000;
  Game.DIM_Y = 500;
  Game.NUM_ASTEROIDS = 8;

  Game.prototype.addBullets = function () {
    this.bullets.push(new Asteroids.Bullet({'game': this, 'ship': this.ship}));

  };

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.asteroids.push(new Asteroids.Asteroid({'pos': this.randomPosition(), 'game': this}));
    }
  };

  Game.prototype.randomPosition = function () {
    return [Math.random() * Game.DIM_X, Math.random() * Game.DIM_Y];
  };



  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    this.allObjects().forEach(function (spaceThing) {
      spaceThing.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function (spaceThing) {
      spaceThing.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    var wrappedPos = [];
    if (pos[0] >= Game.DIM_X) {
      wrappedPos[0] = Math.abs(pos[0] % Game.DIM_X);
    } else if (pos[0] < 0) {
      wrappedPos[0] = Game.DIM_X - Math.abs(pos[0] % Game.DIM_X);
    } else {
      wrappedPos[0] = pos[0];
    }
    if (pos[1] >= Game.DIM_Y) {
      wrappedPos[1] = Math.abs(pos[1] % Game.DIM_Y);
    } else if (pos[1] < 0) {
      wrappedPos[1] = Game.DIM_Y - Math.abs(pos[1] % Game.DIM_X);
    } else {
      wrappedPos[1] = pos[1];
    }

    return wrappedPos;
  };

  Game.prototype.checkCollisions = function () {
    for (var current = 0; current < this.allObjects().length; current++) {
      for (var other = current + 1; other < this.allObjects().length; other++) {
        var currentObject = this.allObjects()[current];
        var otherObject = this.allObjects()[other];
        if (currentObject.isCollidedWith(otherObject)) {
          currentObject.collideWith(otherObject);
        }
      }
    }
  };

  Game.prototype.remove = function (object) {
    var itemType = object.constructor;
    if (itemType === Asteroids.Bullet) {
      var newBullets = this.bullets.filter(function (el){
        return el !== object;
      });
      this.bullets = newBullets;
    } else if (itemType === Asteroids.Asteroid) {
      var newAsteroids = this.asteroids.filter(function (el){
        return el !== object;
      });
      this.asteroids = newAsteroids;
    }
  };

  Game.prototype.allObjects = function () {
    var all = this.asteroids.slice(0);
    all.push(this.ship);
    all.concat(this.bullets);
    return all;
  };

})();
