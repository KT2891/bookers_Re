class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  has_many :event_notices, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  validates :name, presence: true,
                   length: {minimum: 1, maximum: 30}
  validates :introduction, length: {maximum: 200}
  validates :owner_id, presence: true

  has_one_attached :group_image

  def get_group_image(height, width)
    unless group_image.attached?
      file_path = Rails.root.join("app/assets/images/no-group.jpg")
      group_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    group_image.variant(resize_to_limit: [height, width]).processed
  end

end
