class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # has_one_attached :image

  # def get_image
  #   unless image.attached?
  #     file_path = Rails.root.join("app/assets/images/no-book.jpg")
  #     image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
  #   end
  #   image
  # end

end
