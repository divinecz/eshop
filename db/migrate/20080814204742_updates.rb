class Updates < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
        t.boolean :for_sale
    end
  end

  def self.down
    change_table :products do |t|
        t.remove :for_sale
    end
  end
end
