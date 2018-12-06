class CreateChampions < ActiveRecord::Migration[5.2]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :role
      t.integer :attack
      t.integer :armor
      t.integer :health

      t.timestamps
    end
  end
end
