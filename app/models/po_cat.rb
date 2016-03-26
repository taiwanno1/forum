class PoCat < ActiveRecord::Base

  belongs_to :po
  belongs_to :cat

end
