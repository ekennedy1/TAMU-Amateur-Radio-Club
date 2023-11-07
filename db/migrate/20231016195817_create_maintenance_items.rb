# frozen_string_literal: true

class CreateMaintenanceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :maintenance_items do |t|
      t.string :item_name
      t.string :description
      t.integer :total_amount
      t.integer :available_amount

      t.timestamps
    end
  end
end
