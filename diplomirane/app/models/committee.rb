class Committee < ActiveRecord::Base
	has_and_belongs_to_many :commissioners, class_name: "Teacher", association_foreign_key: "commissioner_id", join_table: "commissioners_committees"
	has_many :diploma_works
	belongs_to :president, class_name: "Teacher", foreign_key: "president_id"
	validates :date, :presence => true, :uniqueness => true
end
