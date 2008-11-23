class Cart
  attr_accessor :items
  
  @@instance = 0
  
  def self.instance
    @@instance
  end
  
  def initialize
    @items = []
    @id = 0
    @@instance += 1
  end
  
  def update_cart(quantities)
    self.items.each_with_index do |item, i|
      item.quantity = quantities[i].to_i
    end
  end
  
  def add(product, quantity = 1)
    item = @items.find { |i| i.product == product }
    if item
      item.increment_quantity quantity
    else 
      item = CartItem.new((@id += 1), product, quantity)
      @items << item
    end
    item
  end
  
  def remove(id)
    @items = @items.select{ |i| i.id.to_i != id.to_i} #TODO: Trosku hack... odmazani prvku z pole?
  end
  
  def total_price
    @items.sum(&:price)
  end
  
  def size
    @items.sum(&:quantity)
  end
end