class UsersController < ApplicationController
  
  before_action :user_signed_in
    
  #Default action for the admin home page.  Puts ordered list of users in
  #@users.
  def index
    @users = User.all.order("UPPER(user_name)")
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
    if params[:user][:user_password_digest] != params[:user][:password_confirmation]
      flash.now[:danger] = "Password and Confirmation must match!"
      render 'new'
    elsif @user.valid? && @user.save
      flash.now[:success] = "Acount created!"
      redirect_to users_index_path
    else
      flash.now[:danger] = "One or more values was left blank!"
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
    
    #If the password text area was blank
    if params[:user][:user_password_digest].empty?
      @user.errors.add(:user_password_digest, "can't be empty")
      flash.now[:danger] = "Password can't be empty!"
      render 'edit'
      
    #If the password confirmation does not match the password
    elsif params[:user][:user_password_digest] != params[:user][:password_confirmation]
      flash.now[:danger] = "Password and Confirmation must match!"
      render 'edit'
      
      
    #If the permission level was blank
    elsif params[:user][:permission_level].empty?
      @user.errors.add(:permission_level, "can't be blank")
      flash.now[:danger] = "Permission level required!"
      render 'edit'
    
    elsif @user.update_attribute(:user_password_digest, params[:user][:user_password_digest]) && @user.update_attribute(:permission_level, params[:user][:permission_level])
      flash.now[:success] = "Profile updated."
      redirect_to users_index_path
    else
      render 'edit'
    end
  end
  
  #Finds the selected user and removes them from the database.
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to action: 'index'
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
