# frozen_string_literal: true

class Transactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :email
      t.string :serial_number
      t.boolean :approved

      t.timestamps
    end
  end
end
