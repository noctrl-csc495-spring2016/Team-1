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
            redirect_to pickups_path
        end
    end
    
    def admin_or_standard
        if !is_user_admin? && !is_user_reg?
            flash[:danger] = "Permission denied."
            redirect_to pickups_path
        end
    end
    
    # Redirects the user to the login page if they are not logged in.
    #  This function is intended to be used as a before_action callback.
    def user_logged_in
        if user_active.nil?
            flash[:danger] = "User has not been logged in."
            redirect_to login_url
        end
    end
    
    # This will remove the user_id from the session. Redirecting to the
    #  home (login) page is left as a task for the calling code.
    def log_out
        # Delete the user_id token from the session
        session.delete(:user_id)
        # Set the current user to nil, so that nothing else operates on the
        #  (now mistaken) assumption that the user is still logged in.
        @user_active = nil
    end
    
    def should_view_user(uid)
        if user_active.id != uid && !is_user_admin?
            flash[:danger] = "Permission denied."
            redirect_to '/home/home1'
        end
    end
end
