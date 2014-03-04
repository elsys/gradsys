class Tag < ActiveRecord::Base
	has_and_belongs_to_many :diploma_works
	has_and_belongs_to_many :teachers

	validates :name, :uniqueness => true
end
