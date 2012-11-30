require File.dirname(__FILE__) + '/spec_helper'

describe Deck do
 
  it 'can get an empty deck' do
    deck = Deck.new
    deck.length.should be 0
    deck.should be_empty
  end

  it 'can get a standard deck of 52 cards' do
    deck = Deck.standard
    deck.length.should be 52
  end

  it 'can compare decks' do
    deck = Deck.new
    the_other_deck = Deck.new
    deck.should == the_other_deck
  
    deck << The2OfHearts
    deck.equal?(the_other_deck).should eq false

    the_other_deck << The2OfHearts
    deck.equal?(the_other_deck).should eq false
  end

  it 'can shuffle a deck' do
    deck = Deck.standard
    shuffled_deck = deck.shuffle

    deck.each do |card|
      shuffled_deck.should include(card)
    end

    shuffled_deck.should_not == deck
  end

  it 'can shuffle! a deck' do
    deck = Deck.standard
    deck.shuffle!

    deck.should_not == Deck.standard
  end

  it 'can draw a card' do
    deck = Deck.standard
    deck.length.should be 52

    card = deck.draw
    card.should eq The2OfClubs
    deck.length.should be 51
  end

  it 'can convert cards to_deck' do
    deck = Deck.standard
    hand = deck.draw(7).to_deck
    hand.class.should be Deck
  end

  context 'can deal' do
  
    it 'cards from the top' do
      deck = Deck.standard
      deck.length.should be 52

      deck.deal_from_top.should eq The2OfClubs
      deck.length.should be 51
    end

    it 'cards from the bottom' do
      deck = Deck.standard
      deck.deal_from_bottom.should eq TheAceOfSpades
      deck.length.should be 51
    end

    it 'a given number of cards' do
      deck = Deck.standard
      cards = deck.draw 2
      
      deck.length.should be 50
      cards.length.should be 2

      cards[0].should eq The2OfClubs
      cards[1].should eq The3OfClubs

      cards = deck.deal_from_bottom 2

      deck.length.should be 48
      cards.length.should be 2

      cards[0].should eq TheAceOfSpades
      cards[1].should eq TheKingOfSpades
    end

    it 'a card by name' do
      deck = Deck.standard

      card = deck.draw The3OfClubs
      deck.length.should be 51
      deck[0].should eq The2OfClubs
      deck[1].should eq The4OfClubs

      deck.draw(The3OfClubs).should be_nil

      card = deck.deal_from_bottom TheKingOfSpades
      card.should eq TheKingOfSpades
      deck.length.should be 50
      deck[49].should eq TheAceOfSpades
      deck[48].should eq TheQueenOfSpades

      deck.deal_from_bottom(TheKingOfSpades).should be_nil
    end

    it 'a burn card' do
      deck = Deck.standard
      deck.length.should be 52
      deck.burn
      deck.length.should be 51
      deck[0].should eq The3OfClubs
    end
  end
end
