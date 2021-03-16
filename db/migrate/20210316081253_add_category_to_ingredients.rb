class AddCategoryToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :category, :string
  end
end
