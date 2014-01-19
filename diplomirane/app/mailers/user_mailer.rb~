class UserMailer < ActionMailer::Base
  default from: 'denisav.parvanov@gmail.com'
 
	def welcome_email(user,pass)
    @user = user
		@pass = pass
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to TUES Diplomas')
  end
end
