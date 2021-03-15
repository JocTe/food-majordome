class Recipe < ApplicationRecord
  has_many :proportions, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :ingredients, through: :proportions
  has_many :menu_plans
  has_many :menus, through: :menu_plans
  has_many :reviews
end
