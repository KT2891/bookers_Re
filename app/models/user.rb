class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :foot_stamps, dependent: :destroy
  has_many :foot_stamps_books, through: :foot_stamps, source: :book

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, source: :group
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id'



  validates :name, presence: true,
                   uniqueness: true,
                   length: {minimum: 2, maximum: 20}

  validates :introduction, length: { maximum: 50 }

  has_one_attached :profile_image

  def get_profile_image(height, width)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no-image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [height, width]).processed
  end

  def followed_by?(user)
    following.include?(user)
  end

  def self.looks(search, word)
    case search
      when "perfect_match" then
        return User.where("name LIKE?","#{word}")
      when "forward_match" then
        return User.where("name LIKE?","#{word}%")
      when "backward_match" then
        return User.where("name LIKE?","%#{word}")
      when "partial_match" then
        return User.where("name LIKE?","%#{word}%")
      else
        return User.all
    end
  end

end
