class Cat < ActiveRecord::Base
  has_many :po_cats
  has_many :pos, :through => :po_cats
end

