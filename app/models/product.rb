class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :categories
  belongs_to :manufacturer
  
  validates_presence_of :title, :description

  def all_keywords
    categories.empty? ? keywords : keywords + categories.collect(&:all_keywords).inject{|a, b| a + b}
  end

  def self.find_all_for_sale
    find_all_by_for_sale(true, :include => :manufacturer)
  end
  
  def self.find_for_sale(id) # TODO: fujfuj
    if p = find(:first, :conditions => {:id => id, :for_sale => true })
      return p
    else
      raise ActiveRecord::RecordNotFound
    end
  end
  
  def to_s
    title
  end
end
