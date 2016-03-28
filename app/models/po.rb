class Po < ActiveRecord::Base
  validates_presence_of :title

  belongs_to :user
  has_many :comments
  has_many :po_cats
  has_many :cats, :through => :po_cats

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  do_not_validate_attachment_file_type :logo, content_type: /\Aimage\/.*\Z/

end
