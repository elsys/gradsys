class Committee < ActiveRecord::Base
	has_and_belongs_to_many :commissioners, class_name: "Teacher", association_foreign_key: "commissioner_id", join_table: "commissioners_committees"
	has_many :diploma_works
	validates :date, :presence => true, :uniqueness => true
end
