class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def create_user_session(user)
  	session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
  	if session[:user_id].blank?
  		redirect_to signin_path
  	end
  end

  helper_method :current_user
end