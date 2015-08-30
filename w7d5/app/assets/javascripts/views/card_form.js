TrelloApp.Views.CardForm = Backbone.View.extend({
  template: JST["cards/card_form"],
  tagName: "form",

  events: {
    "click .card-form-submit": "submit"
  },

  submit: function (e) {
    e.preventDefault();
    var cardTitle = this.$(".card-title").val();
    var cardDescription = this.$(".card-description").val();
    this.model.set("title", cardTitle);
    this.model.save({}, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate("boards/" + this.model.escape("board_id"), { trigger: true });
      }.bind(this)
    });
  },

  render: function () {
    this.$el.html(this.template({ card: this.model }));
    return this;
  }
});
