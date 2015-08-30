(function () {
  window.Asteroids = window.Asteroids || {};
  window.Asteroids.Util = window.Asteroids.Util || {};

  Asteroids.Util.inherits = function (ChildClass, ParentClass) {
    function Surrogate() {}
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
    ChildClass.prototype.constructor = ChildClass;
  };

  Asteroids.Util.randomVec = function (length) {
    var x = Math.random() * 2 - 1;
    var y = Math.sqrt(1 - (x * x)) * ((Math.random() >= 0.5) ? 1 : (-1));
    var vector = [(x * length), (y * length)];
    return vector;
  };

})();
