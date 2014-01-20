class AddTypeForTeachers < ActiveRecord::Migration
  def change
		change_table :teachers do |t|
			t.string :type
		end
  end
end
