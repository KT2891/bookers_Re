class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :foot_stamps, dependent: :destroy
  has_many :foot_stamps_users, through: :foot_stamps, source: :user
  has_many :book_tags, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    case search
    when "perfect_match" then
      Book.where("title LIKE?", "#{word}")
    when "forward_match" then
      Book.where("title LIKE?", "#{word}%")
    when "backward_match" then
      Book.where("title LIKE?", "%#{word}")
    when "partial_match" then
      Book.where("title LIKE?", "%#{word}%")
    else
      Book.all
    end
  end

  scope :created_on, ->(date) {
  where(created_at: date.all_day)
}

  # has_one_attached :image

  # def get_image
  #   unless image.attached?
  #     file_path = Rails.root.join("app/assets/images/no-book.jpg")
  #     image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
  #   end
  #   image
  # end
end
