class BookTag < ApplicationRecord
  belongs_to :book

  validates :tag, length: { maximum: 20 }

end
