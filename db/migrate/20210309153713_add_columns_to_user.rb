class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :diet, :string
    add_column :users, :number_of_people, :integer
    add_column :users, :budget, :string
  end
end
