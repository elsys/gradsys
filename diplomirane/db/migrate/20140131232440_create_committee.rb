class CreateCommittee < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.string :start_date
      t.string :end_date
    end
  end
end
