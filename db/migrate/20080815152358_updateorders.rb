class Updateorders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.string   "prefix",          :limit => 20,  :default => ""
      t.string   "first_name",      :limit => 50,  :default => ""
      t.string   "last_name",       :limit => 50,  :default => ""
      t.string   "postfix",         :limit => 10,  :default => ""
      t.string   "street",          :limit => 100, :default => ""
      t.string   "city",            :limit => 50,  :default => ""
      t.string   "zip",             :limit => 6,   :default => ""
      t.string   "phone",           :limit => 18,  :default => ""
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove   "prefix"
      t.remove   "first_name"
      t.remove   "last_name"
      t.remove   "postfix"
      t.remove   "street"
      t.remove   "city"
      t.remove   "zip"
      t.remove   "phone"
    end
  end
end
