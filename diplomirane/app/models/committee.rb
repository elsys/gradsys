class Committee < ActiveRecord::Base
	has_and_belongs_to_many :commissioners, class_name: "Teacher", association_foreign_key: "commissioner_id", join_table: "commissioners_committees"
	validates :date, :presence => true, :uniqueness => true


	def commissioners_names
		@commissioners = Array.new
			self.commissioners.each do |c|
				@commissioners << c.name
			end
			@commissioners
	end

end
