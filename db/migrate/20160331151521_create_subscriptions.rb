class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|

      t.integer :user_id, :index => true
      t.integer :po_id, :index => true

      t.timestamps null: false
    end
  end
end
