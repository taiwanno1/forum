class AddUserIdToPo < ActiveRecord::Migration
  def change
    add_column :pos , :user_id, :integer
    add_index :pos, :user_id
  end
end
