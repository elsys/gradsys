class CreateAssemble < ActiveRecord::Migration
  def change
    create_table :assembles do |t|
      t.string :round
    end
  end
end
