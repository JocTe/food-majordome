class Recipe < ApplicationRecord
  has_many :proportions, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :ingredients, through: :proportions
  has_many :reviews
end
