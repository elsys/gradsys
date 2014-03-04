class AddPresidentIdToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :president_id, :integer
  end
end
