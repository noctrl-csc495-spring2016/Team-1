class User < ActiveRecord::Base
  before_save   :downcase_email
  
  def downcase_email
    self.user_email = user_email.downcase
  end
end
