Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();
    this.$pokeList.on("click", "li.poke-list-item", this.selectPokemonFromList.bind(this));
    this.$newPoke.on("submit", this.submitPokemonForm.bind(this));
    this.$pokeDetail.on("click", "li.toy-list-item", this.selectToyFromList.bind(this));
    this.$toyDetail.on("change", "select.toy-select", this.reassignToy.bind(this));
  },

  reassignToy: function (event) {
    var $target = $(event.currentTarget);
    var toyId = $target.data("toy-id");
    var pokemonId = $target.val();
    var pokemon = this.pokemon.get(pokemonId);
    var oldPokemon = this.pokemon.get($target.data("pokemon-id"));
    var toy = oldPokemon.toys().get(toyId);

    toy.set("pokemon_id", pokemonId);
    var that = this;
    toy.save({}, {
      success: function () {
        oldPokemon.toys().remove(toy);
        that.renderPokemonDetail(oldPokemon);
        that.$toyDetail.empty();
      }
    });
  },

  selectToyFromList: function (event) {
    var $toy = $(event.currentTarget);
    var toyId = $toy.data("toy-id");
    var pokemonId = $toy.data("pokemon-id");
    var pokemon = this.pokemon.get(pokemonId);
    var toy = pokemon.toys().get(toyId);
    this.renderToyDetail(toy);
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var targetId = $target.data("id");
    var pokemon = this.pokemon.get(targetId);
    this.renderPokemonDetail(pokemon);
  },

  addPokemonToList: function (pokemon) {
    var name = pokemon.escape("name");
    var pokeType = pokemon.escape("poke_type");
    var $li = $("<li>").
      addClass("poke-list-item").
      text(name + " " + pokeType).
      data("id", pokemon.id);
    this.$pokeList.append($li);
  },

  refreshPokemon: function () {
    var that = this;

    this.pokemon.fetch({
      success: function () {
        that.pokemon.each(that.addPokemonToList.bind(that));
      }
    });
  },

  renderPokemonDetail: function (pokemon) {
    var $div = $("<div>").addClass("detail");
    var $img = $("<img>").attr("src", pokemon.get("image_url"));
    var $ul = $("<ul>");

    _.each(pokemon.attributes, function (value, attr) {
      if (attr !== "image_url") {
        var $li = $("<li>").text(attr + ": " + value);
        $ul.append($li);
      }
    });

    var $ulToys = $("<ul>").addClass("toys");
    $div.append($img).append($ul).append($ulToys);

    var that = this;
    pokemon.fetch({
      success: function() {
        pokemon.toys().each(that.addToyToList.bind(that));
      }
    });

    this.$pokeDetail.html($div);
  },

  renderToyDetail: function(toy) {
    var $div = $("<div>").addClass("detail");
    var $img = $("<img>").attr("src", toy.escape("image_url"));
    var $ul = $("<ul>");

    _.each(toy.attributes, function (value, attr) {
      if (attr !== "image_url") {
        var $li = $("<li>").text(attr + ": " + value);
        $ul.append($li);
      }
    });

    var $select = $("<select>").addClass("toy-select")
      .data("pokemon-id", toy.escape("pokemon_id"))
      .data("toy-id", toy.id);
    this.pokemon.each(function(pokemon) {
      var $option = $("<option>")
        .val(pokemon.id)
        .attr("selected", pokemon.id === toy.attributes.pokemon_id)
        .text(pokemon.escape("name"));
      $select.append($option);
    });
    $div.append($img).append($ul).append($select);
    this.$toyDetail.html($div);
  },

  addToyToList: function(toy) {
    var $li = $("<li>").addClass("toy-list-item");
    $li.text(toy.escape("name") + " " + toy.escape("happiness") + " " + toy.escape("price"))
       .data("toy-id", toy.id)
       .data("pokemon-id", toy.escape("pokemon_id"));
    this.$el.find('.pokemon-detail ul.toys').append($li);
  },

  createPokemon: function(attributes, callback) {
    var newPokemon = new Pokedex.Models.Pokemon(attributes);
    var that = this;
    newPokemon.save({}, {
      success: function() {
        that.pokemon.add(newPokemon);
        that.addPokemonToList(newPokemon);
        callback(newPokemon);
      }
    });
  },

  submitPokemonForm: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget).serializeJSON().pokemon;
    this.createPokemon($target, this.renderPokemonDetail.bind(this));
  }
});
