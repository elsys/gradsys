class AssemblingController < ApplicationController
	has_and_belongs_to_many :students, foreign_key: "students", "grades", "first", "second", "third"
	
	
	
	
	
	
	
end



  

