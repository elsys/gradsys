class CreateReviewers < ActiveRecord::Migration
  def change
    create_table :reviewers do |t|
			t.string :review
    end
  end
end
