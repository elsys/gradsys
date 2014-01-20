class ActivationController < ApplicationController
	skip_before_filter :authorize

  def index			
  end

  def save_password
  	@activation_code = params[:user], 
  	@password = params[:password]
  	@password_comfirmation = params[:"password2"]

	if !@password.blank?
		if @password == @password_comfirmation
		  	@usr = User.find_by_activation_code(@activation_code)
		  	@usr.password = @password
		  	@usr.active = "true"
		  	@usr.save
		  	redirect_to login_url, :alert => "Password was successfully saved, you can now login."
		else
		  	redirect_to activation_url, :alert => "Password conformation missmatch."
		end
	else
		redirect_to activation_url, :alert => "Password can't be blank."
	end		  		 	  				
  end
end
