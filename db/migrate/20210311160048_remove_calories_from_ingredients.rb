class RemoveCaloriesFromIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_column :ingredients, :calories, :float
  end
end
