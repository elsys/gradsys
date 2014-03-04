class AddYearForRegistrationToAssembles < ActiveRecord::Migration
  def change
    add_column :assembles, :year_for_registration, :integer
  end
end
