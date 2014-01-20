class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
	before_filter :access, :except => [:index, :show]

	require 'csv'

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
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
		file_data = params[:student][:file]
		if !file_data.nil? and @current_user.admin?
			CSV.foreach(file_data.path) do |row|
				@grade = row[0]
				@number = row[1]
				@name = row[2]
				@email = row[4]
				@student_params = { "user_name" => "#{@email}", "name" => "#{@name}", "email" => "#{@email}", "number" => "#{@number}", "grade" => "#{@grade}", "password" => "1234"}   
		  	@student = Student.new(@student_params)
				@student.save
				Student.update_all("id = '#{@student.predecessor.id}'", "id = '#{@student.id}'")
				User.where("heir_type = 'Student'").update_all("heir_id = '#{@student.predecessor.id}'", "heir_id = '#{@student.id}'")
				#UserMailer.welcome_email(@student,"#{@student.activation_code}").deliver
			end	
		else
			@student = Student.new(student_params)
      Student.update_all("id = '#{@student.predecessor.id}'", "id = '#{@student.id}'")
      User.where("heir_type = 'Student'").update_all("heir_id = '#{@student.predecessor.id}'", "heir_id = '#{@student.id}'")
			#UserMailer.welcome_email(@student,"#{@student.activation_code}").deliver
		end


    respond_to do |format|
      if @student.save		 
        format.html { redirect_to students_url, notice: 'Student was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|

  		if !@current_user.admin?
  			if	User.authenticate(@student.user_name, params[:student][:old_password])
  					#@student.update_attribute(:password, "#{params[:student][:password]}")
            if @student.update(student_params)
              format.html { redirect_to @student, notice: 'Student was successfully updated.' }
              format.json { head :no_content }
            else
              format.html { render action: 'edit' }
              format.json { render json: @student.errors, status: :unprocessable_entity }
            end
  			else
  					params[:student][:password] = ""
            @student.errors.add(:old_password, "not correct")
            format.html { render action: 'edit' }
            format.json { render json: @student.errors, status: :unprocessable_entity }
  			end
      else
        if @student.update(student_params)
          format.html { redirect_to @student, notice: 'Student was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end  
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
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
      	params.require(:student).permit(:user_name, :name, :password, :password_confirmation, :grade, :number, :diploma_work_id, :access)
			else 
				params.require(:student).permit(:password, :password_confirmation)
			end
    end
end
