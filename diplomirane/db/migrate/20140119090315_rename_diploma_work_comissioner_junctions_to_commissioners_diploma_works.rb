class RenameDiplomaWorkComissionerJunctionsToCommissionersDiplomaWorks < ActiveRecord::Migration
  def change
		rename_table :diploma_work_commissioner_junctions, :commissioners_diploma_works 
  end
end
