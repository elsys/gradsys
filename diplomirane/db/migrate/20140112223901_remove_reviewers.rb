class RemoveReviewers < ActiveRecord::Migration
  def change
		drop_table :reviewers
  end
end
