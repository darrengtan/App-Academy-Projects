NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST["feed_show"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.collection, 'add', this.addEntriesIndexView);
    this.collection.each(this.addEntriesIndexView.bind(this));
  },

  addEntriesIndexView: function (entry) {
    var subview = new NewsReader.Views.EntriesIndexItem({ model: entry });
    this.addSubview('ul.entries-list', subview);
  },

  renderLoadingScreen: function () {
    this.$el.append(JST["ball_loader"]());
  },

  render: function () {
    this.$el.html(this.template( {feed: this.model, feeds: this.collection }));
    if (this.model.fetching) {
      this.$el.append(JST["ball_loader"]());
      this.model.fetching = false;
      return this;
    }
    this.model.entries().each(function (entry) {
      this.addEntriesIndexView(entry);
    }.bind(this));
    // debugger;
    this.$('.label').removeClass('selected');
    this.$('.label.' + this.model.escape('id')).addClass('selected');

    return this;
  }
});
