class DiplomaWorksController < ApplicationController
  before_action :set_diploma_work, only: [:show, :edit, :update, :destroy]
  before_action :set_diploma_works, only: [:index, :destroy, :approve_diploma_work, :set_year]
  before_filter :admin_access, :except => [:index, :show, :new, :create, :destroy, :set_year, :covenanted]
	before_filter :access, :except => [:index, :show, :new, :create, :set_year, :covenanted]
	before_filter :access_supervior, :except => [:index, :show, :set_year, :covenanted]

  # GET /diploma_works
  # GET /diploma_works.json
  def index
  end

  # GET /diploma_works/1
  # GET /diploma_works/1.json
  def show
  end

  # GET /diploma_works/new
  def new
    @diploma_work = DiplomaWork.new
  end

  # GET /diploma_works/1/edit
  def edit
  end

  # POST /diploma_works
  # POST /diploma_works.json
  def create
    @diploma_work = DiplomaWork.new(diploma_work_params)

    @assemble = Assemble.find(1)
    @year = @assemble.year_for_registration
    @diploma_work.year = @year 

    @tags = params[:tags].split(",")
    @tags.each do |tag|
      if t = Tag.find_by_name(tag)
        @diploma_work.tags << t
      else  
        t = Tag.create(name: tag)
        @diploma_work.tags << t
      end  
    end

    respond_to do |format|
      if @diploma_work.save
        @diplomants_values = params[:diplomants_values].to_i
        @diploma_work.students.clear
        for d in 1..@diplomants_values
          if !params[:"diplomant(#{d})"].nil?
            @diplomant_id = params[:"diplomant(#{d})"].to_i
            if @diplomant_id > 0   
              @diplomant = Student.find(@diplomant_id)
              if !@diploma_work.students.exists?(@diplomant)
                @diplomant.current_user = @current_user
                @diploma_work.students << @diplomant
              end 
            end
          end
        end
        
        format.html { redirect_to @diploma_work, notice: 'Diploma work was successfully created.' }
        format.json { render action: 'show', status: :created, location: @diploma_work }
      else
        format.html { render action: 'new' }
        format.json { render json: @diploma_work.errors, status: :unprocessable_entity }
      end
    end
  end

 

  # PATCH/PUT /diploma_works/1
  # PATCH/PUT /diploma_works/1.json
  def update
    @tags = params[:tags].downcase.split(",")
    @diploma_work.tags.clear
    @tags.each do |tag|
      if t = Tag.find_by_name(tag)
        @diploma_work.tags << t
      else  
        t = Tag.create(name: tag)
        @diploma_work.tags << t
      end  
    end  

    respond_to do |format|
      if @diploma_work.update(diploma_work_params)
        format.html { redirect_to @diploma_work, notice: 'Diploma work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @diploma_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diploma_works/1
  # DELETE /diploma_works/1.json
  def destroy
    @diploma_work.destroy
    respond_to do |format|
      format.html { redirect_to diploma_works_url }
      format.json { head :no_content }
      format.js { render action: "tbody" }
    end
  end

  def covenanted
    @covenanted = params[:covenanted]
    @diploma_work = DiplomaWork.new 

    respond_to do |format|
      format.js { render action: "covenanted" }
    end
  end  

  def approve_diploma_work
    @d = DiplomaWork.find(params[:id])
    @d.approved = "true"
    @d.save

    respond_to do |format|
      format.js { render action: "tbody" }
    end
  end

  def add_student
    @diploma_work = DiplomaWork.find(params[:diploma_work_id])
    @student = Student.find(params[:student_id])
    @student.current_user = @current_user
    if !@diploma_work.students.exists?(@student) 
      @diploma_work.students << @student
    end  
    respond_to do |format|
      format.js{ render :action => "students" }
      format.html {redirect_to edit_diploma_work_path(@diploma_work) }
    end
  end  

  def remove_student
    @diploma_work = DiplomaWork.find(params[:diploma_work_id])
    @student = Student.find(params[:student_id])
    if @diploma_work.students.exists?(@student)
      @diploma_work.students.delete(@student.id)
    end 
    respond_to do |format|
      format.js { render action: "students" }
      format.html {redirect_to edit_diploma_work_path(@diploma_work) }
    end
  end

  def add_student_field
    @s = Student.find(params[:student_id])
    @diploma_work = DiplomaWork.new
    @br = params[:br].to_i
    @br+= 1

    respond_to do |format|
      format.js
    end
  end
  
  def remove_student_field
    @id = params[:id]

    respond_to do |format|
      format.js
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
    def set_diploma_work
      @diploma_work = DiplomaWork.find(params[:id])
    end

    def set_diploma_works
      @diploma_works = DiplomaWork.all
    end

    def admin_access
      unless @current_user.admin?      
        redirect_to diploma_works_url
      end
    end  

		def access
			if @diploma_work
				you = (@diploma_work.diploma_supervisor_id == @current_user.id)
			end
      unless you or @current_user.admin?  		
        redirect_to diploma_works_url
      end
    end

		def access_supervior
			if @current_user.predecessor.heir_type == "Teacher" 
		    unless @current_user.diploma_supervisor 		
		      redirect_to diploma_works_url
		    end
			elsif !@current_user.admin?
					redirect_to diploma_works_url
			end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diploma_work_params
      if @current_user.admin?
        params.require(:diploma_work).permit(:title, :description, :diploma_supervisor_id, :reviewer_id, :committee_id, :diplomants_number, :year, :covenanted, :approved)
      else
         params.require(:diploma_work).permit(:title, :description, :diploma_supervisor_id, :diplomants_number, :covenanted)
      end
    end
end
