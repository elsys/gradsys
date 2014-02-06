require 'digest/sha2'
require 'securerandom'
class Student < ActiveRecord::Base
	child_of :user
	belongs_to :diploma_work
  	
  validates_presence_of :number
	validates_inclusion_of :grade, :in => ["12a","12b","12v","12g"] 
	validates :diploma_work_id,	:numericality => true, :unless => lambda { self.diploma_work_id.nil? }
	validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_accessor :current_password
  attr_reader   :password
  validate :current_password_must_match, :unless => lambda { !self.hashed_password.nil?  }

  def Student.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "interesno" + salt)
  end
  
  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def current_user=(current_user)
    @current_user = current_user
  end 
  
  private

    def current_password_must_match
      if !@current_user.admin?
        if self.current_password.present?
          errors.add(:current_password, "mismatch") unless User.authenticate(self.user_name, self.current_password)
        else  
          errors.add(:current_password, "is blank")       
        end
      end
    end
  
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

		
end
