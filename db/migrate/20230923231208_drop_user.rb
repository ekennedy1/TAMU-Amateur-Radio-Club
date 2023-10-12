class DropUser < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :comments, :users
    remove_foreign_key :posts, :users
    drop_table :users
  end
  

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
