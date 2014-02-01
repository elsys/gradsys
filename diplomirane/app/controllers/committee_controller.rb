class CommitteeController < ApplicationController
  def index
  	@committee = Committee.find(1)

  	@start_date = @committee.start_date.to_date.jd 
    @end_date = @committee.end_date.to_date.jd
    @all_dates=Array.new
    (@start_date..@end_date).each do |date|
      @all_dates << Date.jd(date).strftime('%d/%m/%Y')
    end  
  end

  def set_dates
  	@committee = Committee.find(1)
  	@committee.start_date = params[:committee][:start_date]
  	@committee.end_date = params[:committee][:end_date]
  	@committee.save
  	redirect_to committee_url
  end	

 
end
