require 'digest/sha2'
class Student < ActiveRecord::Base
	child_of :user
	belongs_to :diploma_work
  	
  validates_presence_of :number
	validates_inclusion_of :grade, :in => ["12a","12b","12v","12g"] 
	validates :diploma_work_id,	:numericality => true, :unless => lambda { self.diploma_work_id.nil? }

	validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password

	validate  :password_must_be_present

  def Student.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "interesno" + salt)
  end
  
  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
			generate_activation_code
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

		def generate_activation_code
      self.activation_code = self.object_id.to_s + rand.to_s
    end
end
