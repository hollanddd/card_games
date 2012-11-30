require File.dirname(__FILE__) + '/spec_helper'

describe GoFish do

  before do
    @game = GoFish::Game.new 2
    @first_player, @second_player = @game.players
    @first_player.hand = Deck.new
    @second_player.hand = Deck.new
  end

  context 'when initializing' do
    it 'should not blow up' do
      @game.should_not be nil
    end

    it 'should have a player or two' do
      @game.players.length.should eq 2
      @game.players.length.should be > 1
    end

    it 'should deal out some cards' do
      @game = GoFish::Game.new 2
      @game.players.first.hand.length.should eq 7
    end

    it 'from the deck' do
      @game.draw_pile.length.should eq 52 - 7 - 7
    end
  end

  context 'during the game' do

    it 'players take turns asking each other for cards' do
      @game.players.first.hand = Deck.new
      @game.players.first.hand << The3OfHearts
      @game.players.first.ask_player_for_card @game.players.last, 3
      @game.turn.count.should be > 0
    end

    it 'players go fish when asking for the wrong card' do
      @game.draw_pile = Deck.new
      @game.draw_pile << The2OfHearts
      @game.draw_pile << The3OfHearts
      @first_player.hand = [The4OfHearts, The5OfHearts]
      @second_player.hand = [The6OfHearts, The7OfHearts]

      @first_player.ask_player_for_card @second_player, 4 

      @game.draw_pile.length.should be 1
    end

    it 'players get all the card they ask for' do
      @first_player.hand << TheAceOfHearts
      @first_player.hand << The2OfHearts

      @second_player.hand << The3OfHearts
      @second_player.hand << TheAceOfSpades
      @second_player.hand << TheAceOfClubs
    
      @first_player.ask_player_for_card @second_player, 'Ace'
      @first_player.hand[2].should eq TheAceOfSpades
      @first_player.hand.last.should eq TheAceOfClubs
    end
    
    it 'players can only ask for cards that are in their hand' do
      @first_player.hand = Deck.new
      @first_player.hand << TheAceOfHearts

      @first_player.ask_player_for_card(@second_player, 2).should be false
    end

    context 'a book' do
      
      it 'is formed when 4 cards of the same rank are collected' do
        @game.draw_pile = Deck.new
        @game.draw_pile << The2OfHearts

        @first_player.hand = Deck.new
        @first_player.hand << TheAceOfHearts
        @first_player.hand << TheAceOfDiamonds
        @first_player.hand << TheAceOfClubs
        @first_player.books = []

        @second_player.hand = Deck.new
        @second_player.hand << TheAceOfSpades

        @first_player.ask_player_for_card @second_player, 'Ace'

        @first_player.books.length.should eq 1
      end
    end

  end

  it 'should be winable' do
    @game.draw_pile = Deck.new
    @first_player.hand = Deck.new
    @first_player.hand = [The2OfClubs, The2OfSpades, The2OfDiamonds]
    @first_player.books = ['Ace', 'King']

    @second_player.hand = Deck.new
    @second_player.hand << The2OfHearts
    @second_player.books = ['Queen', 'Jack']

    @game.winner.should be_nil
    @game.should_not be_over

    @first_player.ask_player_for_card @second_player, 2

    @game.should be_over
    @game.winner.should eq @first_player
  end

end
