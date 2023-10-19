class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :foot_stamps, dependent: :destroy
  has_many :foot_stamps_users, through: :foot_stamps, source: :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    case search
      when "perfect_match" then
        return Book.where("title LIKE?","#{word}")
      when "forward_match" then
        return Book.where("title LIKE?","#{word}%")
      when "backward_match" then
        return Book.where("title LIKE?","%#{word}")
      when "partial_match" then
        return Book.where("title LIKE?","%#{word}%")
      else
        return Book.all
    end
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }

  # has_one_attached :image

  # def get_image
  #   unless image.attached?
  #     file_path = Rails.root.join("app/assets/images/no-book.jpg")
  #     image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
  #   end
  #   image
  # end

end
