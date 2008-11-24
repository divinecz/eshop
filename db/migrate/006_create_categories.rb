class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories, :options => 'DEFAULT CHARSET=UTF8' do |t|
      t.string :title
      t.text :description
      t.integer :parent_id
      t.timestamps
    end
    
    create_table :categories_products, :id => false do |t|
      t.integer :category_id
      t.integer :product_id
    end
    
    add_index :categories_products, [:category_id, :product_id]
  end

  def self.down
    drop_table :categories
    drop_table :categories_products
  end
end
