class AssembleController < ApplicationController
  def index
    @students = Student.all
  end

  def sort
  	@students = Student.all
  
  end  

end