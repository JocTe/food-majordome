class AddIngredientIdToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :spoon_ingredient_id, :integer
  end
end
