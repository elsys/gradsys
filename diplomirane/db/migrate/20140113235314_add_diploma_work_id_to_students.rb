class AddDiplomaWorkIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :diploma_work_id, :integer
  end
end
