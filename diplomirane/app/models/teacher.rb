require 'digest/sha2'
class Teacher < ActiveRecord::Base
	child_of :user
  has_many :diploma_works, foreign_key: "diploma_supervisor_id"
	has_and_belongs_to_many :commissioners, class_name: "DiplomaWork", foreign_key: "commissioner_id", join_table: "commissioners_diploma_works"

	validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password

	validate  :password_must_be_present


  def Teacher.encrypt_password(password, salt)
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
