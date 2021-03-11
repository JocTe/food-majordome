class AddCuisineToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :cuisines, :string, array: true, default: []
  end
end
