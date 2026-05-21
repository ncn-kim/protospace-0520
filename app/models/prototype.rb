class Prototype < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :catch_copy, presence: true
  validates :concept, presence: true

end
