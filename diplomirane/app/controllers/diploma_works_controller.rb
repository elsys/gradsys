class DiplomaWorksController < ApplicationController
  before_action :set_diploma_work, only: [:show, :edit, :update, :destroy]
	before_filter :access, :except => [:index, :show, :new, :create]
	before_filter :access_supervior, :except => [:index, :show]

  # GET /diploma_works
  # GET /diploma_works.json
  def index
    @diploma_works = DiplomaWork.all
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
    end
  end

  def approve_diploma_work
    @d = DiplomaWork.find(params[:id])
    @d.approved = "true"
    @d.save
    redirect_to diploma_works_url
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
      format.js { render :action => "students" }
      format.html {redirect_to edit_diploma_work_path(@diploma_work) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diploma_work
      @diploma_work = DiplomaWork.find(params[:id])
		
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
