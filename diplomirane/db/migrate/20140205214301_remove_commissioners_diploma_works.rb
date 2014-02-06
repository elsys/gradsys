class RemoveCommissionersDiplomaWorks < ActiveRecord::Migration
  def change
  	drop_table :commissioners_diploma_works
  end
end
