class CreateMenuPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_plans do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
