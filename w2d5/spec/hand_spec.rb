require 'rspec'
require 'hand'
require 'card'
require 'deck'

describe Hand do
  deck_cards = [
   Card.new(:spades, :deuce),
   Card.new(:spades, :three),
   Card.new(:spades, :four),
   Card.new(:spades, :five),
   Card.new(:spades, :six)
  ]

  straight_flush = [
   Card.new(:spades, :seven),
   Card.new(:spades, :eight),
   Card.new(:spades, :nine),
   Card.new(:spades, :ten),
   Card.new(:spades, :jack)
  ]

  four_of_a_kind = [
   Card.new(:spades, :seven),
   Card.new(:hearts, :seven),
   Card.new(:clubs, :seven),
   Card.new(:diamonds, :seven),
   Card.new(:spades, :jack)
  ]

  full_house = [
   Card.new(:spades, :seven),
   Card.new(:hearts, :seven),
   Card.new(:clubs, :seven),
   Card.new(:clubs, :jack),
   Card.new(:spades, :jack)
  ]

  flush = [
   Card.new(:spades, :seven),
   Card.new(:spades, :ace),
   Card.new(:spades, :three),
   Card.new(:spades, :ten),
   Card.new(:spades, :jack)
  ]

  straight = [
   Card.new(:spades, :seven),
   Card.new(:hearts, :eight),
   Card.new(:clubs, :nine),
   Card.new(:spades, :ten),
   Card.new(:spades, :jack)
  ]

  three_of_a_kind = [
    Card.new(:spades, :seven),
    Card.new(:hearts, :seven),
    Card.new(:clubs, :seven),
    Card.new(:spades, :ten),
    Card.new(:spades, :jack)
  ]

  two_pair = [
    Card.new(:spades, :seven),
    Card.new(:hearts, :seven),
    Card.new(:clubs, :nine),
    Card.new(:spades, :nine),
    Card.new(:spades, :jack)
  ]

  one_pair = [
    Card.new(:spades, :seven),
    Card.new(:hearts, :seven),
    Card.new(:clubs, :nine),
    Card.new(:spades, :ten),
    Card.new(:spades, :jack)
  ]

  high_card = [
    Card.new(:spades, :seven),
    Card.new(:hearts, :eight),
    Card.new(:clubs, :nine),
    Card.new(:spades, :ten),
    Card.new(:spades, :jack)
  ]

  describe "::deal_from" do
    it "take 5 cards from a deck" do
      deck = double("deck")
      expect(deck).to receive(:take).with(5).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      expect(hand.cards).to match_array(deck_cards)
    end
  end


  describe "#initialize" do
    it "initialize a hand with given set of cards" do
      hand = Hand.new(deck_cards)
      expect(hand.cards).to eq(deck_cards)
    end
  end

  describe "#points" do
    it "should compare the cards " do
      deck = double("deck")
      expect(deck).to receive(:take).with(5).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      expect(hand.points).to eq(150)
    end
  end

  describe "#campare_to" do

    subject(:hand) { Hand.new(full_house) }

    it "says full house is better than straight" do
      other_hand = Hand.new(straight)
      expect(hand <=> other_hand).to eq(1)
    end

    it "says full house is better than flush" do
      other_hand = Hand.new(flush)
      expect(hand <=> other_hand).to eq(1)
    end

    it "says full house is worse than four of a kind" do
      other_hand = Hand.new(four_of_a_kind)
      expect(hand <=> other_hand).to eq(-1)
    end

    it "says full house is worse than straight flush" do
      other_hand = Hand.new(straight_flush)
      expect(hand <=> other_hand).to eq(-1)
    end

  end

  context "different hands" do

    describe "#one_pair?" do
      it "returns true if a pair exists" do
        let(:one_pair_hand) { Hand.new(one_pair)}
        expect(one_pair_hand.one_pair?).to be true
      end
    end

    describe "#two_pair?" do
      it "returns true if two pairs exists" do
        let(:two_pair_hand) { Hand.new(two_pair)}
        expect(two_pair_hand.two_pair?).to be true
      end

      it "returns false if only one pair exists" do
        let(:one_pair_hand) { Hand.new(one_pair)}
        expect(one_pair_hand.two_pair?).to be false
      end
    end

    describe "#straight?" do
      it "returns true if straight exist" do
        let(:straight_hand) { Hand.new(straight)}
        expect(straight_hand.straight?).to be true
      end
    end

    describe "#flush?" do
      it "returns true if flush exist" do
        let(:flush_hand) { Hand.new(flush)}
        expect(flush_hand.flush?).to be true
      end
    end

    describe "#full_house?" do
      it "returns true if full house exist" do
        let(:full_house_hand) { Hand.new(threefull_house)}
        expect(full_house_hand.full_house?).to be true
      end

      it "returns false if only one pair exists" do
        let(:one_pair_hand) { Hand.new(one_pair)}
        expect(one_pair_hand.full_house?).to be false
      end

      it "returns false if only one three kind exists" do
        let(:three_kind_hand) { Hand.new(three_kind)}
        expect(three_kind_hand.full_house?).to be false
      end
    end

    describe "#four_kind?" do
      it "returns true if four of a kind exist" do
        let(:four_of_a_kind_hand) { Hand.new(four_kind)}
        expect(four_of_a_kind_hand.four_kind?).to be true
      end

      it "returns false if only one pair exists" do
        let(:one_pair_hand) { Hand.new(one_pair)}
        expect(one_pair_hand.four_kind?).to be false
      end

      it "returns false if only one three kind exists" do
        let(:three_kind_hand) { Hand.new(three_kind)}
        expect(three_kind_hand.full_house?).to be false
      end
    end
  end






end
