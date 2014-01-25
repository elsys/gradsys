class AddColumn < ActiveRecord::Migration
  def change
	add_column :students, :first, :integer
	add_column :students, :second, :integer
	add_column :students, :third, :integer
  end
end
