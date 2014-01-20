class AddDiplomaSupervisorAndReviewerAndCommissionerToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :diploma_supervisor, :boolean, :default => false
    add_column :teachers, :reviewer, :boolean, :default => false
    add_column :teachers, :commissioner, :boolean, :default => false
  end
end
