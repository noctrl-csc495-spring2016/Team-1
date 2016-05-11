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
    
    def logged_in
        user_active != nil
    end
    
    def is_user_admin
        if !is_user_admin?
            flash[:danger] = "Admin access required."
            redirect_to '/pickups'
        end
    end
    
    def admin_or_standard
        if !is_user_admin? && !is_user_reg?
            flash[:danger] = "Permission denied."
            redirect_to 'pickups'
        end
    end
    
    # Go back to the initial sign on page
    def user_logged_in
        if user_active.nil?
            flash[:danger] = "User has not been logged in."
            redirect_to login_url
        end
    end
    
    # Destroys the active users' session, logging them out
    def log_out
        
        session.delete(:user_id)
        @user_active = nil
    end
    
    def should_view_user(uid)
        if user_active.id != uid && !is_user_admin?
            flash[:danger] = "Permission denied."
            redirect_to '/pickups'
        end
    end
end
