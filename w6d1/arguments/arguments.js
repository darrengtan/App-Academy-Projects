var sum = function () {
  var result = 0;
  for (var i = 0; i < arguments.length; i++) {
    result += arguments[i];
  }

  return result;
};

Function.prototype.myBind = function (context) {
  var bindArgs = Array.prototype.slice.call(arguments, 1);
  var fn = this;

  return function () {
    var args = Array.prototype.slice.call(arguments);
    return fn.apply(context, bindArgs.concat(args));
  };
};

var curriedSum = function(numArgs) {
  var numbers = [];

  var _curriedSum = function (number) {
    numbers.push(number);

    if (numbers.length === numArgs) {
      return numbers.reduce(function(a, b) {
        return a + b;
      });
    } else {
      return _curriedSum;
    }
  };

  return _curriedSum;
};

Function.prototype.curry = function (numArgs) {
  var collection = [];
  var fn = this;

  var _curriedFunc = function (element) {
    collection.push(element);

    if (collection.length === numArgs) {
      return fn.apply(fn, collection);
    } else {
      return _curriedFunc;
    }
  };
  return _curriedFunc;
};

console.log(sum.curry(4)(1)(2)(3)(4));
