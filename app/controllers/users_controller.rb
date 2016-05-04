class UsersController < ApplicationController
    
  #Default action for the admin home page.  Puts paginated list of users in
  #@users.
  def index
    @users = User.paginate(page: params[:page])
  end
  
  #Shows a user and displays the debugger in a dev environment.
  def show
    @user = User.find(params[:id])
    debugger
  end

  #Creates a variable for a new user to be populated from the form.
  def new
    @user = User.new
  end

  #Creates the new user from the form parameters and saves them to the database,
  #then displays the new list of users.
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Acount created!"
      redirect_to action: 'admin1'
    else
      render 'new'
    end
  end

  #Finds a user to edit.
  def edit
    @user = User.find(params[:id])
  end
  
  #Finds the user to edit and saves the new parameters.
  def update
    @user = User.find(params[:id])
    if params[:user][:user_password_digest].empty?
      @user.errors.add(:user_password_digest, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      flash[:success] = "Password has been reset."
      redirect_to action: 'admin1'
    else
      render 'edit'
    end
  end
  
  #Finds the selected user and removes them from the database.
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to action: 'admin1'
  end

  private

    #Defines the parameters to be used when creating/updating a user.
    def user_params
      params.require(:user).permit(:user_id, :user_name, :user_email, :user_password_digest,
                                   :permission_level)
    end
    
    #Verifies that the page being accessed belongs to the current user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    #Verifies that the user is an admin.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
