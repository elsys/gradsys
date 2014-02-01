class AddCommissionerDatesToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :commissioner_dates, :string
  end
end
