require 'rspec'
require 'deck'


describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards}
    it "returns 52 cards" do
      expect(all_cards.count).to eq(52)
    end

    it "returns 52 unique cards" do
      duped_cards = all_cards.map{ |card| [card.suit, card.value]}.uniq.count
      expect(duped_cards).to eq(52)
    end
  end

  let(:cards) do
    cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end


  describe "#initialize" do
    context "no arguments" do
      subject(:new_deck) { Deck.new }
      it "creates a new deck" do
        expect(new_deck.count).to eq(52)
      end
    end

    context "with a argument" do
      it "creates a deck with an array of cards" do
        new_deck = Deck.new(cards)
        expect(new_deck.count).to eq(3)
      end
    end

    context "with more than one argument" do
      it "raises an error when passing more than one argument" do
        expect do
          new_deck = Deck.new(cards,cards,cards)
        end.to raise_error(ArgumentError)
      end
    end
  end

  let(:deck) do
    Deck.new(cards.dup)
  end

  it "does not expose its cards directly" do
    expect(deck).not_to respond_to(:cards)
  end

  describe "#take" do
    it "takes cards from the top of the deck" do
      expect(deck.take(1)).to eq(deck[0])
      expect(deck.take(2)).to eq(deck[0..1])
    end
  end

  describe "#return" do
    let(:more_cards) {
      [Card.new(:diamonds, :king),
        Card.new(:diamonds, :queen),
        Card.new(:diamonds, :jack)]
    }

    it "returns cards to the bottom of the deck" do
      deck.return(more_cards)
      expect(deck.count).to eq(6)
      expect(deck[-3..-1]).to eq(more_cards)
    end
  end
end
