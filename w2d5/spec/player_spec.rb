require 'rspec'
require 'player'
require 'card'

describe Player do
  let(:hand) { double("hand", empty?: cards.empty?, cards: [
              Card.new(:spades, :deuce),
              Card.new(:spades, :three),
              Card.new(:spades, :four),
              Card.new(:spades, :five),
              Card.new(:spades, :six)]) }
  subject(:player) { Player.new("Mark",hand, 100, 1_000) }
  describe "#initialize" do

    it "has a name" do
      expect(player.name).to eq("Mark")
    end

    it "has starting money" do
      expect(player.money).to eq(1_000)
    end

    it "has a hand" do
      expect(player.hand).to eq(hand)
    end

    it "has a pot" do
      expect(player.pot).to eq(100)
    end
  end

  describe "#discard" do
    let(:deck_cards) { [Card.new(:hearts, :five), Card.new(:hearts, :king)] }
    let(:new_set) { [Card.new(:spades, :deuce),
                Card.new(:spades, :three),
                Card.new(:spades, :six)] }
      let(:deck) { double("deck") }
    it "should discard certain cards" do
      expect(deck).to receive(:take).with(2).and_return(deck_cards)
      expect(player.discard([2,3],deck)).to eq(new_set + deck_cards)
    end

    it "raises an error if player discards more than 3 cards" do
      expect { player.discard([1,2,3,4], deck) }.to raise_error("Stop")
    end
  end

  describe "#fold" do
    it "should make the hand empty" do
      player.fold
      expect(player.hand).to be_empty
    end
  end

  describe "#see" do
    it "should match the raise" do
      player.see(300)
      expect(player.pot).to eq(300)
    end

    it "should subtract from own money" do
      player.see(200)
      expect(player.money).to eq(800)
    end
  end

  describe "#raise" do
    it "should increace pot" do
      player.raise(100)
      expect(player.pot).to eq(100)
    end

    it "should subtract from own money" do
      player.raise(200)
      expect(player.money).to eq(800)
    end
  end

  describe "#give_pot" do
    let(:player2) { Player.new("Darren",hand, 200, 800) }
    let(:player3) { Player.new("Ryan",hand, 100, 900) }
    it "should give pot to other player" do
      player.give_pot(player2)
      expect(player.pot).to eq(0)
      expect(player2.money).to eq(900)
    end

    it "should receive pot from other players" do
      player2.give_pot(player)
      expect(player2.pot).to eq(0)
      expect(player.money).to eq(1200)

      player3.give_pot(player)
      expect(player3.pot).to eq(0)
      expect(player.money).to eq(1300)
    end

    it "should be able to reclaim pot" do
      player.give_pot(player)
      expect(player.pot).to eq(0)
      expect(player.money).to eq(1100)
    end
  end

end
