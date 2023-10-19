class EventNotice < ApplicationRecord
  belongs_to :group

  validates :title, presence: true,
                    length: {maximum: 30}
  validates :body, presence: true,
                   length: {maximum: 200}
end
