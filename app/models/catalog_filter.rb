class CatalogFilter
  attr_reader :manufacturer, :sort
  
  def initialize(data = {})
    @manufacturer = data[:manufacturer].to_i unless data[:manufacturer].blank?
    @sort = data[:sort].to_i unless data[:sort].blank?
  end
  
  def apply(products)
    products = products.select{ |p| p.manufacturer.id == manufacturer } if manufacturer
    products = products.sort{ |a, b| a.price <=> b.price } if sort == 1
    products = products.sort{ |a, b| a.title <=> b.title } if sort == 2
    products
  end
end