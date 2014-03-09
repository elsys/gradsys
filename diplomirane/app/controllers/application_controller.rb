class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	before_filter :authorize
	before_action :set_current_user
	before_action :set_assemble
  protect_from_forgery with: :exception

	
	protected

    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end
    end	
		
		def set_current_user
			if @cur_user = User.find_by_id(session[:user_id])
				if @cur_user.heir_type == "Student"
					@current_user = Student.find_by_id(@cur_user.id)
				elsif @cur_user.heir_type == "Teacher"
					@current_user = Teacher.find_by_id(@cur_user.id)
				end
			end
		end

		def set_assemble
			@assemble = Assemble.find(1)
		end	
end
