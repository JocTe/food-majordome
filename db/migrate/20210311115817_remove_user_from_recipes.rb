class RemoveUserFromRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :recipes, :user, null: false, foreign_key: true
  end
end
