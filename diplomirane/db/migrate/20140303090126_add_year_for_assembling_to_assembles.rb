class AddYearForAssemblingToAssembles < ActiveRecord::Migration
  def change
    add_column :assembles, :year_for_assembling, :integer
  end
end
