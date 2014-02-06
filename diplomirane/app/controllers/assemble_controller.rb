class AssembleController < ApplicationController
  before_filter :access

  def index
  	@assemble = Assemble.find(1)
    @students = Student.all
  end 

  def get_student	
  	@s = Student.find(params[:id])
    @d = DiplomaWork.find(params[:diploma_work_id])
  	@s.diploma_work_id = @d.id
  	@s.save
    respond_to do |format|
      format.js
    end
  end	

  def remove_student
  	@s = Student.find(params[:id])
    @d = DiplomaWork.find(params[:diploma_work_id])
  	@s.diploma_work_id = nil
  	@s.save
    respond_to do |format|
      format.js
    end
  end	

  def next_round
  	@assemble = Assemble.find(1)
  	@round = @assemble.round
  	@next_round = case @round
  		when nil then "none"
  		when "none" then "none"
  		when "first" then "second"
  		when "second" then "third"
  		when "third" then "third"
  	end	
  	@assemble.round = @next_round
  	@assemble.save
  	redirect_to assemble_url

  end

  def new_round
  	@assemble = Assemble.find(1)
  	@assemble.round = "first"
  	@assemble.save
  	redirect_to assemble_url
  end

    def remove_round
  	@assemble = Assemble.find(1)
  	@assemble.round = "none"
  	@assemble.save
  	redirect_to assemble_url
  end

  private

    def access
      unless @current_user.admin? or @current_user.predecessor.heir_type == "Teacher"
        redirect_to admin_url
      end
    end
end