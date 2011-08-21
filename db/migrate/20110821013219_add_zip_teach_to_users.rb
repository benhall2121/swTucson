class AddZipTeachToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :zip, :string
    add_column :users, :teacher, :bool
  end

  def self.down
    remove_column :users, :teacher
    remove_column :users, :zip
  end
end
