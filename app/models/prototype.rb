# frozen_string_literal: true

class Prototype < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :catch_copy, :title, :concept, :image, presence: true
end
