class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.float :calories
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
