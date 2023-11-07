# frozen_string_literal: true

class AddCallsignToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :callsign, :string
  end
end
