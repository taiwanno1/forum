class AddFriendToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirm, :boolean, :default => nil
  end
end
