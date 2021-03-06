class User < ApplicationRecord
  has_many :user_ingredients
  has_many :reviews
  has_many :recipe_preferences
  has_many :menus

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
