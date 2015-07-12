class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    redirect_to root_url and flash[:danger] = "You are not logged in" if !logged_in?
  end
end
