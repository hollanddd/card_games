require File.dirname(__FILE__) + '/spec_helper'

describe Card do
  
  it 'has a rank and a suit' do
    card = Card[TheAceOfHearts]
    card.rank.should eq 'Ace'
    card.suit.should eq 'Heart'
    Card.new(8, 'heart').rank.should eq '8'
  end
  
  it 'can initailize cards with a plural suit' do
    card = Card.new 3, 'Hearts'
    card.suit.should eq 'Heart'
  end

  it 'can return a card given a name' do
    card = Card.parse('3 of hearts')
    card.rank.should eq '3' 
    card.suit.should eq 'Heart'
  end

  it 'aliases [] to parse' do
    card = Card['3 of hearts']
    card.rank.should eq '3'
    card.suit.should eq 'Heart'
  end

  it 'can parse a card name with or without "the"' do
    two_hearts = Card['2 of Hearts']
    two_hearts.rank.should eq '2'
    
    three_hearts = Card['the3ofHearts']
    three_hearts.rank.should eq '3'
    
    four_hearts = Card['the 4 of hearts']
    four_hearts.rank.should eq '4'
  end

  it 'can parse itself regardless of the casing of the suit' do
    card = Card.new 2, 'spades'
    card.rank.should eq '2'
    card.suit.should eq 'Spade'
  
    another_card = Card.new 3, 'hEaRtS'
    another_card.rank.should eq '3'
    another_card.suit.should eq 'Heart'
  end

  it 'can parse itself from a constant' do
    card = The2ofHearts
    card.rank.should eq '2'
    card.suit.should eq 'Heart'
  end

  it 'can compare cards' do
    card = TheAceOfHearts
    the_other_card = Card.new('ace', 'hearts')
    card.object_id.should_not eq the_other_card.object_id
    card.should eq the_other_card
    
    the_other_card = TheKingOfHearts
    card > the_other_card
    card < the_other_card
  end
  
  context 'describes itself' do
    
    it 'with a name' do
      The3OfHearts.name.should eq '3 of Hearts'
    end

    it 'with .to_s alias' do
      The3OfHearts.to_s.should eq '3 of Hearts' 
    end

    it 'by inspecting itself' do
      The3OfHearts.inspect.should eq '<Card: "3 of Hearts">'
    end
  end
end