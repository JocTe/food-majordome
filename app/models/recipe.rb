class Recipe < ApplicationRecord
  has_many :proportions
  has_many :ingredients, through: :proportions
  has_many :reviews
end
