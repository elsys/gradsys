class DiplomaWork < ActiveRecord::Base
	has_and_belongs_to_many :teachers, association_foreign_key: "commissioner_id", join_table: "commissioners_diploma_works"
	has_many :students

	validates :title, :presence => true, :uniqueness => true
	validates :description, :presence => true
	validates :diploma_supervisor_id,	:numericality => true
	validates :reviewer_id,	:numericality => true, :unless => lambda { self.reviewer_id.nil? }
	validate :diploma_supervisor_must_be_different_from_reviewer_id
	validates_inclusion_of :covenanted, :in => [true,false]
	validates_inclusion_of :approved, :in => [true,false]

	def diploma_supervisor_must_be_different_from_reviewer_id
		errors.add(:reviewer, "Reviewer must be different fron Diploma Supervisor") unless
       self.diploma_supervisor_id != self.reviewer_id
	end

	def diplomants_names
		@diplomants= Array.new
			self.students.each do |d|
				@diplomants << d.name
			end
			@diplomants
	end

	def commissioners_names
		@commissioners = Array.new
			self.teachers.each do |c|
				@commissioners << c.name
			end
			@commissioners
	end	
end
