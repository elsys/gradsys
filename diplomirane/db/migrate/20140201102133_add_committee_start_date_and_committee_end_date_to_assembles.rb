class AddCommitteeStartDateAndCommitteeEndDateToAssembles < ActiveRecord::Migration
  def change
    add_column :assembles, :committee_start_date, :string
    add_column :assembles, :committee_end_date, :string
  end
end
