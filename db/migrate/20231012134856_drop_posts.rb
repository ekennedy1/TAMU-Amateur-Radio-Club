# frozen_string_literal: true

class DropPosts < ActiveRecord::Migration[7.0]
  def up
    drop_table :posts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
