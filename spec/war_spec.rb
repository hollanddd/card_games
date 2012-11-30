require File.dirname(__FILE__) + '/spec_helper'

describe War do

  before do
    @game = War::Game.new 2
  end

  context 'when starting war' do

    it 'it should involve two players' do
      @game.players.count.should eq 2
    end
    
    it 'it should deal the entire deck' do
      @game.players.first.hand.count.should eq 26
      @game.players[-1].hand.count.should eq 26
    end
    
    it 'should have an empty battle field' do
      @game.battle_field.is_a?(Deck).should be true
    end

    it 'and the draw pile should be empty' do
      @game.draw_pile.count.should eq 0
    end
  end
  
  context 'it plays  war' do
    
    it 'by taking the first card from each players hand' do
      @game.players.each do | player |
        player.hand = Deck.new
      end
      
      first_player, second_player = @game.players
      
      first_player.hand << TheAceOfHearts
      second_player.hand << TheTwoOfHearts
      @game.prepare_for_battle
      @game.battle_field.should eq [TheAceOfHearts, TheTwoOfHearts].to_deck
    end
    
    it 'then comparing the cards in the battlefield' do
      @game.battle_field << TheAceOfHearts
      @game.battle_field << TheTwoOfHearts
      @game.war?.should eq false
    end
  end     

  it 'war happens when the cards on the battle field are equal' do
        @game.battle_field << TheAceOfHearts
        @game.battle_field << TheAceOfClubs
        @game.battle_field.is_a?(Deck).should be true
        @game.war?.should eq true
        @game.battle_field.last = TheKingOfSpades
        @game.war?.should eq false
  end
  
  it 'a battle is won if your card is greater than the other card' do
    @game
  end
end
