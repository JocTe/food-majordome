class Menu < ApplicationRecord
  belongs_to :user
  has_many :recipes, through: :menu_plan
end
