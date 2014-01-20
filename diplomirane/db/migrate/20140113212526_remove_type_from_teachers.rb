class RemoveTypeFromTeachers < ActiveRecord::Migration
  def change
		remove_column :teachers, :type
  end
end
