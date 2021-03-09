class RemoveReviewFromRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :recipes, :review, null: false, foreign_key: true
  end
end
