class AddLogoToPos < ActiveRecord::Migration
  def change
    add_attachment :pos, :logo
  end
end
