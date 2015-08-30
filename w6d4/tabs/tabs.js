$(function($){

  $.Tabs = function (el) {
    this.$el = $(el);
    this.$contentTabs = $("#" + this.$el.data("content-tabs"));
    this.$activeTab = this.$contentTabs.find(".active");
    this.$el.on("click", "a", function (e) {
      var $currentTarget = $(e.currentTarget);
      this.clickTab($currentTarget);
    }.bind(this));
  };

  $.Tabs.prototype.clickTab = function ($currentTarget) {
    if (this.transitioning) {
      return;
    }

    this.transitioning = true;
    // Toggles active class on a elements
    this.$el.find('.active').removeClass('active');
    $currentTarget.addClass("active");

    // Toggles active class on content divs
    this.$activeTab.removeClass("active").addClass("transitioning");
    this.$activeTab.one("transitionend", function () {
      this.$activeTab.removeClass("transitioning");
      var $newActiveTab = this.$contentTabs.find($currentTarget.attr('for'));
      $newActiveTab.addClass("active transitioning");

      setTimeout(function () {
        $newActiveTab.removeClass("transitioning");
      }, 0);

      this.$activeTab = $newActiveTab;
      this.transitioning = false;
    }.bind(this));
  };

  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };

}(jQuery));
