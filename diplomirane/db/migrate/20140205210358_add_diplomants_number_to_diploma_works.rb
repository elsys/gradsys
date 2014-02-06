class AddDiplomantsNumberToDiplomaWorks < ActiveRecord::Migration
  def change
    add_column :diploma_works, :diplomants_number, :integer
  end
end
