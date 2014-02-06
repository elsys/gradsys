class DiplomaWork < ActiveRecord::Base
	belongs_to :committee
	has_many :students
	belongs_to :diploma_supervisor, class_name: "Teacher", foreign_key: "diploma_supervisor_id"

	validates :title, :presence => true, :uniqueness => true
	validates :description, :presence => true
	validates :diploma_supervisor_id,	:numericality => true
	validates :reviewer_id,	:numericality => true, :unless => lambda { self.reviewer_id.nil? }
	validates :diplomants_number,	:numericality => true, :unless => lambda { self.covenanted == true }
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
			self.commissioners.each do |c|
				@commissioners << c.name
			end
			@commissioners
	end	
end
