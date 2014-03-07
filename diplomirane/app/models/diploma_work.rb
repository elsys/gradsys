# encoding: UTF-8
class DiplomaWork < ActiveRecord::Base
	belongs_to :committee
	has_many :students
	belongs_to :diploma_supervisor, class_name: "Teacher", foreign_key: "diploma_supervisor_id"
	has_and_belongs_to_many :tags

	validates :title, :presence => true, uniqueness: true
	validates :description, :presence => true
	validates :diploma_supervisor_id, :presence => true 
	validates :reviewer_id, :presence => true, :unless => lambda { self.reviewer_id.nil? }
	#validates :diplomants_number,	:numericality => true, :unless => lambda { self.covenanted == false }
	validate :diploma_supervisor_must_be_different_from_reviewer_id
	validates_inclusion_of :covenanted, :in => [true,false]
	validates_inclusion_of :approved, :in => [true,false]

	def diploma_supervisor_must_be_different_from_reviewer_id
		errors.add(:reviewer, "Рецензента трябва да бъде различен от Дипломния ръководител") unless
       self.diploma_supervisor_id != self.reviewer_id
	end

end
