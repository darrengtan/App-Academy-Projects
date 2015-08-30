require 'rspec'
require 'card'
describe Card do
  describe "::suits" do
    subject(:suits) {Card.suits}
    it "should return four suits" do
      expect(suits.count).to eq(4)
    end
  end

  describe "::values" do
    subject(:values) {Card.values}
    it "should return 13 values" do
      expect(values.count).to eq(13)
    end
  end

  describe "#initialize" do
    context "no arguments" do
      it "should raise error with no arguments" do
        expect do
          bad_card = Card.new
        end.to raise_error(ArgumentError)
      end

      it "should raise error with one argument" do
        expect do
          bad_card = Card.new(:heart)
        end.to raise_error(ArgumentError)
      end
    end

    context "with arguments" do
      let(:sample_card) { Card.new(:hearts, :four) }
      let(:bad_card) { Card.new(:puppy, :kitten) }
      it "raises an error if suit input is not an available suit" do

        expect do
          bad_card = Card.new(:puppy, :four)
        end.to raise_error("bad suit input")
      end

      it "raises an error if value input is not an available value" do
        expect do
          bad_card = Card.new(:hearts, :kitten)
        end.to raise_error("bad value input")
      end

      it "creates a card with specific suit" do
        expect(sample_card.suit).to eq(:hearts)
      end

      it "creates a card with a specific value" do
        expect(sample_card.value).to eq(:four)
      end
    end
  end

  describe "#<=>" do
    it "should compare cards to each other" do
      card1 = Card.new(:spades,:ace)
      card2 = Card.new(:clubs,:two)
      card3 = Card.new(:hearts,:two)
      expect(card1<=>card2).to eq(1)
      expect(card2<=>card3).to eq(-1)
    end
  end

  describe "#to_s" do
    subject(:card) { Card.new(:diamonds, :king) }
    it "returns 'value suit'" do
      expect(card.to_s).to eq("♦K")
    end
  end

  # describe "card integer value"
end
