class AddRecipeToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :recipe, null: false, foreign_key: true
  end
end
