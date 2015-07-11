class UsersController < ApplicationController
  before_action :edit_own_profile, only: [:edit, :update]

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      flash.now[:danger] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      log_out
      flash[:success] = "Account deleted."
      redirect_to root_url
    else
      flash[:danger] = "Something went wrong"
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @attended_events = @user.attended_events.paginate(page: params[:page], per_page: 4)
    @created_events = @user.created_events.paginate(page: params[:page], per_page: 4)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def edit_own_profile
    redirect_to root_url and flash[:danger] = "Access denied" if current_user.id.to_s != params[:id].to_s
  end

  def create_user_instance
    @user = User.find(params[:id])
  end

end
