TrelloApp.Views.ListForm = Backbone.View.extend({
  template: JST["lists/list_form"],
  tagName: "form",

  events: {
    "click .list-form-submit": "submit"
  },

  submit: function (e) {
    e.preventDefault();
    var listTitle = this.$(".list-title").val();
    this.model.set("title", listTitle);
    this.model.save({}, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate("boards/" + this.model.escape("board_id"), { trigger: true });
      }.bind(this)
    });
  },

  render: function () {
    this.$el.html(this.template({ list: this.model }));
    return this;
  }
});
