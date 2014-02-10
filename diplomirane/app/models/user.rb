# encoding: UTF-8
require 'digest/sha2'
require 'securerandom'
class User < ActiveRecord::Base
	acts_as_predecessor :exposes => :admin?

  before_create :generate_activation_code
  
  validates :user_name, :uniqueness => true
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password

  #validate  :password_must_be_present


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
	 self.access == "admin"
  end
 
  # 'password' is a virtual attribute
  def password=(password)
  	@password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def change_activation_code
    generate_activation_code
  end
 
  private

    def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
  
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

    def generate_activation_code
      self.activation_code = self.object_id.to_s + SecureRandom.urlsafe_base64 
    end
end
