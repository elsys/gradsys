class AddCommitteeIdToDiplomaWorks < ActiveRecord::Migration
  def change
    add_column :diploma_works, :committee_id, :integer
  end
end
