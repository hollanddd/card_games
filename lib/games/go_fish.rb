module GoFish
  
  class TurnTracker
    attr_accessor :game, :count

    def initialize game
      @game = game
      @count = 0
    end

    def player
      if @last_player
        index_of_last_player = game.players.index @last_player
        next_player = game.players[index_of_last_player + 1]
        next_player = game.players.first unless next_player
        return next_player
      else
        game.players.first
      end
    end

    def take! player_taking_turn
      if player_taking_turn != player
        raise "It's not your turn!"
      else
        @last_player = player_taking_turn
        @count += 1
      end
    end
  end

  class Player
    attr_accessor :game, :hand, :books

    def hand= value
      @hand = value.to_deck
    end

    def initialize game
      @game = game
      @books = []
    end
    
    def ask_player_for_card another_player, rank, noisy=false
      return false unless self.hand.select {|card| card.rank == rank.to_s}.count > 0
      card = false
      matching_cards = another_player.hand.select {|card| card.rank == rank.to_s}
      
      if matching_cards.empty?
        hand << game.draw_pile.draw
        card_from_draw_pile = hand.last
        puts "Go Fish! (#{ card_from_draw_pile.inspect })" if noisy
        game.turn.take!(self)
      else
        matching_cards.each do |card|
          puts "You got: #{ card.inspect }" if noisy
          hand << another_player.hand.draw(card)
          card = true
        end
      end
      check_for_books!
      return card
    end

    private 

    def check_for_books!
      possible_books = {}

      hand.each do |card|
        possible_books[card.rank] ||= []
        possible_books[card.rank] << card
      end

      possible_books.each do |rank, cards |
        if cards.length == 4
          books << rank
          cards.each {|card| hand.delete card }
        end
      end
    end
  end

  class Game
    attr_accessor :players, :draw_pile, :turn

    def initialize number_of_players
      @turn = TurnTracker.new(self)
      @draw_pile = Deck.standard.shuffle!
      @players = []
      number_of_players.times do |player_id|
        player = Player.new self
        player.hand = Deck.new
        @players << player

        7.times do |card|
          @players[player_id].hand[card] = @draw_pile.draw
        end
      end
    end

    def winner
      if over?
        players.sort_by {|player| player.books.length }.last
      end
    end

    def over?
      return false unless draw_pile.empty?
      players.each do |player|
        return false unless player.hand.empty?
      end
      return true
    end
  end
end
