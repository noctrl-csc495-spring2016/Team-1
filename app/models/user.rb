class User < ActiveRecord::Base
  before_save   :downcase_email
  
  enum permission_level: [:entry, :standard, :admin]
  
  def downcase_email
    self.user_email = user_email.downcase
  end
end
