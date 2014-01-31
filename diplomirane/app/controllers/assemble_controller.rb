class AssembleController < ApplicationController
  def index
    @students = Student.all
  end

  def sort
  	@students = Student.all
  
  end  

  def get_student	
  	s = Student.find(params[:id])
  	s.diploma_work_id = params[:diploma_work_id]
  	s.save
  	redirect_to assemble_url
  end	

  def remove_student
  	s = Student.find(params[:id])
  	s.diploma_work_id = nil
  	s.save
  	redirect_to assemble_url
  end	

end