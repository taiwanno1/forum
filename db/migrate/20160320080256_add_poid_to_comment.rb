class AddPoidToComment < ActiveRecord::Migration
  def change
    add_column :comments, :po_id, :integer
  end
end
