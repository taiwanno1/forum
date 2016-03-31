class AddStartOnToPo < ActiveRecord::Migration
  def change
    add_column :pos, :start_on, :text
  end
end
