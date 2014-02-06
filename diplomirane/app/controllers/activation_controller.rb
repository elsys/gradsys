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
			  	@usr.lost_password = "false"
			  	@usr.save
			  	redirect_to login_url, :alert => "Password was successfully saved, you can now login."
			else
			  	redirect_to activation_url, :alert => "Password conformation missmatch."
			end
		else
			redirect_to activation_url, :alert => "Password can't be blank."
		end		  		 	  				
  end

  def lost_password
  end

  def change_lost_password
    @email = params[:email]
    if !@email.blank?
      if @u = User.find_by_user_name(@email)
        @u.lost_password =  "true"
        @u.change_activation_code
        @u.save
        #UserMailer.lost_password(@u,"#{@u.activation_code}").deliver
        redirect_to login_url, :alert => "Reset successful. Please check your email." 
      else
         redirect_to lost_password_url, :alert => "No user with that email." 
      end 
    else
     redirect_to lost_password_url, :alert => "Email can't be blank."
    end   
  end
end
