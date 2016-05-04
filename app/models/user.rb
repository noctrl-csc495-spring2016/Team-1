class User < ActiveRecord::Base
  before_save   :downcase_email
  
  #Enum array for the Select element options for creating/updating users.
  enum permission_level: [:entry, :standard, :admin]
  
  #Ensures user emails are all lower-case.
  def downcase_email
    self.user_email = user_email.downcase
  end
end
