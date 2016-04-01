class Po < ActiveRecord::Base
  validates_presence_of :title

  belongs_to :user
  has_many :comments

  has_many :po_cats
  has_many :cats, :through => :po_cats

  has_many :likes
  has_many :like_users, :through => :likes, :source => :user

  has_many :subscriptions
  has_many :subscribed_users, :through => :likes, :source => :user

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  do_not_validate_attachment_file_type :logo, content_type: /\Aimage\/.*\Z/

  def find_like_by(user)
    user && self.likes.find_by_user_id(user.id)
  end

  def find_subscription_by(user)
    self.subscriptions.find_by_user_id(user.id)
  end

end
