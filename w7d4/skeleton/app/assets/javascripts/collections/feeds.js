NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "api/feeds",
  model: NewsReader.Models.Feed,

  getOrFetch: function (id) {
    var feeds = this;
    var feed;
    if (feed = feeds.get(id)) {
      this.fetchListen(feed);
      feed.fetch();
    } else {
      feed = new NewsReader.Models.Feed({ id: id });
      this.fetchListen(feed);
      feeds.add(feed);
      feed.fetch({
        error: function () { feeds.remove(feed); }
      });
    }

    return feed;
  },

  fetchListen: function (feed) {
    feed.listenTo(feed, "fetch", function () {
      this.fetching = true;
    }.bind(feed));
  }
});
