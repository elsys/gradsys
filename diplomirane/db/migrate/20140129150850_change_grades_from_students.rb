class ChangeGradesFromStudents < ActiveRecord::Migration
  def change
  	change_column :students, :grades, :float
  end
end
