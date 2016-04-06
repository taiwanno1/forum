class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :friendship_id

      t.timestamps null: false
    end
  end
end
