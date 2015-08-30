$(function ($) {

  $.Zoomable = function (el) {
    this.$el = $(el);
    this.boxSize = 30;
    this.$el.on("mousemove", "img", this.showFocusBox.bind(this));
    // this.$el.on("mouseleave", "img", this.removeFocusBox.bind(this));
  };

  $.Zoomable.prototype.showFocusBox = function (e) {
    if (!this.$focusBox) {
      this.$focusBox = $('<div class="focus-box">');
      this.$focusBox.css("width", this.boxSize + "px");
      this.$focusBox.css("height", this.boxSize + "px");
      this.$el.append(this.$focusBox);
    }

    var midpoint = this.boxSize / 2;
    this.$focusBox.css("left", (e.offsetX - midpoint) + "px");
    this.$focusBox.css("top", (e.offsetY - midpoint) + "px");
  };

  $.Zoomable.prototype.removeFocusBox = function (e) {
    $('div.focus-box').remove();
    this.$focusBox = undefined;
  };

  $.fn.zoomable = function () {
    return this.each(function () {
      new $.Zoomable(this);
    });
  };

}(jQuery));
