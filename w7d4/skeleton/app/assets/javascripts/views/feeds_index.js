NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST["feeds_index"],

  tagName: 'ul',
  className: 'feeds-list',

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    this.$el.html(this.template());

    this.collection.each(function (feed) {
      var indexItem = new NewsReader.Views.FeedsIndexItem({
        model: feed
      });
      this.$el.append(indexItem.render().$el);
    }.bind(this));

    return this;
  }
});
