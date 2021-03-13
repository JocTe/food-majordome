class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_plans, dependent: :destroy
  has_many :recipes, through: :menu_plans
end
