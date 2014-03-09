class AddEgnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :egn, :integer
  end
end
