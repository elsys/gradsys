class AddDateToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :date, :string
  end
end
