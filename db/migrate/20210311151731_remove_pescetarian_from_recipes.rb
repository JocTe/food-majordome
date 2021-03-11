class RemovePescetarianFromRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :pescetarian, :boolean
  end
end
