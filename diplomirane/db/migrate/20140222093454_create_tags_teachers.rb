class CreateTagsTeachers < ActiveRecord::Migration
  def change
    create_table :tags_teachers do |t|
      t.integer :tag_id
      t.integer :teacher_id
    end
  end
end
