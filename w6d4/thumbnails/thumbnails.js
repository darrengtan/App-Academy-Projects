$(function () {

  $.Thumbnails = function (el) {
    this.$el = $(el);
    this.$gutterImages = $('.gutter-images img');
    this.gutterIdx = 0;
    this.fillGutterImages.call(this);
    this.$activeImage = this.$gutterImages.eq(0);
    this.activate.call(this, this.$activeImage);

    this.$el.on("click", ".gutter-images img", function (e) {
      var $currentTarget = $(e.currentTarget);
      this.$activeImage = $currentTarget;
      this.activate.call(this, $currentTarget);
    }.bind(this));

    this.$el.on("mouseenter", ".gutter-images img", function (e) {
      var $currentTarget = $(e.currentTarget);
      this.activate.call(this, $currentTarget);
    }.bind(this));

    this.$el.on("mouseleave", ".gutter-images img", function (e) {
      this.activate.call(this, this.$activeImage);
    }.bind(this));

    this.$el.on("click", ".nav", function (e) {
      if ($(e.currentTarget).is(".right")) {
        if (this.gutterIdx === this.$gutterImages.length - 5) {
          return;
        } else {
          this.gutterIdx += 1;
        }
      } else {
        if (this.gutterIdx === 0) {
          return;
        } else {
          this.gutterIdx -= 1;
        }
      }

      this.fillGutterImages();
    }.bind(this));

  };

  $.Thumbnails.prototype.activate = function ($img) {
    this.$el.find('.active').html($img.clone());
  };

  $.Thumbnails.prototype.fillGutterImages = function () {
    this.$el.find(".gutter-images").html(" ");
    for (var i = this.gutterIdx; i < this.gutterIdx + 5; i++) {
      this.$el.find(".gutter-images").append(this.$gutterImages.eq(i));
    }
  };



  $.fn.thumbnails = function () {
    return this.each(function() {
      new $.Thumbnails(this);
    });
  };

}(jQuery));
