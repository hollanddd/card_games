class CardWeb < Card
  # assumes knowledge of the interwebs
  # and scalable css playing cards
  
  def web_name
    "#{rank}Of#{suit}s"
  end
  
  def facecard?
    %w[King Queen Jack].include? rank
  end
  
  def type
    facecard? ? 'face' : 'suit'
  end
  
  def inside_count
    if %w[Ace King Queen Jack].include? rank
      1
    else
      return number.to_i
    end
  end
  
  def inside_location
    case number
    when 'A' then return %w[middle_center]
    when '2' then return %w[top_center bottom_center]
    when '3' then return %w[top_center bottom_center middle_center]
    when '4' then return %w[top_left top_right bottom_left bottom_right]
    when '5' then return %w[top_left top_right middle_center bottom_left bottom_right]
    when '6' then return %w[top_left top_right middle_left middle_right bottom_left bottom_right]
    when '7' then return %w[top_left top_right middle_left middle_top middle_right bottom_left bottom_right]
    when '8' then return %w[top_left top_right middle_left middle_top middle_right middle_bottom bottom_left bottom_right]
    when '9' then return %w[top_left top_right middle_top_left middle_top_center middle_top_right bottom_left bottom_right middle_bottom_left middle_bottom_right]
    when '10' then return %w[top_left top_right middle_top_left middle_top_center middle_top_right bottom_left bottom_right middle_bottom_center middle_bottom_left middle_bottom_right]
    end
    []
  end
  
  def css_class
    if %w[2 3 4 5 6 7 8 9 10].include? rank
      convert = {
        '2' => 'two',
        '3' => 'three',
        '4' => 'four',
        '5' => 'five',
        '6' => 'six',
        '7' => 'seven',
        '8' => 'eight',
        '9' => 'nine',
        '10' => 'ten'
      }
      name = convert[rank]
    else
      name = rank.downcase
    end
    "card-#{name} #{suit.downcase}"
  end
  
  def number
    convert = {
      'Two' => '2',
      'Three' => '3',
      'Four' => '4',
      'Five' => '5',
      'Six' => '6',
      'Seven' => '7',
      'Eight' => '8',
      'Nine' => '9',
      'Ten' => '10',
      'Jack' => 'J',
      'Queen' => 'Q',
      'King' => 'K',
      'Ace' => 'A',
      '2' => '2',
      '3' => '3',
      '4' => '4',
      '5' => '5',
      '6' => '6',
      '7' => '7',
      '8' => '8',
      '9' => '9',
      '10' => '10'
    }
    convert[rank]
  end
  
  def html_suit
    convert = {
      'Heart' => '&#9829',
      'Club' => '&#9827',
      'Diamond' => '&#9830',
      'Spade' => '&#9824'
    }
    convert[suit]
  end
  
  def self.parse name
    name = name.to_s.sub(/^the()?/i, '').strip

    if name =~ /^(\w+) of (\w+)$/i
      CardWeb.new $1, $2
    elsif name =~ /^(\w+)of(\w+)$/i
      CardWeb.new $1, $2
    end
  end
end