class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :band, :string
  end

  def self.down
    remove_column :users, :band
    remove_column :users, :lname
    remove_column :users, :fname
  end
end
