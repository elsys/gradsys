class UserMailer < ActionMailer::Base
  default from: 'denisav.parvanov@gmail.com'
 
	def welcome_email(user,activation_code)
    @user = user
		@activation_code = activation_code
    @url  = "http://localhost:3000/"
    @activation_url = "#{@url}activation?code=#{@activation_code}"
    mail(to: @user.user_name, subject: 'Welcome to TUES Diplomas')
  end

  def lost_password(user,activation_code)
    @user = user
		@activation_code = activation_code
    @url  = "http://localhost:3000/"
    @activation_url = "#{@url}activation?code=#{@activation_code}"
    mail(to: @user.user_name, subject: 'Lost passoword for TUES Diplomas')
  end
end
