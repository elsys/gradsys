class CommitteesController < ApplicationController
  #before_action :set_committee, only: [:show, :edit, :update, :destroy]
  before_filter :access

  # GET /committees
  # GET /committees.json
  def index
    set_committees() 
  end

  # GET /committees/1
  # GET /committees/1.json
  def show
    set_committee()
  end

  # GET /committees/new
  def new
    @committee = Committee.new
  end

  # GET /committees/1/edit
  def edit
    set_committee()
  end

  # POST /committees
  # POST /committees.json
  def create
    @committee = Committee.new(committee_params)

    respond_to do |format|
      if @committee.save
        format.html { redirect_to @committee, notice: 'Committee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @committee }
      else
        format.html { render action: 'new' }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /committees/1
  # PATCH/PUT /committees/1.json
  def update
    @committee = Committee.find(params[:committee][:id])
    @committee.commissioners.clear
    for c in 1..5
      if !params[:comm].nil? 
        if !params[:comm][:"#{c}"].nil?
          @commissioner_id = params[:comm][:"#{c}"].to_i
          if @commissioner_id > 0   
            @commissioner = Teacher.find(@commissioner_id)
            if !@committee.commissioners.exists?(@commissioner)
              @committee.commissioners << @commissioner
            end 
          end 
        end 
      end    
    end
    @committee.president_id = params[:committee][:president]
    
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to @committee, notice: 'Committee was successfully updated.' }
        format.json { head :no_content }
        format.js{ render :action => "tbody" }
      else
        format.html { render action: 'edit' }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1
  # DELETE /committees/1.json
  def destroy
    set_committee()
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_url }
      format.json { head :no_content }
    end
  end

  def all
    @committees = Committee.all
  end

  def set_dates
    @assemble = Assemble.find(1)
    @assemble.committee_start_date = params[:committee][:start_date]
    @assemble.committee_end_date = params[:committee][:end_date]
    @assemble.save
    set_committees()
    respond_to do |format|
      format.js 
      format.html {redirect_to committees_url}
    end
  end 

  def set_years
    @assemble = Assemble.find(1)
    @assemble.year_for_registration = params[:year_for_registration]
    @assemble.year_for_assembling = params[:year_for_assembling]
    @assemble.save

    respond_to do |format|
      format.html {redirect_to committees_url}
    end

  end  

  def add_commissioner
    @committee = Committee.find(params[:committee_id])
    @commissioner = Teacher.find(params[:commissioner_id])
    if !@committee.commissioners.exists?(@commissioner)
      @committee.commissioners << @commissioner
    end 
    respond_to do |format|
      format.js{ render :action => "tbody" }
    end
  end

  def remove_commissioner
    @committee = Committee.find(params[:committee_id])
    @commissioner = Teacher.find(params[:commissioner_id])
    if @committee.commissioners.exists?(@commissioner)
      @committee.commissioners.delete(@commissioner.id)
    end 
    respond_to do |format|
      format.js{ render :action => "tbody" }
    end
  end

  def add_diploma_work
    @committee = Committee.find(params[:committee])
    @diploma_work = DiplomaWork.find(params[:diploma_work])
    if !@committee.diploma_works.exists?(@diploma_work)
      @committee.diploma_works << @diploma_work
    end  
    respond_to do |format|
        format.js { render action: "diploma_works" }
        format.html {redirect_to edit_committee_path(@committee) }
    end
  end  

  def remove_diploma_work
    @committee = Committee.find(params[:committee_id])
    @diploma_work = DiplomaWork.find(params[:diploma_work_id])
    if @committee.diploma_works.exists?(@diploma_work)
      @committee.diploma_works.delete(@diploma_work.id)
    end 
    respond_to do |format|
        format.js { render action: "diploma_works" }
        format.html {redirect_to edit_committee_path(@committee) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_committee
      @committee = Committee.find(params[:id])
    end

    def set_committees
      @assemble = Assemble.find(1)
      if !@assemble.committee_start_date.nil? and 
        !@assemble.committee_end_date.nil?

          @start_date = @assemble.committee_start_date.to_date.jd 
          @end_date = @assemble.committee_end_date.to_date.jd 

          @committees=Array.new
          (@start_date..@end_date).each do |date|
            @date = Date.jd(date).strftime('%d/%m/%Y')
            if Committee.find_by_date(@date).nil?
              c = Committee.create(:date => @date)
            else 
              c = Committee.find_by_date(@date) 
            end 

            @committees << c  
          end   
      end
    end   

    def access
      unless @current_user.admin?
        redirect_to admin_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def committee_params
      params.require(:committee).permit(:date)
    end

end
