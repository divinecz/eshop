class CartItem 
  attr_reader :product, :quantity, :id
  
  def initialize(id, product, quantity = 1)
    @id = id
    @product = product 
    @quantity = quantity
  end 
  
  def quantity=(q)
    @quantity = q if q > 0 && q.class == Fixnum #TODO: Check
  end
  
  def increment_quantity(quantity = 1) 
    @quantity += quantity
  end 
  
  def title 
    @product.title 
  end 
  
  def price 
    @product.price * @quantity 
  end 
end