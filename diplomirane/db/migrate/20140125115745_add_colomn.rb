class AddColomn < ActiveRecord::Migration
  def add_column
    add_column :students, :first, :integer, second, :integer, third, :integer
  end
end
