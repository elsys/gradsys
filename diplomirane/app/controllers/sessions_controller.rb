class SessionsController < ApplicationController
  skip_before_filter :authorize
  
	def new
  end

  def create
    if !params[:user_name].blank?
      if !params[:password].blank?
        if u =  User.find_by_user_name(params[:user_name])
          if u.active
            if user = User.authenticate(params[:user_name], params[:password])
              session[:user_id] = user.id
              redirect_to admin_url
            else
              redirect_to login_url, :alert => "Invalid user/password combination"
            end
          else 
            redirect_to login_url, :alert => "User is not active"  
          end 
        else
          redirect_to login_url, :alert => "Invalid username"
        end   
      else
        redirect_to login_url, :alert => "Password can't be black"
      end 
    else
      redirect_to login_url, :alert => "User can't be black"
    end  
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_url, :notice => "Logged out"
  end        
end
