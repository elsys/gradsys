class AssembleController < ApplicationController
  def index
    @students = Student.all
  end
  

end