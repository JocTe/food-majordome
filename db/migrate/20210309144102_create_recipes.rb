class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.integer :servings
      t.float :prep_time
      t.references :review, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :score
      t.float :health_score
      t.float :calories
      t.string :name
      t.text :summary
      t.string :image
      t.boolean :cheap
      t.boolean :dairy_free
      t.boolean :gluten_free
      t.boolean :vegan
      t.boolean :vegetarian
      t.boolean :healthy
      t.boolean :pescetarian
      t.string :cuisine
      t.string :author

      t.timestamps
    end
  end
end
