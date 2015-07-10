class SessionsController < ApplicationController
  before_filter :login_filter, only: [:new, :create]
  before_filter :logout_filter, only: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Successfully logged in"
      redirect_to root_url
    else
      flash.now[:danger] = "Incorrect credentials"
      render :new
    end
  end

  def destroy
    if log_out
      flash[:success] = "You have logged out"
      redirect_to root_url
    else
      flash[:danger] = "Something went wrong"
    end
  end

  private

  def login_filter
    redirect_to root_url and flash[:danger] = "You are already logged in" if logged_in?
  end

  def logout_filter
    redirect_to root_url and flash[:danger] = "Cannot access logout action when you are not logged in" if !logged_in?
  end

end
