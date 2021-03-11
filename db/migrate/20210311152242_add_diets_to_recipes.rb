class AddDietsToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :diets, :string, array: true, default: []
  end
end
