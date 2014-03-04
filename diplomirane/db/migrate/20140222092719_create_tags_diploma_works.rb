class CreateTagsDiplomaWorks < ActiveRecord::Migration
  def change
    create_table :diploma_works_tags do |t|
      t.integer :tag_id
      t.integer :diploma_work_id
    end
  end
end
