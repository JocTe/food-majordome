class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :grade
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
