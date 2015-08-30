JournalApp.Views.PostForm = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
    this.method = options.method;
    // this._errors = []; HANDLE THIS IN TEMPLATE
  },

  template: JST['post_form'],

  events: {
    "submit form": "submitForm"
  },

  render: function () {
    this.$el.html(this.template({ post: this.model, method: this.method }));
    return this;
  },

  submitForm: function (e) {
    e.preventDefault();
    var formData = $(e.currentTarget).serializeJSON();
    this.model.save(formData.post, {

      success: function () {
        this.collection && this.collection.add(this.model);
        Backbone.history.navigate(
          "posts/" + this.model.escape("id"), { trigger: true }
        );
      }.bind(this),

      error: function (XMLHttpRequest, textStatus, errorThrown) {
        var $ul = $("ul.errors");
        $ul.empty();
        var errors = textStatus.responseJSON;
        _.each(errors, function (value, err) {
          var $li = $('<li>');
          $li.html(err + " " + value);
          $ul.append($li);
        });

        // HANDLE THIS IN TEMPLATE
      }.bind(this)

    });
  }
});
