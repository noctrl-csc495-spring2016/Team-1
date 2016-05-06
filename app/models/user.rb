class User < ActiveRecord::Base
  before_save   :downcase_email
  
  validates :user_id, presence: true
  validates :user_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :user_email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :user_password_digest, presence: true, length: { minimum: 6 }
  validates :permission_level, presence: true
  
  #Enum array for the Select element options for creating/updating users.
  enum permission_level: [:entry, :standard, :admin]
  
  #Ensures user emails are all lower-case.
  def downcase_email
    self.user_email = user_email.downcase
  end
end
