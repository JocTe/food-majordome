class CreateProportions < ActiveRecord::Migration[6.0]
  def change
    create_table :proportions do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.float :amount
      t.string :unit

      t.timestamps
    end
  end
end
