class AddActiveAndActivationCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean, :default => false
    add_column :users, :activation_code, :string
  end
end
