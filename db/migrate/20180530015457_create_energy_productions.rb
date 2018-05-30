class CreateEnergyProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :energy_productions do |t|
      t.integer :label, null: false
      t.references :house, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.float :temperature, null: false
      t.float :daylight, null: false
      t.integer :energy_production, null: false

      t.timestamps
    end
    add_index :energy_productions, :Temperature
    add_index :energy_productions, :Daylight
    add_index :energy_productions, [:Year, :Month]
  end
end
