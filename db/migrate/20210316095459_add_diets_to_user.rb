class AddDietsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :vegan, :boolean
    add_column :users, :vegetarian, :boolean
    add_column :users, :gluten_free, :boolean
    add_column :users, :dairy_free, :boolean
    add_column :users, :pescetarian, :boolean
    add_column :users, :no_diet, :boolean
  end
end
