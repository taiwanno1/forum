class Like < ActiveRecord::Base
  belongs_to :po
  belongs_to :user
end
