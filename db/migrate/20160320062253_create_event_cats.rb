class CreateEventCats < ActiveRecord::Migration
  def change
    create_table :event_cats do |t|

      t.integer :po_id
      t.integer :cat_id

      t.timestamps null: false
    end

    # add_index :po_cat, :po_id
    # add_index :po_cat, :cat_id

  end
end
