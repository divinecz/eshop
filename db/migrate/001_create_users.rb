class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => 'DEFAULT CHARSET=UTF8' do |t|
      t.string   "email", :default => ""
      t.string   "hashed_password"
      t.string   "salt"
      t.string   "prefix",                :limit => 20,  :default => ""
      t.string   "first_name",            :limit => 50,  :default => ""
      t.string   "last_name",             :limit => 50,  :default => ""
      t.string   "postfix",               :limit => 10,  :default => ""
      t.string   "street",                :limit => 100, :default => ""
      t.string   "city",                  :limit => 50,  :default => ""
      t.string   "zip",                   :limit => 6,   :default => ""
      t.string   "phone",                 :limit => 18,  :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
