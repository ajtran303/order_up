class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :quantity
      t.string :units
      t.integer :calories_per_unit

      t.timestamps
    end
  end
end
