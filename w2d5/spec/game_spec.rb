require 'rspec'
require 'game'
require 'player'

describe Game do
  let(:hand1) { double("hand1") }
  let(:hand2) { double("hand2") }
  let(:hand3) { double("hand3") }
  let(:hand4) { double("hand4") }
  subject(:player1) { Player.new("Mark", hand1, 100, 1_000) }
  subject(:player2) { Player.new("Darren", hand2, 200, 1_000) }
  subject(:player3) { Player.new("Ryan", hand3, 100, 1_000) }
  subject(:player4) { Player.new("Phil", hand4, 100, 1_000) }

  describe "#initialize" do
    let(:deck) { double("deck") }
    subject(:game) { Game.new(player1, player2, player3, player4, deck) }

    it "hosts a deck" do
      expect(game.deck).to eq(deck)
    end

    it "has players" do
      expect(game.players).to eq([player1,player2, player3, player4])
    end

  end

  describe "#change_turn" do
    it "should change turn" do
      game.change_turn
      expect(game.current_player).to eq(player2)
    end
  end

  describe "#turn" do
    it "should return the first player at the beginning of the game" do
      expect(game.turn).to eq(player1)
    end

    it "shoule return the current player " do
    game.change_turn
    expect(game.turn).to eq(player2)
    end
  end

  describe "#total_pot" do
    it "should return the total amount in all players' pot" do
      expect(game.total_pot).to eq(500)
    end
  end
end
