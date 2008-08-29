class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :product_id, :null => false
      t.integer :order_id, :null => false
      t.integer :quantity, :null => false
      t.decimal :total_price, :null => false, :precision => 11, :scale => 2
      t.timestamps
    end
    
    add_index :line_items, :order_id
  end

  def self.down
    drop_table :line_items
  end
end
