class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title, :null => false
      t.text :description, :default => ""
      t.decimal :price, :precision => 11, :scale => 2, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
