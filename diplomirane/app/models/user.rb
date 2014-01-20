class User < ActiveRecord::Base
	acts_as_predecessor :exposes => :admin?
	validates :user_name, :presence => true, :uniqueness => true

  validates :password, :confirmation => true

  attr_accessor :password_confirmation
  attr_reader   :password

  validate  :password_must_be_present
  

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
 
  # 'password' is a virtual attribute
  def password=(password)
  	@password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  
  private

    def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
  
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end
