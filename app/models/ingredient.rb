class Ingredient < ApplicationRecord
  has_many :proportions
  has_many :recipes, through: :proportions
end
