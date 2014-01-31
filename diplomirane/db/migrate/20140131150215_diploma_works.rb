class DiplomaWorks < ActiveRecord::Migration
  def change
	add_column :diploma_works, :checkout, :boolean
  end
end
