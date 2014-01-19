class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
			t.string :business
    end
  end
end
