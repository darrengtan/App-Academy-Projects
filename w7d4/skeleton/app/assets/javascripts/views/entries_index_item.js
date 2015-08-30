NewsReader.Views.EntriesIndexItem = Backbone.View.extend({
  template: JST["entries_index_item"],
  tagName: 'li',
  className: 'entries-list-item',

  render: function () {
    this.$el.html(this.template({ entry: this.model }));

    return this;
  }
});
