module War
  
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
    attr_accessor :game, :hand

    def hand= value
      @hand = value.to_deck
    end

    def initialize game
      @game = game
      @books = []
    end
  end
  
  class Game
    attr_accessor :players, :draw_pile, :battle_field, :at_risk, :turn

    def initialize number_of_players
      @turn = TurnTracker.new(self)
      @draw_pile = Deck.standard.shuffle!
      @players = []
      @battle_field = Deck.new
      @at_risk = Deck.new
      number_of_players.times do |player_id|
        player = Player.new self
        player.hand = Deck.new
        @players << player

        26.times do |card|
          players[player_id].hand[card] = draw_pile.draw
        end
      end
    end
    
    def prepare_for_battle players
      players.each { |player| battle_field << player.hand.draw} 
    end
    
    def war?
      player_card, other_player_card = battle_field
      player_card.equals?combatant_card
    end
   
    def prepare_for_war
      @at_risk = @battle_field
      2.times do end 
      prepare_for_battle
    end

    def start_fighting
      # each player draws a  card from the top of their hand
      
      # the cards are compared, a tie draws another card from each players deck
      
      # the player with the winning card receives cards
    end

    def winner
      if over?
        players.sort_by {|player| player.hand.length }.last
      end
    end

    def over?
      players.each do |player|
        return true if player.hand.empty?
      end
      return false
    end
  end
end
