module AuthHelper
    
    include UsersHelper
    
    # Logs in the given user.
    def sign_in(user)
        session[:user_id] = user.id
    end
    
    # Retrieve the current user object
    def user_active
        @user_active ||= User.find_by(id: session[:user_id])
    end
    
    def is_user_admin
        if !is_user_admin?
            flash[:danger] = "Admin access required."
            redirect_to 'home/home1'
        end
    end
    
    def admin_or_standard
        if !is_user_admin? && !is_user_reg?
            flash[:danger] = "Permission denied."
            redirect_to 'home/home1'
        end
    end
    
    # Go back to the initial sign on page
    def user_logged_in
        if user_active.nil?
            flash[:danger] = "User has not been logged in."
            redirect_to login_url
        end
    end

    
    def should_view_user(uid)
        if user_active.id != uid && !is_user_admin?
            flash[:danger] = "Permission denied."
            redirect_to '/home/home1'
        end
    end
    
    # Destroys the active users' session, logging them out
    def sign_out
        
        session.delete(:user_id)
        @user_active = nil
    end
    
    def encrypt(passcode)
        #Bcrypt::sha1(passcode);
    end
    
    def decrypt(passcode)
        #Bcrypt::sha1(passcode);
    end
end
