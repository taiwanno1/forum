class CreatePoCats < ActiveRecord::Migration
  def change
    create_table :po_cats do |t|

      t.integer :po_id
      t.integer :cat_id

      t.timestamps null: false
    end

    # add_index :po_cats, :po_id
    # add_index :po_cats, :cat_id
  end
end
