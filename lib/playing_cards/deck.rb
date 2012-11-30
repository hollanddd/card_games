def Deck *cards
  Deck[*cards]
end

class Deck < Array

  module ArrayExtensions
    def to_deck
      Deck.new self
    end
  end

  def self.standard
    deck = Deck.new
    %w{club diamond heart spade}.each do |suit|
      %w{2 3 4 5 6 7 8 9 10 jack queen king ace}.each do |rank|
        deck << CardWeb.new(rank, suit)
      end
    end
    deck
  end

  def deal_from_top num = 1
    _draw num, :shift
  end

  alias draw deal_from_top
  alias burn deal_from_top

  def deal_from_bottom num = 1
    _draw num, :pop
  end

private
  
  def _draw num, operation
    if num.is_a? Card
      delete num
    else
      if num == 1
        send(operation)
      else
        cards = []
        num.times { cards << send(operation) }
        cards
      end
    end
  end
end

Array.send :include, Deck::ArrayExtensions
