class RemoveStartDateAndEndDateFromCommittees < ActiveRecord::Migration
  def change
  	remove_column :committees, :start_date
  	remove_column :committees, :end_date
  end
end
