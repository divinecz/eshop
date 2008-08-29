class CreateKeywords < ActiveRecord::Migration
  def self.up
    create_table :keywords do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :categories_keywords, :id => false do |t|
      t.integer :category_id
      t.integer :keyword_id
    end
    
    create_table :keywords_products, :id => false do |t|
      t.integer :keyword_id
      t.integer :product_id
    end
    
    add_index :categories_keywords, [:keyword_id, :category_id] 
    add_index :categories_keywords, :category_id
    
    add_index :keywords_products, [:keyword_id, :product_id] 
    add_index :keywords_products, :product_id
  end

  def self.down
    drop_table :keywords
    drop_table :categories_keywords
    drop_table :keywords_products
  end
end
