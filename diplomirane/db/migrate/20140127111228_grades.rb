class Grades < ActiveRecord::Migration
  def change
		add_column :students, :grades, :integer
  end
end
