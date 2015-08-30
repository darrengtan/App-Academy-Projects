Function.prototype.inherits = function (ParentClass) {
  var Surrogate = function () {};
  Surrogate.prototype = ParentClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject(name, size, direction) {
  this.name = name;
  this.size = size;
  this.direction = direction;
}

function Ship(name, size, direction, type) {
  MovingObject.call(this, name, size, direction);
  this.type = type;
}

function Asteroid(name, size, direction) {
  MovingObject.call(this, name, size, direction);
}

Ship.inherits(MovingObject);
Asteroid.inherits(MovingObject);

var ship = new Ship('bob', 'big', 'up', 'fast');
console.log(ship.name);
console.log(ship.type);
var asteroid = new Asteroid('phil', 'really big', 'down');
console.log(asteroid.size);
