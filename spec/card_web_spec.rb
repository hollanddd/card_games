require File.dirname(__FILE__) + '/spec_helper'

describe CardWeb do
  context 'has an uncany understanding of the interwebs' do
    
    it 'dont blow up' do
      CardWeb.new('ace', 'heart').rank.should eq 'Ace'
    end
    
    it 'has belongs to the CardWeb Class' do
      TheAceOfHearts.class.should eq CardWeb
    end
    
    it 'and things like a css class' do
    
    end
    
    it 'return a web safe a suit' do
      CardWeb.new('ace', 'heart').html_suit.should eq '&#9829'
      CardWeb.new('ace', 'club').html_suit.should eq '&#9827'
      CardWeb.new('ace', 'diamond').html_suit.should eq '&#9830'
      CardWeb.new('ace', 'spade').html_suit.should eq '&#9824'
    end
    
  end
  
  context 'so that they can look good on the interwebs' do
    it 'return a number' do
      TheTenOfHearts.number.should eq '10'
      TheAceOfClubs.number.should eq 'A'
      TheSixOfDiamonds.number.should eq '6'
    end

    it 'has a css class name' do
      CardWeb.new(8, 'heart').css_class.should eq 'card-eight heart'
      TheAceOfHearts.css_class.should eq 'card-ace heart'
      TheSevenOfHearts.css_class.should eq 'card-seven heart'
    end
    
    it 'has a face type' do
      TheQueenOfHearts.type.should eq 'face'
      TheAceOfHearts.type.should eq 'suit'      
      CardWeb.new(8, 'heart').type.should eq 'suit'
    end
    
    context 'it should describe itself' do
      it 'with the number of inner elements' do
        TheAceOfHearts.inside_count.should eq 1
        CardWeb.new('king', 'spade').inside_count.should eq 1
        TheFourOfHearts.inside_count.should eq 4
        CardWeb.new(8, 'heart').inside_count.should eq 8
      end
      
      it 'with where those insides are located at' do
        TheTwoOfHearts.inside_location[0].should eq 'top_center'
        TheTwoOfHearts.inside_location[1].should eq 'bottom_center'
      end
      
      it 'with a face card question' do
        TheAceOfHearts.facecard?.should eq false
        TheKingOfHearts.facecard?.should eq true
      end
    end
  end
end