class AddGsmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gsm, :integer
  end
end
