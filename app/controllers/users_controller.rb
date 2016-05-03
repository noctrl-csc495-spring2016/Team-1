class UsersController < ApplicationController
    
  def admin1
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Acount created!"
      redirect_to action: 'admin1'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
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
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to action: 'admin1'
  end

  private

    def user_params
      params.require(:user).permit(:user_id, :user_name, :user_email, :user_password_digest,
                                   :permission_level)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
