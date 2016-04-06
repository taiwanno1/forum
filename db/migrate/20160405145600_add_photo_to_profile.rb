class AddPhotoToProfile < ActiveRecord::Migration
  def change
    add_attachment :profiles, :pic
  end
end
