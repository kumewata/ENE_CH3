class CreateEnergyProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :energy_productions do |t|
      t.integer :Label
      t.integer :House
      t.integer :Year
      t.integer :Month
      t.float :Temperature
      t.float :Daylight

      t.timestamps
    end
    add_index :energy_productions, :Temperature
    add_index :energy_productions, :Daylight
    add_index :energy_productions, [:Year, :Month]
  end
end
