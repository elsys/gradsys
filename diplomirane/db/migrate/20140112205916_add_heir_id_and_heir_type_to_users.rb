class AddHeirIdAndHeirTypeToUsers < ActiveRecord::Migration
  def change
		change_table :users do |t|
			t.integer :heir_id
      t.string :heir_type
		end
  end
end
