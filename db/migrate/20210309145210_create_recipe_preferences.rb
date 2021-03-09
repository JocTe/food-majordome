class CreateRecipePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.boolean :dislike

      t.timestamps
    end
  end
end
