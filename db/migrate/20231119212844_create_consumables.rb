class CreateConsumables < ActiveRecord::Migration[7.0]
  def change
    create_table :consumables do |t|
      t.string :name
      t.text :description
      t.integer :quantity_remaining

      t.timestamps
    end
  end
end
