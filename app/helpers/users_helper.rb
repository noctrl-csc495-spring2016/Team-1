module UsersHelper
    
    # check for non-admin user type level-1
    def is_user_reg?
        user_active && user_active.permission_level == 1
    end
    
    # check for admin user type level-2
    def is_user_admin?
        user_active && user_active.permission_level == 2
    end
end
