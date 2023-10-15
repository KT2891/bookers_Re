class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}

  # has_one_attached :image

  # def get_image
  #   unless image.attached?
  #     file_path = Rails.root.join("app/assets/images/no-book.jpg")
  #     image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
  #   end
  #   image
  # end

end
