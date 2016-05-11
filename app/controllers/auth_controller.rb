class AuthController < ApplicationController
  
  before_action :user_signed_in, only: [:destroy]

  # Signs the user in
  def create
    
    # Fetch the user using their provided identifier
    user = User.find_by(user_id: params[:session][:user_id])
    
    # Redirect to home page if user authenticates
    if user && user.authenticate(params[:session][:password])
      
      sign_in user
      flash[:success] = "Logged in as #{user.user_name}"
      redirect_to 'home/home1'
      
    else
      flash.now[:danger] = 'Username/Password invalid.'
      render 'new'
    end
  end
  
  def new
    if logged_in?
      redirect_to 'home/home1'
    end
  end
  
  # Signs the user out
  def destroy
    
    sign_out
    flash[:success] = "Log out successful."
    redirect_to '/login'
  end
end