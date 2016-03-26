class CreatePos < ActiveRecord::Migration
  def change
    create_table :pos do |t|
      t.string :title
      t.text :article


      t.timestamps null: false
    end
  end
end
