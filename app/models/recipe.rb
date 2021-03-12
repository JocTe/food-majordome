class Recipe < ApplicationRecord
  belongs_to :user
  has_many :steps
  has_many :proportions
  has_many :ingredients, through: :proportions
  has_many :reviews
end
