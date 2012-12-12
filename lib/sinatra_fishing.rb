require File.dirname(__FILE__) + '/playing_cards.rb'

class SinatraFishing < Sinatra::Base
 
  configure do
    game = GoFish::Game.new 2
    set :game, game
  end
  
  get '/' do
    erb :index
  end
  
  get '/go_fish' do
    settings.game = GoFish::Game.new 2
    @player = settings.game.players.first
    erb :go_fish
  end

  get '/go_fish/fish_for/:card' do
    card = CardWeb[ params[:card] ] 
    #sends us to the winner circle
    redirect '/game_over' if settings.game.over?
    
    @result = ''
    
    if settings.game.players[0].ask_player_for_card(settings.game.players[1], card.rank)
      @result << "Damn you're good!"
      if settings.game.over?
        redirect '/game_over'
      else
        settings.game.players[0].hand << settings.game.draw_pile.draw if settings.game.players[0].hand.empty?
        @player = settings.game.players[0]        
        erb :his_turn
      end
    else
      @result << "You didn't catch anything."
      if settings.game.over?
        redirect '/game_over'
      else
        settings.game.players[1].hand << settings.game.draw_pile.draw if settings.game.players[1].hand.empty?
        @player = settings.game.players[0]
        @books = book_to_cards(@player.books)
        erb :result
      end     
    end
  end
  
  get '/go_fish/his_turn' do
    #Url seems confusing here, I'd like to speak to the user here?
    if settings.game.over?
      redirect '/go_fish/game_over'
    else
      #get a random card from franks hand
      hand = settings.game.players[1].hand
      self.never_empty
      bait = hand.shuffle.first
      @result = ''
      if settings.game.players[1].ask_player_for_card(settings.game.players[0], bait.rank)
         @result << "You lost a #{bait.rank}"
         self.never_empty
         redirect '/your_turn'
      else
         @result << "It's your turn again."
      end
       
      self.never_empty
      
      @player, @frank = settings.game.players
    
      erb :his_turn
    end
  end
  
  get '/go_fish/game_over' do
    game = settings.game
    @player, @frank = game.players
    @players_books = book_to_cards @player.books
    @franks_books = book_to_cards @frank.books
    # Get the winner
    winner = game.players.sort_by { |player| player.books.length }.last
    # Set the result
    if winner == game.players[0]
      result = "You won!"
    else
      result = "You lost!"
    end
    @out_come = result

    erb :game_over
  end
  
  def never_empty
    if settings.game.draw_pile.empty?
      redirect '/game_over'
    else
      settings.game.players.each { |player| player.hand << settings.game.draw_pile.draw if player.hand.empty? }
    end
  end
  
  def book_to_cards(books)
    hand = Deck.new
    books.each do |rank|
      %w{OfHearts OfClubs OfDiamonds OfSpades}.each do |suit|
        hand << Card[rank + suit]
      end
    end
    hand
  end
end
