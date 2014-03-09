class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_students, only: [:index, :set_year]
	before_filter :access, :except => [:index, :show, :set_year]

	require 'csv'

  # GET /students
  # GET /students.json
  def index
  end

  # GET /students/1
  # GET /students/1.json
  def show
	respond_to do |format|
		format.html
		format.pdf do
			pdf = Prawn::Document.new
			pdf.text "hello"
			send_data pdf.render, filename: "molba.pdf",
				type: "application/pdf",
				disposition: "inline"
		 end
	 end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @assemble = Assemble.find(1)
    @year = @assemble.year_for_registration 

		file_data = params[:student][:file]
		if !file_data.nil? and @current_user.admin?
			CSV.foreach(file_data.path) do |row|
				@grade = row[0]
				@number = row[1]
				@name = row[2]
        @egn = row[3]
				@email = row[4]
        @skype = row[5]
				@student_params = { "user_name" => "#{@email}", "name" => "#{@name}", 
        "email" => "#{@email}", "number" => "#{@number}", "grade" => "#{@grade}", 
        "egn" => "#{@egn}", "skype" => "#{@skype}"}   
		  	@student = Student.new(@student_params)
        @student.year = @year
				@student.save
				Student.update_all("id = '#{@student.predecessor.id}'", "id = '#{@student.id}'")
				User.where("heir_type = 'Student'").update_all("heir_id = '#{@student.predecessor.id}'", "heir_id = '#{@student.id}'")
				#UserMailer.welcome_email(@student,"#{@student.activation_code}").deliver
			end	
      redirect_to students_url
		else
			@student = Student.new(student_params)
      @student.year = @year
      @student.current_user =  @current_user
      respond_to do |format|
        if @student.save
          Student.update_all("id = '#{@student.predecessor.id}'", "id = '#{@student.id}'")
          User.where("heir_type = 'Student'").update_all("heir_id = '#{@student.predecessor.id}'", "heir_id = '#{@student.id}'")		 
          #UserMailer.welcome_email(@student,"#{@student.activation_code}").deliver
          format.html { redirect_to students_url, notice: 'Student was successfully created.' }
        else
          format.html { render action: 'new' }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    @student.current_user =  @current_user
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  def set_year
    @year = params[:year]

    respond_to do |format|
      format.js { render action: "tbody" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    def set_students
      @students = Student.all
    end  

		def access
			if @student
				you = (@student.id == @current_user.id)
			end
			unless @current_user.admin? or you
        redirect_to students_url
      end
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
			if @current_user.admin?
      	params.require(:student).permit(:user_name, :name, :password, :password_confirmation, :grade, :number, :grades, :year, :diploma_work_id, :first, :second, :third, :access, :active)
			else 
				params.require(:student).permit(:password, :password_confirmation, :current_password, :first, :second, :third)
			end
    end
end
