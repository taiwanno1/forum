class AddUserProfile < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string
    add_column :users, :about_user, :text
  end
end
