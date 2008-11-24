class Category < ActiveRecord::Base
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :products
  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_id"
  has_many :children, :class_name => "Category", :foreign_key => "parent_id"
  
  validates_presence_of :title, :description
  
  def self.find_all_top_categories
    find_all_by_parent_id(nil)
  end

  def opened?(id)
    self_and_all_children.collect(&:id).include?(id.to_i)
  end

  def has_products?
    !products.empty?
  end
  
  def leaf?
    children.empty?
  end
  
  def self_and_all_children
    [self] + all_children
  end
  
  def all_children
    has_children? ? children + children.collect(&:all_children).first : []
  end
  
  
  
  def all_parents
    has_parent? ? parent.all_parents + [parent] : []
  end
  
  def full_title
    has_parent? ? parent.full_title + " > " + title : title
  end
  
  def all_products_for_sale
    products = find_all_products.uniq.select(&:for_sale).reverse
  end
  
  def find_all_products
    has_children? ? products(:include => :manufacturer) + children.collect(&:find_all_products).last : products(:include => :manufacturer) #TODO: proc tam je nutnost .first? (pole v poli)
  end
  
  def all_keywords
    has_parent? ? keywords + parent.all_keywords : keywords
  end
  
  def has_parent?
    parent_id != nil
  end
  
  def parent=(category)
    self.parent_id = category.id
  end
  
  def has_children?
    !children.empty?
  end
  
  def to_s
    title
  end
end
