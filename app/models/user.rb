class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :passive_follows, class_name: "Follow",
                             foreign_key: "following_id",
                             dependent: :destroy

  has_many :followers, through: :passive_follows, source: :follower

  has_many :active_follows, class_name: "Follow",
                            foreign_key: "follower_id",
                            dependent: :destroy

  has_many :followings, through: :active_follows, source: :following

  def follow(user_to_follow)
    active_follows.create(following_id: user_to_follow.id)
  end

  def unfollow(user_to_unfollow)
    active_follows.find_by(following_id: user_to_unfollow.id).destroy
  end

  def following?(other_user)
    following_ids.include?(other_user.id)
  end

  def followersNumber
    Follow.where(following_id: self.id).count
  end

  def followingNumber
    Follow.where(follower_id: self.id).count
  end

  def postsNumber
    Post.where(user_id: self.id).count
  end

  def likes?(post)
    Like.find_by(user_id: self.id, post_id: post.id)
  end

  def like(post)
    Like.create(user_id: self.id, post_id: post.id)
  end

  def dislike(post)
    Like.find_by(user_id: self.id, post_id: post.id).destroy
  end

  validates :username, presence: true
  validates :email, presence: true

  has_one_attached :user_photo

  after_commit :add_default_user_photo, on: %i[create update]

  validate :validate_username

  attr_writer :login

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def login
    @login || self.username
  end

  def self.find_for_database_authentication(warden_conditions)
     conditions = warden_conditions.dup
     if login = conditions.delete(:login)
       where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
     elsif conditions.has_key?(:username) || conditions.has_key?(:email)
       where(conditions.to_h).first
     end
   end

   def user_photo_thumbnail
     if user_photo.attached?
        user_photo.variant(resize: "30x30!").processed
     else
        '/default_user_photo.jpg'
     end
   end

   def user_photo_follow_thumbnail
     if user_photo.attached?
        user_photo.variant(resize: "60x60!").processed
     else
        '/default_user_photo.jpg'
     end
   end

   def user_photo_full_thumbnail
     if user_photo.attached?
        user_photo.variant(resize: "200x200!").processed
     else
        '/default_user_photo.jpg'
     end
   end

   private
   def add_default_user_photo
      unless user_photo.attached?
        user_photo.attach(
          io: File.open(
            Rails.root.join(
              'app', 'assets', 'images', 'default_user_photo.jpg'
            )
          ),
          filename: 'default_user_photo.jpg',
          content_type: 'image/jpg'
        )
      end
   end

end
