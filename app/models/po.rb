class Po < ActiveRecord::Base
  validates_presence_of :title

  belongs_to :user
  has_many :comments
  has_many :po_cats
  has_many :cats, :through => :po_cats

end
