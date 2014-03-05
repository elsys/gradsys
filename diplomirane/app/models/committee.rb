class Committee < ActiveRecord::Base
	has_and_belongs_to_many :commissioners, class_name: "Teacher", association_foreign_key: "commissioner_id", join_table: "commissioners_committees"
	has_many :diploma_works
	belongs_to :president, class_name: "Teacher", foreign_key: "president_id"
	validates :date, :presence => true, :uniqueness => true

	def tags
		@tags = Array.new
		self.commissioners.each do |commissioner|
			commissioner.tags.each do |tag|
				if !@tags.include?(tag)
					@tags << tag
				end	
			end	
		end	
		@tags
	end

	def check_tags(diploma_work)
		@committee_tags = self.tags.map(&:name)
		@diploma_work_tags = diploma_work.tags.map(&:name)
		@intersection = (@committee_tags & @diploma_work_tags)
		@intersection.length
	end	

end
