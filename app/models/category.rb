class Category < ActiveRecord::Base
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :products
  
  validates_presence_of :title, :description
  
  def all_parents
    has_parent? ? parent.all_parents + [parent] : []
  end
  
  def full_title
    has_parent? ? parent.full_title + " / " + title : title
  end
  
  def all_products_for_sale
    products = find_all_products.uniq.select(&:for_sale).reverse
  end
  
  def find_all_products
    has_children? ? products(:include => :manufacturer) + children.collect(&:find_all_products).first : products(:include => :manufacturer) #TODO: proc tam je nutnost .first? (pole v poli)
  end
  
  def self.all_to_html
    "<ul>#{find_all_top_categories.collect(&:to_html)}</ul>" #TODO: no toto by snad melo byt v hlprech, nie?
  end
  
  def self.find_all_top_categories
    find_all_by_parent_id(nil)
  end
  
  def to_html
    return "" if all_products_for_sale.empty?
    has_children? ? "<li><a href=\"/catalog/#{id}\">#{title}</a><ul>#{children.collect(&:to_html)}</ul></li>" : "<li><a href=\"/catalog/#{id}\">#{title}</a></li>" #TODO: no toto by snad melo byt v hlprech, nie?
  end
  
  def all_keywords
    has_parent? ? keywords + parent.all_keywords : keywords
  end
  
  def has_parent?
    parent_id != nil
  end
  
  def parent
    self.class.find(self.parent_id) if has_parent?
  end
  
  def parent=(category)
    self.parent_id = category.id
  end
  
  def has_children?
    !children.empty?
  end
  
  def children
    self.class.find_all_by_parent_id(self.id)
  end
  
  def to_se
    title
  end
end
