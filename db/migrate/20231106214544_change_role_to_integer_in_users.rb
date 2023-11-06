class ChangeRoleToIntegerInUsers < ActiveRecord::Migration[7.0]
  def up
    # Convert role to integer by mapping existing string values to integers
    User.where(role: 'admin').update_all(role: 1)
    User.where(role: 'member').update_all(role: 0)

    # Change the column to integer
    change_column :users, :role, 'integer USING CAST(role AS integer)'
  end

  def down
    # Change the column back to string
    change_column :users, :role, :string
  end
end
