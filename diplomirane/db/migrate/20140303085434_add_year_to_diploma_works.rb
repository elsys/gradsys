class AddYearToDiplomaWorks < ActiveRecord::Migration
  def change
    add_column :diploma_works, :year, :integer
  end
end
