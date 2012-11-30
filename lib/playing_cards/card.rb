class Card
  attr_accessor :rank, :suit

  def initialize rank, suit 
    @rank = rank.to_s.capitalize
    @suit = suit.downcase.sub(/s$/,'').capitalize
  end

  def == another_card
    rank == another_card.rank && suit == another_card.suit
  end
  
  def > another_card
    numberify > another_card.numberify
  end
  
  def < another_card
    numberify < another_card.numberify
  end
  
  def equals? another_card
    numberify == another_card.numberify
  end 
  
  def numberify
    convert = {
      'Two' => 2,
      'Three' => 3,
      'Four' => 4,
      'Five' => 5,
      'Six' => 6,
      'Seven' => 7,
      'Eight' => 8,
      'Nine' => 9,
      'Ten' => 10,
      'Jack' => 11,
      'Queen' => 12,
      'King' => 13,
      'Ace' => 14,
      '2' => 2,
      '3' => 3,
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9,
      '10' => 10
    }
    convert[rank]
  end

  def name
    "#{ rank } of #{ suit }s"
  end
  
  def inspect
    "<Card: \"#{ name }\">"
  end
  
  alias to_s name
  
  def self.parse name
    name = name.to_s.sub(/^the()?/i, '').strip

    if name =~ /^(\w+) of (\w+)$/i
      Card.new $1, $2
    elsif name =~ /^(\w+)of(\w+)$/i
      Card.new $1, $2
    end
  end

  class << self
    alias [] parse
  end
end
