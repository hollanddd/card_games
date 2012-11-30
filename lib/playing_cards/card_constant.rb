module CardConstant
  def const_missing name
    if card = CardWeb.parse(name)  
      return card
    else
      CardWeb
    end
  end
end

Object.send :extend, CardConstant
