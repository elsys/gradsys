class User < ActiveRecord::Base
	acts_as_predecessor :exposes => :admin?
	validates :user_name, :presence => true, :uniqueness => true

	def User.authenticate(user_name, password)
    if user = find_by_user_name(user_name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

	def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "interesno" + salt)
  end


	def admin?
		if self.access == "admin"
			true
		else
			false
		end
	end
end
