# frozen_string_literal: true

class AddParamsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :role, :string
  end
end
