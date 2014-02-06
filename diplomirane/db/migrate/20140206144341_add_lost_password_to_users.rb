class AddLostPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lost_password, :boolean, :default => false
  end
end
