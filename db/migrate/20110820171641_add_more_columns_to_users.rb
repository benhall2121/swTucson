class AddMoreColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :arts_type, :string
    add_column :users, :ind_group, :string
    add_column :users, :name, :string
    add_column :users, :artist_name, :string
    add_column :users, :bio, :text
    add_column :users, :web_site, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :youTube, :string
  end

  def self.down
    remove_column :users, :youTube
    remove_column :users, :twitter
    remove_column :users, :facebook
    remove_column :users, :web_site
    remove_column :users, :bio
    remove_column :users, :artist_name
    remove_column :users, :name
    remove_column :users, :ind_group
    remove_column :users, :arts_type
  end
end
