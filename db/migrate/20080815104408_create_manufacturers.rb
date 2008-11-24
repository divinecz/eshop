class CreateManufacturers < ActiveRecord::Migration
  def self.up
    create_table :manufacturers, :options => 'DEFAULT CHARSET=UTF8' do |t|
      t.string :name
      t.timestamps
    end
    
    change_table :products do |t|
      t.integer :manufacturer_id
    end
    
    add_index :products, :manufacturer_id
  end

  def self.down
    drop_table :manufacturers
    
    change_table :products do |t|
      t.remove :manufacturer_id
    end
    
    remove_index :products, :manufacturer_id
  end
end
