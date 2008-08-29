class Keyword < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_and_belongs_to_many :categories
  
  def to_s
    name
  end
end
