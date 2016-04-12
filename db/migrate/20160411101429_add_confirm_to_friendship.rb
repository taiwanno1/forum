class AddConfirmToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :confirm, :boolean, :default => false
  end
end
