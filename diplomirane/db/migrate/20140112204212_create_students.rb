class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
			t.string :grade
			t.integer :number
    end
  end
end
