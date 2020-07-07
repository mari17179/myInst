class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login

  has_many :posts
  has_many :comments

  validates :username, presence: true
  validates :email, presence: true


  has_one_attached :user_photo
  after_commit :add_default_user_photo, on: %i[create update]

  validate :validate_username

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
