class Article < ApplicationRecord
  has_many :comments
  # title value must be present
  validates :title, presence: true
  # body value must also be present, and also the length should be more than 9
  validates :body, presence: true, length: { minimum: 10 }
end
