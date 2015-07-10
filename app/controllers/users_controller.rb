class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Registered successfully"
      redirect_to root_url
    else
      flash.now[:danger] = "Form contains errors"
      render :new
    end
  end


  def edit
  end

  def update
  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
