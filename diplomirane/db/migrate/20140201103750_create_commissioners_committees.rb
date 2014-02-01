class CreateCommissionersCommittees < ActiveRecord::Migration
  def change
    create_table :commissioners_committees do |t|
      t.integer :committee_id
      t.integer :commissioner_id
    end
  end
end
