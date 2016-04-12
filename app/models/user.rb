class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :pos
  has_many :comments

  has_many :likes
  has_many :like_pos, :through => :likes, :source => :po

  has_many :subscriptions
  has_many :subscribed_pos, :through => :likes,  :source => :pos

# I add friend
  has_many :friendships
  has_many :friends, :through => :friendships # friendships的friend_id就是user's friend
  #Friendship.where(user_id: User.first)
  #User.first.friends
  # friend_to_user friend_id -> user_id

# friend add Me
          #撞名，其實就是friendship   #指定用friendship       #告訴friendship要從friend_id去找
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
                                                              #使用user的物件
  #Friendship.where(firend_id: User.first)
  #User.first.inverse_friends

  has_one :profile

  after_create :create_new_profile

  def short_name
    self.email.split("@").first
  end

  def create_new_profile
    self.create_profile
  end

  def friend_confirm

  end

  def get_fb_data
    j = RestClient.get "https://graph.facebook.com/v2.5/me", :params => { :access_token => self.fb_token, :fields => "id,name,email,picture" }
    JSON.parse(j)
  end

  def self.from_omniauth(auth)
     # Case 1: Find existing user by facebook uid
     user = User.find_by_fb_uid( auth.uid )
     if user
        user.fb_token = auth.credentials.token
        #user.fb_raw_data = auth
        user.save!
       return user
     end

     # Case 2: Find existing user by email
     existing_user = User.find_by_email( auth.info.email )
     if existing_user
       existing_user.fb_uid = auth.uid
       existing_user.fb_token = auth.credentials.token
       #existing_user.fb_raw_data = auth
       existing_user.save!
       return existing_user
     end

     # Case 3: Create new password
     user = User.new
     user.fb_uid = auth.uid
     user.fb_token = auth.credentials.token
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     #user.fb_raw_data = auth
     user.save!
     return user
  end
  # def find_friendship_by(friend)
  #   friend && self.friendshipos.find_by_friend_id(friend.id)
  # end


end
